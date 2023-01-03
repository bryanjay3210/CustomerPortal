import 'package:cp/repository/iot/tv_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/subjects.dart';
import '../../enum.dart';
import '../../model/tv_device/tv_device.dart';
import '../../utils/utils/on_type_functions/debouncer.dart';
import '../main_provider.dart';

class TvProvider {
  final tvDevices$ = BehaviorSubject<DataState>.seeded(DataState.initial);
  var tvDevices = <TvDevice>[];
  var allTvDevices = <TvDevice>[];
  var selectedTvDevice = TvDevice();
  final _filterDebounce = Debouncer(delay: const Duration(milliseconds: 1000));

  getTvs(Map<String, dynamic> map, BuildContext context) async {
    tvDevices$.add(DataState.loading);
    final mainProvider = Provider.of<MainProvider>(context, listen: false);

    map['cid'] = mainProvider.user.CustomerID;
    map['loggedUser'] = mainProvider.user.UserID;
    map['server'] = mainProvider.server;
    Map<String, dynamic> data =
        await TvRepository(map['server']).getTvs(map, context);
    final newItems = <TvDevice>[];
    if (data['rc'] == "E-0000 ok") {
      if (data['device'] == null || data['device'] == '') {
        tvDevices$.add(DataState.empty);
        return;
      } else if (data['device'] is Map) {
        newItems.add(TvDevice.fromJson(data['device']));
      } else {
        data['device'].forEach((element) {
          if (element['Name'] is Map) {
            element['Name'] = '';
          }
          if (element['device_name'] is Map) {
            element['device_name'] = '';
          }
          newItems.add(TvDevice.fromJson(element));
        });
      }
      tvDevices = newItems;
      allTvDevices = newItems;
      tvDevices$.add(DataState.success);
    } else {
      tvDevices$.add(DataState.success);
    }
  }

  updateDeviceTv(Map<String, dynamic> map, BuildContext context,
      VoidCallback callback) async {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    map['deviceId'] = selectedTvDevice.id;
    map['server'] = mainProvider.server;
    map['loggedUser'] = mainProvider.user.UserID;
    tvDevices$.add(DataState.loading);
    Map<String, dynamic> data =
        await TvRepository(map['server']).updateDeviceTv(map, context);
    if (data['rc'] == 'E-0000 ok') {
      await getTvs(map, context);
      if (callback != null) {
        callback();
      }
      tvDevices$.add(DataState.success);
    } else {
      tvDevices$.add(DataState.success);
    }
  }

  addDeviceTv(Map<String, dynamic> map, BuildContext context,
      VoidCallback callback) async {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);

    map['cid'] = mainProvider.user.CustomerID;
    map['loggedUser'] = mainProvider.user.UserID;
    map['server'] = mainProvider.server;

    tvDevices$.add(DataState.loading);
    Map<String, dynamic> data =
        await TvRepository(map['server']).addDeviceTv(map, context);
    if (data['rc'] == 'E-0000 ok') {
      await getTvs(map, context);
      if (callback != null) {
        callback();
      }
      tvDevices$.add(DataState.success);
    } else {
      tvDevices$.add(DataState.success);
    }
  }

  removeDeviceTv(Map<String, dynamic> map, BuildContext context,
      VoidCallback callback) async {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    map['mac'] = selectedTvDevice.mac;
    map['cid'] = mainProvider.user.CustomerID;
    map['loggedUser'] = mainProvider.user.UserID;
    map['server'] = mainProvider.server;

    tvDevices$.add(DataState.loading);
    Map<String, dynamic> data =
        await TvRepository(map['server']).removeDeviceTv(map, context);
    if (data['rc'] == 'E-0000 ok') {
      allTvDevices.removeWhere((element) => element.mac == map['mac']);
      tvDevices.removeWhere((element) => element.mac == map['mac']);
      if (callback != null) {
        callback();
      }
      if (tvDevices.isEmpty) {
        tvDevices$.add(DataState.empty);
      } else {
        tvDevices$.add(DataState.success);
      }
    } else {
      tvDevices$.add(DataState.success);
    }
  }

  filterTvDevices(String text) {
    tvDevices$.add(DataState.loading);
    _filterDebounce.run(() {
      if (text.trim().isEmpty) {
        tvDevices = allTvDevices;
        tvDevices$.add(DataState.success);
        return;
      }
      tvDevices = [
        ...allTvDevices.where((element) =>
            element.mac
                .toString()
                .toLowerCase()
                .trim()
                .contains(text.toLowerCase().trim()) ||
            element.device_name
                .toString()
                .toLowerCase()
                .trim()
                .contains(text.toLowerCase().trim()))
      ];
      if (tvDevices.isEmpty) {
        tvDevices$.add(DataState.empty);
      } else {
        tvDevices$.add(DataState.success);
      }
    });
  }
}

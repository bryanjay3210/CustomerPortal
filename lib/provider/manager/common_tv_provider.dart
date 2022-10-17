import 'package:cp/repository/manager/common_tv_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/subjects.dart';

import '../../enum.dart';
import '../../model/channel/channel.dart';
import '../../model/device_tv/device_tv.dart';
import '../../shared_widgets/toasts.dart';
import '../../utils/utils/on_type_functions/debouncer.dart';
import '../main_provider.dart';
import 'dart:developer' as dev;

class CommonTvProvider {
  final deviceTv$ = BehaviorSubject<DataState>.seeded(DataState.initial);
  final channels$ = BehaviorSubject<DataState>.seeded(DataState.initial);
  var selectedDeviceTv$ = BehaviorSubject<DataState>.seeded(DataState.initial);
  var selectedDeviceTv = DeviceTv();
  var selectedChannel = Channel();
  var channels = <Channel>[];
  var allChannels = <Channel>[];
  var deviceTvs = <DeviceTv>[];
  var allDeviceTvs = <DeviceTv>[];
  var isMounted = true;
  final _debouncer = Debouncer(delay: const Duration(milliseconds: 1000));
  final _locationDebouncer =
      Debouncer(delay: const Duration(milliseconds: 2000));
  var currentSearchKeyword = '';

  onDispose() {
    // deviceTv$.close();
    // channels$.close();
    // selectedDeviceTv$.close();
  }

  getChannels(Map<String, dynamic> map, BuildContext ctx) async {
    channels$.add(DataState.loading);
    final mainProvider = Provider.of<MainProvider>(ctx, listen: false);
    map['server'] = mainProvider.server;
    map['customerId'] = mainProvider.user.CustomerID;
    map['loggedUser'] = mainProvider.user.UserID;
    Map<String, dynamic> data =
        await CommonTvRepository(map['server']).getChannels(map, ctx);
    var newItems = <Channel>[];
    newItems.add(Channel(Name: 'No Channel Name', Number: '0'));
    if (data['status'] == "E-0000 ok") {
      if (data['Channels'] == null) {
        channels$.add(DataState.empty);
        return;
      } else if (data['Channels'] is Map) {
        newItems.add(Channel.fromJson(data['Channels']));
      } else {
        data['Channels'].forEach((element) {
          newItems.add(Channel.fromJson(element));
        });
      }

      allChannels = newItems;
      channels = newItems;
      channels$.add(DataState.success);
    } else {
      channels$.add(DataState.success);
    }

    channels$.add(DataState.success);
  }

  getCommonAreaTvs(Map<String, dynamic> map, BuildContext ctx) async {
    final mainProvider = Provider.of<MainProvider>(ctx, listen: false);
    map['server'] = mainProvider.server;
    map['customerId'] = mainProvider.user.CustomerID;
    map['loggedUser'] = mainProvider.user.UserID;
    Map<String, dynamic> data =
        await CommonTvRepository(map['server']).getCommonAreaTvs(map, ctx);
    if (!isMounted) {
      return;
    }

    var newItems = <DeviceTv>[];
    if (data['status'] == "E-0000 ok") {
      if (data['Devices'] == null) {
        deviceTv$.add(DataState.empty);
        return;
      } else if (data['Devices'] is Map) {
        newItems.add(DeviceTv.fromJson(data['Devices']));
      } else {
        data['Devices'].forEach((element) {
          newItems.add(DeviceTv.fromJson(element));
        });
      }
      deviceTvs = newItems;
      allDeviceTvs = newItems;
      deviceTv$.add(DataState.success);
    } else if (newItems.isEmpty) {
      deviceTv$.add(DataState.empty);
    } else {
      deviceTv$.add(DataState.success);
    }
  }

  filterDeviceTvs(String text) {
    deviceTv$.add(DataState.loading);
    _debouncer.run(() {
      if (text.trim().isEmpty) {
        deviceTvs = allDeviceTvs;
        deviceTv$.add(DataState.success);
        return;
      }
      deviceTvs = [
        ...allDeviceTvs.where((element) =>
            element.Location.toString()
                .toLowerCase()
                .trim()
                .contains(text.toLowerCase().trim()) ||
            element.Channel.toString()
                .toLowerCase()
                .trim()
                .contains(text.toLowerCase().trim()) ||
            getChannel(element)
                .Name
                .toString()
                .toLowerCase()
                .trim()
                .contains(text.toLowerCase().trim()))
      ];

      if (deviceTvs.isEmpty) {
        deviceTv$.add(DataState.empty);
      } else {
        deviceTv$.add(DataState.success);
      }
    });
  }

  Channel getChannel(DeviceTv device) {
    return allChannels.isNotEmpty
        ? allChannels.firstWhere((element) => device.Channel == element.Number)
        : Channel(Name: 'No Channel Name', Number: '0');
  }

  onPowerChange(Map<String, dynamic> map, BuildContext ctx) async {
    final mainProvider = Provider.of<MainProvider>(ctx, listen: false);
    map['server'] = mainProvider.server;
    map['customerId'] = mainProvider.user.CustomerID;
    Map<String, dynamic> data =
        await CommonTvRepository(map['server']).onPowerChange(map, ctx);
    if (data['status'] == "E-0000 OK") {
      deviceTv$.add(DataState.loading);
      final allIdx = allDeviceTvs
          .indexWhere((element) => element.TVID == selectedDeviceTv.TVID);
      allDeviceTvs[allIdx] = selectedDeviceTv;
      final idx = deviceTvs
          .indexWhere((element) => element.TVID == selectedDeviceTv.TVID);
      deviceTvs[idx] = selectedDeviceTv;
      deviceTv$.add(DataState.success);
    }
  }

  onVolumeChange(Map<String, dynamic> map, BuildContext ctx) async {
    await _debouncer.run(() async {
      final mainProvider = Provider.of<MainProvider>(ctx, listen: false);
      map['server'] = mainProvider.server;
      map['cc'] = selectedDeviceTv.CC == '0' ? 'N' : 'Y';
      Map<String, dynamic> data =
          await CommonTvRepository(map['server']).onVolumeChange(map, ctx);
      if (data['status'] == "E-0000 OK") {
        deviceTv$.add(DataState.loading);

        final allIdx = allDeviceTvs
            .indexWhere((element) => element.TVID == selectedDeviceTv.TVID);
        allDeviceTvs[allIdx] = selectedDeviceTv;
        final idx = deviceTvs
            .indexWhere((element) => element.TVID == selectedDeviceTv.TVID);
        deviceTvs[idx] = selectedDeviceTv;
        deviceTv$.add(DataState.success);
      }
    });
  }

  onCaptionChange(Map<String, dynamic> map, BuildContext ctx) async {
    final mainProvider = Provider.of<MainProvider>(ctx, listen: false);
    map['server'] = mainProvider.server;
    Map<String, dynamic> data =
        await CommonTvRepository(map['server']).onCaptionChange(map, ctx);
    if (data['status'] == "E-0000 ok") {
      deviceTv$.add(DataState.loading);

      final allIdx = allDeviceTvs
          .indexWhere((element) => element.TVID == selectedDeviceTv.TVID);
      allDeviceTvs[allIdx] = selectedDeviceTv;
      final idx = deviceTvs
          .indexWhere((element) => element.TVID == selectedDeviceTv.TVID);
      deviceTvs[idx] = selectedDeviceTv;
      deviceTv$.add(DataState.success);
    }
  }

  onChannelChange(Map<String, dynamic> map, BuildContext ctx) async {
    final mainProvider = Provider.of<MainProvider>(ctx, listen: false);
    map['server'] = mainProvider.server;
    map['channel'] = selectedChannel.ID;
    map['mac'] = selectedDeviceTv.MAC;
    Map<String, dynamic> data =
        await CommonTvRepository(map['server']).onChannelChange(map, ctx);
    if (data['status'] == "E-0000 OK") {
      deviceTv$.add(DataState.loading);
      selectedDeviceTv =
          selectedDeviceTv.copyWith(Channel: selectedChannel.Number);

      final allIdx = allDeviceTvs
          .indexWhere((element) => element.TVID == selectedDeviceTv.TVID);
      allDeviceTvs[allIdx] = selectedDeviceTv;
      final idx = deviceTvs
          .indexWhere((element) => element.TVID == selectedDeviceTv.TVID);
      deviceTvs[idx] = selectedDeviceTv;
      deviceTv$.add(DataState.success);
    }
  }

  onLocationNameChange(Map<String, dynamic> map, BuildContext ctx) async {
    await _locationDebouncer.run(() async {
      final mainProvider = Provider.of<MainProvider>(ctx, listen: false);
      map['server'] = mainProvider.server;
      map['location'] = selectedDeviceTv.Location;
      map['tvId'] = selectedDeviceTv.TVID;
      map['mac'] = selectedDeviceTv.MAC;
      deviceTv$.add(DataState.loading);

      if (allDeviceTvs
              .indexWhere((element) => element.Location == map['location']) !=
          -1) {
        deviceTv$.add(DataState.success);
        showToast('Device name already exists, No change applied');
        return;
      }
      Map<String, dynamic> data = await CommonTvRepository(map['server'])
          .onLocationNameChange(map, ctx);
      if (data['status'] == "E-0000 OK") {
        final allIdx = allDeviceTvs
            .indexWhere((element) => element.TVID == selectedDeviceTv.TVID);
        allDeviceTvs[allIdx] = selectedDeviceTv;
        final idx = deviceTvs
            .indexWhere((element) => element.TVID == selectedDeviceTv.TVID);
        deviceTvs[idx] = selectedDeviceTv;
        deviceTv$.add(DataState.success);
      }
    });
  }

  addDevice(Map<String, dynamic> map, BuildContext context,
      VoidCallback callback) async {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    map['server'] = mainProvider.server;
    map['customerId'] = mainProvider.user.CustomerID;
    map['loggedUser'] = mainProvider.user.UserID;
    final tvName = map['device'];

    deviceTv$.add(DataState.loading);
    final idx =
        allDeviceTvs.indexWhere((element) => element.Location == tvName);
    dev.log(idx.toString());

    if (idx != -1) {
      deviceTv$.add(DataState.success);
      showToast('Device name already exists');
      return;
    }
    Map<String, dynamic> data =
        await CommonTvRepository(map['server']).addDevice(map, context);
    if (data['rc'] == 'E-0000 ok') {
      if (idx == -1) {
        await getCommonAreaTvs(map, context);
        filterDeviceTvs(map['searchKeyword']);
        if (callback != null) {
          Navigator.pop(context);
          callback();
        }
        showToast('Device added successfully');
      } else {
        showToast('Device name already exists');
        return;
      }
    } else {
      if (callback != null) {
        callback();
      }
      deviceTv$.add(DataState.success);
    }
  }

  removeTv(Map<String, dynamic> map, BuildContext context,
      VoidCallback callback) async {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    map['server'] = mainProvider.server;
    map['customerId'] = mainProvider.user.CustomerID;
    map['loggedUser'] = mainProvider.user.UserID;
    map['mac'] = selectedDeviceTv.MAC;
    deviceTv$.add(DataState.loading);
    Map<String, dynamic> data =
        await CommonTvRepository(map['server']).removeTv(map, context);
    if (data['status'] == 'E-0000 OK') {
      allDeviceTvs.removeWhere((element) => element.MAC == map['mac']);
      deviceTvs.removeWhere((element) => element.MAC == map['mac']);
      filterDeviceTvs(currentSearchKeyword);
      // Map<String, dynamic> data = await CommonTvRepository(map['server'])
      //     .getCommonAreaTvs(map, context);
      // getWifiUsers(map, context);
      if (callback != null) {
        callback();
      }
    } else {
      // wifiUsers$.add(DataState.error);
    }
    deviceTv$.add(DataState.success);
  }
}

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/subjects.dart';

import '../../enum.dart';
import '../../model/thermostat/thermostat.dart';
import '../../repository/manager/building_repository.dart';
import '../../shared_widgets/toasts.dart';
import '../../utils/utils/on_type_functions/debouncer.dart';
import '../main_provider.dart';

class BuildingProvider {
  var thermostats = <Thermostat>[];
  var allThermostats = <Thermostat>[];
  final thermostats$ = BehaviorSubject<DataState>.seeded(DataState.initial);

  final setpoint$ = BehaviorSubject<DataState>.seeded(DataState.initial);
  var lowerSetpoint = 0.0;
  var upperPoint = 0.0;
  var setPoint = 0.0;

  onDispose() {
    // thermostats$.close();
    // setpoint$.close();
  }

  final _filterDebounce = Debouncer(delay: const Duration(milliseconds: 1500));
  getThermostats(Map<String, dynamic> map, BuildContext context) async {
    thermostats$.add(DataState.loading);
    Map<String, dynamic> data =
        await BuildingRepository(map['server']).getThermostats(map);
    final newItems = <Thermostat>[];
    if (data['Status'] == "Success") {
      if (data['Thermostats'] == null) {
        thermostats$.add(DataState.empty);
        return;
      } else if (data['Thermostats'] is Map) {
        newItems.add(Thermostat.fromJson(data['Thermostats']));
      } else {
        data['Thermostats'].forEach((element) {
          if (element['ThingID'] is Map) {
            element['ThingID'] = '';
          }
          if (element['UnitID'] is Map) {
            element['UnitID'] = '';
          }
          if (element['Mode'] is Map) {
            element['Mode'] = '';
          }
          if (element['ModeLink'] is Map) {
            element['ModeLink'] = '';
          }
          if (element['RoomTemp'] is Map) {
            element['RoomTemp'] = '';
          }
          if (element['RoomTempLink'] is Map) {
            element['RoomTempLink'] = '';
          }
          if (element['Setpoint'] is Map) {
            element['Setpoint'] = '';
          }
          if (element['SetpointLink'] is Map) {
            element['SetpointLink'] = '';
          }
          if (element['SetpointCtrl'] is Map) {
            element['SetpointCtrl'] = '';
          }
          if (element['SetpointCtrlLink'] is Map) {
            element['SetpointCtrlLink'] = '';
          }
          newItems.add(Thermostat.fromJson(element));
        });
      }
      thermostats = newItems;
      allThermostats = newItems;
      thermostats$.add(DataState.success);
    } else {
      thermostats$.add(DataState.success);
    }
  }

  filterThermostats(String text) {
    thermostats$.add(DataState.loading);
    _filterDebounce.run(() {
      if (text.trim().isEmpty) {
        thermostats = allThermostats;
        thermostats$.add(DataState.success);
        return;
      }
      thermostats = [
        ...allThermostats.where((element) => element.UnitName.toString()
            .toLowerCase()
            .trim()
            .contains(text.toLowerCase().trim()))
      ];
      if (thermostats.isEmpty) {
        thermostats$.add(DataState.empty);
      } else {
        thermostats$.add(DataState.success);
      }
    });
  }

  changeStatus(Map<String, dynamic> map, String newStatus, int idx2,
      BuildContext ctx) async {
    thermostats[idx2] = thermostats[idx2].copyWith(AptStatus: newStatus);

    final thermo = thermostats[idx2];
    map['unitId'] = thermo.UnitID;
    map['modeLink'] = thermo.ModeLink;
    map['setPointLink'] = thermo.SetpointLink;
    map['unitState'] = thermo.AptStatus;
    Map<String, dynamic> data =
        await BuildingRepository(map['server']).updateThermostat(map, ctx);
    if (data['Status'] == 'Success') {
      showToast('Thermostat updated Successfully');
    }
  }

  getGlobalSetpoint(BuildContext ctx) async {
    setpoint$.add(DataState.loading);
    Map<String, dynamic> map = {};
    final mainProvider = Provider.of<MainProvider>(ctx, listen: false);
    map['buildingId'] = mainProvider.user.BuildingID;
    map['server'] = mainProvider.server;
    Map<String, dynamic> data =
        await BuildingRepository(map['server']).getGlobalSetpoint(map, ctx);
    if (data['Status'] == 'Success') {
      if (data['OccupiedLowerSetpoint'] != null) {
        lowerSetpoint = double.parse(data['OccupiedLowerSetpoint']);
      }
      if (data['OccupiedUpperSetpoint'] != null) {
        upperPoint = double.parse(data['OccupiedUpperSetpoint']);
      }
      if (data['VacantSetpoint'] != null) {
        setPoint = double.parse(data['VacantSetpoint']);
      }
    }
    setpoint$.add(DataState.success);
  }

  setGlobalSetpoint(BuildContext ctx) async {
    setpoint$.add(DataState.loading);
    Map<String, dynamic> map = {};
    final mainProvider = Provider.of<MainProvider>(ctx, listen: false);
    map['buildingId'] = mainProvider.user.BuildingID;
    map['server'] = mainProvider.server;
    map['loggedIn'] = mainProvider.user.UserID;
    map['vacantSetpoint'] = setPoint;
    map['occupiedLowerSetpoint'] = lowerSetpoint;
    map['occupiedUpperSetpoint'] = upperPoint;
    Map<String, dynamic> data =
        await BuildingRepository(map['server']).setGlobalSetpoint(map, ctx);
    if (data['Status'] == 'Success') {
      showToast('Global Setpoint was Succesfully updated');
    }
    setpoint$.add(DataState.success);
  }
}

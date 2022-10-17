import 'package:cp/service/api_request.dart';
import 'package:flutter/widgets.dart';

class BuildingRepository extends RequestApi {
  BuildingRepository(int server) : super(server);

  dynamic getThermostats(Map<String, dynamic> map) async {
    dynamic dataUrl = {
      "Command": "Building",
      "Subcommand1": "DeviceMgmt",
      "Subcommand2": "Thermostats",
      "Subcommand3": "List",
      "BuildingID": map['buildingId'],
      "LoggedUser": map['loggedUser'],
    };
    return await getApi(dataUrl, type: 'iot');
  }

  dynamic updateThermostat(
      Map<String, dynamic> map, BuildContext context) async {
    dynamic dataUrl = {
      "Command": "Building",
      "Subcommand1": "DeviceMgmt",
      "Subcommand2": "Thermostats",
      "Subcommand3": "ChangeUnitStatus",
      "BuildingID": map['buildingId'],
      "UnitID": map['unitId'],
      "ModeLink": map['modeLink'],
      "SetpointLink": map['setPointLink'],
      "UnitState": map['unitState'],
      "LoggedIn": map['loggedIn']
    };
    return await getApi(dataUrl, type: 'iot', context: context);
  }

  dynamic getGlobalSetpoint(
      Map<String, dynamic> map, BuildContext context) async {
    dynamic dataUrl = {
      "Command": "Building",
      "Subcommand1": "DeviceMgmt",
      "Subcommand2": "Thermostats",
      "Subcommand3": "GetGlobalSetpoints",
      "BuildingID": map["buildingId"]
    };
    return await getApi(dataUrl, type: 'iot', context: context);
  }

  dynamic setGlobalSetpoint(
      Map<String, dynamic> map, BuildContext context) async {
    dynamic dataUrl = {
      "Command": "Building",
      "Subcommand1": "DeviceMgmt",
      "Subcommand2": "Thermostats",
      "Subcommand3": "SetGlobalSetpoints",
      "BuildingID": map['buildingId'],
      "VacantSetpoint": map["vacantSetpoint"],
      "OccupiedLowerSetpoint": map["occupiedLowerSetpoint"],
      "OccupiedUpperSetpoint": map["occupiedUpperSetpoint"],
      "LoggedIn": map['loggedIn']
    };
    return await getApi(dataUrl, type: 'iot', context: context);
  }
}

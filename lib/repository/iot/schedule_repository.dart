import 'package:cp/service/api_request.dart';
import 'package:flutter/widgets.dart';

class ScheduleRepository extends RequestApi {
  ScheduleRepository(int server) : super(server);

  dynamic setSchedule(Map<String, dynamic> map, BuildContext context) async {
    dynamic dataUrl = {
      "Command": "Schedule",
      "Subcommand1": map['subCommand1'],
      "CustomerID": map['customerId'],
      "UnitID": map['unitId'],
      "SceneID": map["sceneId"],
      "DayList": map["dayList"],
      "Time": map['time'],
      "ScheduleID": map['scheduleId']
    };
    return await getApi(dataUrl, type: 'iot', context: context);
  }

  dynamic getSchedules(Map<String, dynamic> map) async {
    dynamic dataUrl = {
      "Command": "Schedule",
      "Subcommand1": "Fetch",
      "CustomerID": map['customerId'],
      "UnitID": map['unitId'],
      "SceneID": map['sceneId']
    };
    return await getApi(dataUrl, type: 'iot');
  }
}

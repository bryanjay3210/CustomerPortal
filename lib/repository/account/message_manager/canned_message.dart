import 'package:cp/service/api_request.dart';
import 'package:flutter/widgets.dart';

class CannedMessageRepository extends RequestApi {
  CannedMessageRepository(int server) : super(server);

  dynamic getBuildings(Map<String, dynamic> map, BuildContext context) async {
    dynamic dataUrl = {
      "Command": "Building",
      "Subcommand1": "List",
      "LoggedUser": map['loggedUser']
    };
    return await getApi(dataUrl, context: context);
  }

  dynamic getCannedRequests(
      Map<String, dynamic> map, BuildContext context) async {
    dynamic dataUrl = {
      "Command": "Message",
      "Subcommand1": "CannedRequest",
      "Subcommand2": "List",
      "BuildingID": map["buildingId"],
      "LoggedUser": map["loggedUser"]
    };
    return await getApi(dataUrl, context: context);
  }

  dynamic getRequestTargets(
      Map<String, dynamic> map, BuildContext context) async {
    dynamic dataUrl = {
      "Command": "Message",
      "Subcommand1": "GetContactOptionsList",
      "BuildingID": map["buildingId"],
      "AvailableOnly": "N",
      "LoggedUser": map["loggedUser"]
    };
    return await getApi(dataUrl, context: context);
  }

  dynamic createCannedRequest(
      Map<String, dynamic> map, BuildContext context) async {
    dynamic dataUrl = {
      "Command": "Message",
      "Subcommand1": "CannedRequest",
      "Subcommand2": "Add",
      "BuildingID": map["buildingId"],
      "RequestTitle": map['requestTitle'],
      "RequestTarget": map['requestTarget'],
      "LoggedUser": map['loggedUser']
    };
    return await getApi(dataUrl, context: context);
  }

  dynamic updateCannedRequest(
      Map<String, dynamic> map, BuildContext context) async {
    dynamic dataUrl = {
      "Command": "Message",
      "Subcommand1": "CannedRequest",
      "Subcommand2": "Update",
      "RequestID": map["requestId"],
      "BuildingID": map["buildingId"],
      "RequestTitle": map['requestTitle'],
      "RequestTarget": map['requestTarget'],
      "LoggedUser": map['loggedUser']
    };
    return await getApi(dataUrl, context: context);
  }

  dynamic removeCannedRequest(
      Map<String, dynamic> map, BuildContext context) async {
    dynamic dataUrl = {
      "Command": "Message",
      "Subcommand1": "CannedRequest",
      "Subcommand2": "Remove",
      "RequestID": map["requestId"],
      "LoggedUser": map['loggedUser']
    };
    return await getApi(dataUrl, context: context);
  }
}

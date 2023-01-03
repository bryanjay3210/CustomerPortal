import 'package:cp/service/api_request.dart';
import 'package:flutter/widgets.dart';

class SendMessageRepository extends RequestApi {
  SendMessageRepository(int server) : super(server);

  dynamic getBuildings(Map<String, dynamic> map, BuildContext context) async {
    dynamic dataUrl = {
      "Command": "Building",
      "Subcommand1": "List",
      "LoggedUser": map['loggedUser']
    };
    return await getApi(dataUrl, context: context);
  }

  dynamic getMessageGroups(
      Map<String, dynamic> map, BuildContext context) async {
    dynamic dataUrl = {
      "Command": "Message",
      "Subcommand1": "Groups",
      "Subcommand2": "List",
      "BuildingID": map["buildingId"],
      "LoggedUser": map["loggedUser"]
    };
    return await getApi(dataUrl, context: context);
  }

  dynamic getGroupDetails(
      Map<String, dynamic> map, BuildContext context) async {
    dynamic dataUrl = {
      "Command": "Message",
      "Subcommand1": "Group",
      "Subcommand2": "ListAccess",
      "GroupID": map["groupId"],
      "LoggedUser": map["loggedUser"]
    };
    return await getApi(dataUrl, context: context);
  }

  dynamic sendMessage(Map<String, dynamic> map, BuildContext context) async {
    dynamic dataUrl = {
      "Command": "Message",
      "Subcommand1": "Send",
      "SendGroup": map['sendGroup'],
      "Template": map["template"],
      "SendList": map['sendList'],
      "SendText": map['sendText'],
      "Subject": map['subject'],
      "LoggedUser": map['loggedUser']
    };
    return await getApi(dataUrl, context: context);
  }
}

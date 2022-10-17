import 'package:cp/service/api_request.dart';
import 'package:flutter/widgets.dart';

class MessageGroupRepository extends RequestApi {
  MessageGroupRepository(int server) : super(server);

  dynamic getBuildings(Map<String, dynamic> map, BuildContext context) async {
    dynamic dataUrl = {
      "Command": "Building",
      "Subcommand1": "List",
      "LoggedUser": map['loggedUser']
    };
    return await getApi(dataUrl);
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
    return await getApi(dataUrl);
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
    return await getApi(dataUrl);
  }

  dynamic getModerators(Map<String, dynamic> map, BuildContext context) async {
    dynamic dataUrl = {
      "Command": "User",
      "Subcommand1": "List",
      "Status": "Active",
      "Type": "Support",
      'LoggedUser': map['loggedUser']
    };
    return await getApi(dataUrl);
  }

  dynamic getCustomers(Map<String, dynamic> map, BuildContext context) async {
    dynamic dataUrl = {
      "Command": "Customer",
      "Subcommand1": "List",
      "BuildingID": map['buildingId'],
      "LoggedUser": map['loggedUser']
    };
    return await getApi(dataUrl, type: 'iot');
  }

  dynamic setStatus(Map<String, dynamic> map, BuildContext context) async {
    dynamic dataUrl = {
      "Command": "Message",
      "Subcommand1": "SetStatus",
      "MessageID": map['messageID'],
      "NewStatus": map['newStatus'],
      'LoggedUser': map['userId'],
    };
    return await getApi(dataUrl);
  }

  dynamic createMessageGroup(
      Map<String, dynamic> map, BuildContext context) async {
    dynamic dataUrl = {
      "Command": "Message",
      "Subcommand1": "Groups",
      "Subcommand2": "Create",
      "BuildingID": map["buildingId"],
      "GroupName": map["groupName"],
      "CanReply": map["canReply"],
      "GroupDesc": map["groupDesc"],
      "GroupType": map["groupType"],
      "GroupAccess": map['groupAccess'],
      "DefaultAcceptMsg": map["defaultAcceptMsg"],
      "DefaultRejectMsg": map["defaultRejectMsg"],
      "ReplyEmail": map["replyEmail"],
      "ModeratorsEmail": map["moderatorsEmail"],
      "ModeratorCustomerID": map["moderatorCustomerId"],
      "ModeratorUserID": map["moderatorUserId"],
      "CustomerList": map['customerList'],
      "LoggedUser": map['loggedUser']
    };
    return await getApi(dataUrl);
  }

  dynamic updateMessageGroup(
      Map<String, dynamic> map, BuildContext context) async {
    dynamic dataUrl = {
      "Command": "Message",
      "Subcommand1": "Groups",
      "Subcommand2": "Update",
      "GroupID": map['groupId'],
      "BuildingID": map["buildingId"],
      "GroupName": map["groupName"],
      "CanReply": map["canReply"],
      "GroupDesc": map["groupDesc"],
      "GroupType": map["groupType"],
      "GroupAccess": map['groupAccess'],
      "DefaultAcceptMsg": map["defaultAcceptMsg"],
      "DefaultRejectMsg": map["defaultRejectMsg"],
      "ReplyEmail": map["replyEmail"],
      "ModeratorsEmail": map["moderatorsEmail"],
      "ModeratorCustomerID": map["moderatorCustomerId"],
      "ModeratorUserID": map["moderatorUserId"],
      "CustomerList": map['customerList'],
      "LoggedUser": map['loggedUser']
    };
    return await getApi(dataUrl);
  }

  dynamic removeGroup(Map<String, dynamic> map, BuildContext context) async {
    dynamic dataUrl = {
      "Command": "Message",
      "Subcommand1": "Groups",
      "Subcommand2": "Remove",
      "GroupID": map['groupId'],
      "LoggedUser": map['loggedUser']
    };
    return await getApi(dataUrl);
  }
}

import 'package:cp/service/api_request.dart';

class MessageGroupRepository extends RequestApi {
  MessageGroupRepository(int server) : super(server);

  dynamic getMessageGroupList(Map<String, dynamic> map) async {
    dynamic dataUrl = {
      "Command": "Message",
      "Subcommand1": "ResidentGroups",
      "Subcommand2": 'List',
      'ResidentID': map['residentID'],
      'UnitID': map['unitID'],
      'LoggedUser': map['userId'],
    };
    return await getApi(dataUrl);
  }

  dynamic joinGroup(Map<String, dynamic> map) async {
    dynamic dataUrl = {
      "Command": "Message",
      "Subcommand1": "ResidentGroups",
      "Subcommand2": 'Join',
      'ResidentID': map['residentID'],
      'UnitID': map['unitID'],
      'GroupID': map['groupID'],
      'AccessComment': map['accessComment'],
      'LoggedUser': map['userId'],
    };
    return await getApi(dataUrl);
  }

  dynamic leaveGroup(Map<String, dynamic> map) async {
    dynamic dataUrl = {
      "Command": "Message",
      "Subcommand1": "ResidentGroups",
      "Subcommand2": 'Leave',
      'ResidentID': map['residentID'],
      'UnitID': map['unitID'],
      'GroupID': map['groupID'],
      'LoggedUser': map['userId'],
    };
    return await getApi(dataUrl);
  }

}
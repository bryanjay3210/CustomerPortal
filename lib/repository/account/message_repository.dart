import 'package:cp/service/api_request.dart';

class MessageRepository extends RequestApi {
  MessageRepository(int server) : super(server);

  dynamic getMessages(Map<String, dynamic> map) async {
    dynamic dataUrl = {
      "Command": "Message",
      "Subcommand1": "PollMessage",
      "Subcommand2": map['pollType'],
      "CustomerID": map['customerID'],
      'LoggedUser': map['userId'],
    };
    return await getApi(dataUrl, type: 'iot');
  }

  dynamic sendMessages(Map<String, dynamic> map) async {
    dynamic dataUrl = {
      "Command": "Message",
      "Subcommand1": "SendMessage",
      "TargetID": map['targetID'],
      "Subject": map['subject'],
      "Message": map['message'],
      'LoggedUser': map['userId'],
    };
    return await getApi(dataUrl, type: 'iot');
  }

  dynamic getSentMessages(Map<String, dynamic> map) async {
    dynamic dataUrl = {
      "Command": "Message",
      "Subcommand1": "PollMessage",
      "Subcommand2": "Sent",
      "CustomerID": map['customerID'],
      'LoggedUser': map['userId'],
    };
    return await getApi(dataUrl, type: 'iot');
  }

  dynamic getMessagesUnreadCount(Map<String, dynamic> map) async {
    dynamic dataUrl = {
      "Command": "Message",
      "Subcommand1": "UnreadCount",
      "CustomerID": map['customerID'],
      'LoggedUser': map['userId'],
    };
    return await getApi(dataUrl);
  }

  dynamic changeMessageStatus(Map<String, dynamic> map) async {
    dynamic dataUrl = {
      "Command": "Message",
      "Subcommand1": "SetStatus",
      "MessageID": map['messageID'],
      "NewStatus": map['newStatus'],
      'LoggedUser': map['userId'],
    };
    return await getApi(dataUrl, type: 'iot');
  }

}
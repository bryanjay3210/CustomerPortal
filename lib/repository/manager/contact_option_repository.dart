import 'package:cp/service/api_request.dart';
import 'package:flutter/widgets.dart';

class ContactOptionRepository extends RequestApi {
  ContactOptionRepository(int server) : super(server);

  dynamic getCellProviders(
      Map<String, dynamic> map, BuildContext context) async {
    dynamic dataUrl = {
      "Command": "Message",
      "Subcommand1": "FetchCellProviders",
      "LoggedUser": map['loggedUser']
    };
    return await getApi(dataUrl, context: context);
  }

  dynamic getContactOption(
      Map<String, dynamic> map, BuildContext context) async {
    dynamic dataUrl = {
      "Command": "Message",
      "Subcommand1": "GetContactOptions",
      "CustomerID": map['customerId'],
      "LoggedUser": map['loggedUser']
    };
    return await getApi(dataUrl, context: context);
  }

  dynamic createContactOption(
      Map<String, dynamic> map, BuildContext context) async {
    dynamic dataUrl = {
      "Command": "Message",
      "Subcommand1": "ResidentContactOptions",
      "ResidentID": map['residentId'],
      "InAppDelivery": map["inAppDelivery"],
      "EmailDelivery": map["emailDelivery"],
      "SMSDelivery": map["smsDelivery"],
      "CellProviderID": map['cellProviderId'],
      "LoggedUser": map['loggedUser']
    };
    return await getApi(dataUrl, context: context);
  }
}

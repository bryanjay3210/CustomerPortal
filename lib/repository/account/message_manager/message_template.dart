import 'package:cp/service/api_request.dart';
import 'package:flutter/widgets.dart';

class MessageTemplateRepository extends RequestApi {
  MessageTemplateRepository(int server) : super(server);

  dynamic getBuildings(Map<String, dynamic> map, BuildContext context) async {
    dynamic dataUrl = {
      "Command": "Building",
      "Subcommand1": "List",
      "LoggedUser": map['loggedUser']
    };
    return await getApi(dataUrl, context: context);
  }

  dynamic getTemplates(Map<String, dynamic> map, BuildContext context) async {
    dynamic dataUrl = {
      "Command": "Message",
      "Subcommand1": "Template",
      "Subcommand2": "List",
      "BuildingID": map["buildingId"],
      "LoggedUser": map["loggedUser"],
    };
    return await getApi(dataUrl, context: context);
  }

  dynamic getTemplateVariables(
      Map<String, dynamic> map, BuildContext context) async {
    dynamic dataUrl = {
      "Command": "Message",
      "Subcommand1": "Template",
      "Subcommand2": "VariablesList",
      "BuildingID": map["buildingId"],
      "LoggedUser": map["loggedUser"]
    };
    return await getApi(dataUrl, context: context);
  }

// [307640,307814,307824],"
  dynamic createTemplate(Map<String, dynamic> map, BuildContext context) async {
    dynamic dataUrl = {
      "Command": "Message",
      "Subcommand1": "Template",
      "Subcommand2": "Create",
      "BuildingID": map["buildingId"],
      "TemplateName": map["templateName"],
      "TemplateText": map["templateText"],
      "LoggedUser": map['loggedUser']
    };
    return await getApi(dataUrl, context: context);
  }

  dynamic updateTemplate(Map<String, dynamic> map, BuildContext context) async {
    dynamic dataUrl = {
      "Command": "Message",
      "Subcommand1": "Template",
      "Subcommand2": "Update",
      "BuildingID": map["buildingId"],
      "TemplateID": map["templateId"],
      "TemplateName": map["templateName"],
      "TemplateText": map["templateText"],
      "LoggedUser": map['loggedUser']
    };
    ;
    return await getApi(dataUrl, context: context);
  }

  dynamic removeTemplate(Map<String, dynamic> map, BuildContext context) async {
    dynamic dataUrl = {
      "Command": "Message",
      "Subcommand1": "Template",
      "Subcommand2": "Remove",
      "TemplateID": map['templateId'],
      "LoggedUser": map['loggedUser']
    };
    return await getApi(dataUrl, context: context);
  }
}

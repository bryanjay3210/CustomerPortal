import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/subjects.dart';

import '../../../enum.dart';
import '../../../model/building/building.dart';
import '../../../model/message_template/message_template.dart';
import '../../../model/message_template_variable/message_template_variable.dart';
import '../../../repository/account/message_manager/message_template.dart';
import '../../../shared_widgets/toasts.dart';
import '../../../utils/utils/on_type_functions/debouncer.dart';
import '../../main_provider.dart';

class MessageTemplateProvider {
  final _filterDebounce = Debouncer(delay: const Duration(milliseconds: 1000));
  final messageTemplates$ = BehaviorSubject<DataState>.seeded(DataState.empty);
  final messageTemplateDetail$ =
      BehaviorSubject<DataState>.seeded(DataState.empty);
  final templateVariable$ = BehaviorSubject<DataState>.seeded(DataState.empty);
  var buildingDetail = Building();
  var templates = <MessageTemplate>[];
  var allTemplates = <MessageTemplate>[];
  var templateVariables = <MessageTemplateVariable>[];
  var selectedTemplate = MessageTemplate();
  var keywordSearch = '';

  getTemplates(Map<String, dynamic> map, BuildContext context) async {
    messageTemplates$.add(DataState.loading);
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    map['server'] = mainProvider.server.toString();
    map['loggedUser'] = mainProvider.user.UserID;
    map['buildingId'] = mainProvider.user.BuildingID;
    Map<String, dynamic> data =
        await MessageTemplateRepository(int.parse(map['server']))
            .getTemplates(map, context);
    final newItems = <MessageTemplate>[];
    if (data['Status'] == "Success") {
      if (data['Templates'] == null) {
        messageTemplates$.add(DataState.empty);
        return;
      } else if (data['Templates'] is Map) {
        newItems.add(MessageTemplate.fromJson(data['Templates']));
      } else {
        data['Templates'].forEach((element) {
          newItems.add(MessageTemplate.fromJson(element));
        });
      }
      allTemplates = newItems;
      templates = newItems;
      filterMessageTemplate(keywordSearch);
    } else {
      messageTemplates$.add(DataState.success);
    }
  }

  bool isCreate() {
    return selectedTemplate.TemplateID == '';
  }

  getTemplateVariable(Map<String, dynamic> map, BuildContext context) async {
    templateVariable$.add(DataState.loading);
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    map['server'] = mainProvider.server;
    map['loggedUser'] = mainProvider.user.UserID;
    map['buildingId'] = mainProvider.user.BuildingID;
    Map<String, dynamic> data = await MessageTemplateRepository(map['server'])
        .getTemplateVariables(map, context);
    final newItems = <MessageTemplateVariable>[];
    if (data['Status'] == "Success") {
      if (data['Variables'] == null) {
        templateVariable$.add(DataState.empty);
        return;
      } else if (data['Variables'] is Map) {
        newItems.add(MessageTemplateVariable.fromJson(data['Variables']));
      } else {
        data['Variables'].forEach((element) {
          if (element['VariableSub'] is Map) {
            element['VariableSub'] = '';
          }
          if (element['VariableName'] is Map) {
            element['VariableName'] = '';
          }
          newItems.add(MessageTemplateVariable.fromJson(element));
        });
      }
      templateVariables = newItems;
    }
    templateVariable$.add(DataState.success);
  }

  createMessageTemplate(Map<String, dynamic> map, BuildContext context) async {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    map['server'] = mainProvider.server.toString();
    map['buildingId'] = mainProvider.user.BuildingID;
    map['loggedUser'] = mainProvider.user.UserID;
    Map<String, dynamic> data =
        await MessageTemplateRepository(int.parse(map['server']))
            .createTemplate(map, context);
    if (data['Status'] == "Success") {
      getTemplates(map, context);
    }
  }

  updateMessageTemplate(Map<String, dynamic> map, BuildContext context) async {
    // rooms$.add(DataState.loading);
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    map['server'] = mainProvider.server.toString();
    map['templateId'] = selectedTemplate.TemplateID;
    map['buildingId'] = mainProvider.user.BuildingID;
    map['loggedUser'] = mainProvider.user.UserID;
    Map<String, dynamic> data =
        await MessageTemplateRepository(int.parse(map['server']))
            .updateTemplate(map, context);
    if (data['Status'] == "Success") {
      await getTemplates(map, context);
    }
    // await getRooms(map, context);
    // rooms$.add(DataState.success);
  }

  removeTemplate(Map<String, dynamic> map, BuildContext context) async {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    map['server'] = mainProvider.server;
    map['templateId'] = selectedTemplate.TemplateID;
    map['loggedUser'] = mainProvider.user.UserID;
    Map<String, dynamic> data = await MessageTemplateRepository(map['server'])
        .removeTemplate(map, context);
    if (data['Status'] == 'Success') {
      showToast('Messasge Template Successfully Deleted');
      Navigator.of(context).pop();
      getTemplates(map, context);
    }
  }

  filterMessageTemplate(String text) {
    messageTemplates$.add(DataState.loading);
    _filterDebounce.run(() {
      if (text.trim().isEmpty) {
        templates = allTemplates;
        messageTemplates$.add(DataState.success);
        return;
      }
      templates = [
        ...allTemplates.where((element) => element.TemplateName.toString()
            .toLowerCase()
            .trim()
            .contains(text.toLowerCase().trim()))
      ];

      if (templates.isEmpty) {
        messageTemplates$.add(DataState.empty);
      } else {
        messageTemplates$.add(DataState.success);
      }
    });
  }
}

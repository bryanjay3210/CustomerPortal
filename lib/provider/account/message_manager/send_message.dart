import 'package:cp/model/customer_message_group/customer_message_group.dart';
import 'package:cp/model/message_template_widget/message_template_widget.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

import '../../../enum.dart';
import '../../../model/message_group/message_group.dart';
import '../../../repository/account/message_manager/send_message.dart';
import '../../../shared_widgets/toasts.dart';
import '../../main_provider.dart';

class SendMessageProvider {
  var currentMessageGroups = <MessageGroup>[];
  var currentCustomers = <CustomerMessageGroup>[];
  final messageTemplateWidgets$ =
      BehaviorSubject<List<MessageTemplateWidget>>();
  final currentTemplate$ = BehaviorSubject<MessageTemplateWidget>.seeded(
      MessageTemplateWidget(isSelected: false, TemplateID: ''));
  final customers$ = BehaviorSubject<ButtonState>.seeded(ButtonState.loaded);
  final messageGroup$ = BehaviorSubject<ButtonState>.seeded(ButtonState.loaded);

  sendMessage(Map<String, dynamic> map, BuildContext context) async {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    map['server'] = mainProvider.server;
    map['sendGroup'] = currentMessageGroups.map((e) => e.GroupID).join(',');
    map['sendList'] =
        currentCustomers.map<String>((e) => e.CustomerID).toList();
    map['loggedUser'] = mainProvider.user.UserID;
    Map<String, dynamic> data =
        await SendMessageRepository(map['server']).sendMessage(map, context);
    if (data['Status'] == 'Success') {
      Navigator.pop(context);
      currentCustomers = [];
      currentMessageGroups = [];
      showToast('Message Sent');
      // Navigator.pushReplacementNamed(context, 'send_message');
    }
  }
}

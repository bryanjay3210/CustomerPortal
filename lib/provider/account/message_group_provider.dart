import 'package:cp/enum.dart';
import 'package:cp/model/message_group/message_group_list.dart';
import 'package:cp/repository/account/message_group.dart';
import 'package:cp/repository/manager/customer_repository.dart';
import 'package:cp/shared_widgets/toasts.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class MessageGroupListProvider {
  final messageGroupListState =
      BehaviorSubject<DataState>.seeded(DataState.initial);
  List<MessageGroupList> messageGroupList = <MessageGroupList>[];
  String unitID = '';

  getMessageGroupList(Map<String, dynamic> map, BuildContext context) async {
    messageGroupList.clear();
    messageGroupListState.add(DataState.loading);
    Map<String, dynamic> data =
        await MessageGroupRepository(map['server']).getMessageGroupList(map);
    if (data['Status'] == 'Success') {
      var subscribed = data['Subscribed'];
      var pendingApproval = data['PendingApproval'];
      var available = data['Available'];
      if (data['Subscribed'] is Map) {
        messageGroupList.add(MessageGroupList(
            groupID: subscribed['GroupID'],
            groupTitle: subscribed['GroupTitle'],
            status: 'Subscribed'));
      } else if (data['Subscribed'] is List<dynamic>) {
        for (var element in subscribed) {
          messageGroupList.add(MessageGroupList(
              groupID: element['GroupID'],
              groupTitle: element['GroupTitle'],
              status: 'Subscribed'));
        }
      }
      if (data['PendingApproval'] is Map) {
        messageGroupList.add(MessageGroupList(
            groupID: pendingApproval['GroupID'],
            groupTitle: pendingApproval['GroupTitle'],
            customerID: pendingApproval['CustomerID'],
            closed: pendingApproval['Closed'],
            status: 'PendingApproval'));
      } else if (data['PendingApproval'] is List<dynamic>) {
        for (var element in pendingApproval) {
          messageGroupList.add(MessageGroupList(
              groupID: element['GroupID'],
              groupTitle: element['GroupTitle'],
              customerID: element['CustomerID'],
              closed: element['Closed'],
              status: 'PendingApproval'));
        }
      }
      if (data['Available'] is Map) {
        messageGroupList.add(MessageGroupList(
            groupID: available['GroupID'],
            groupTitle: available['GroupTitle'],
            closed: available['Closed'],
            status: 'Available'));
      } else if (data['Available'] is List<dynamic>) {
        for (var element in available) {
          messageGroupList.add(MessageGroupList(
              groupID: element['GroupID'],
              groupTitle: element['GroupTitle'],
              closed: element['Closed'],
              status: 'Available'));
        }
      }
      messageGroupListState.add(DataState.success);
    } else {
      messageGroupListState.add(DataState.success);
    }
  }

  getCustomerInfo(Map<String, dynamic> map, BuildContext context) async {
    try {
      messageGroupListState.add(DataState.loading);
      Map<String, dynamic> data =
          await CustomerRepository(map['server']).getCustomerInfo(map, context);
      unitID = data['UnitID'];
      messageGroupListState.add(DataState.success);
    } catch (e) {
      messageGroupListState.add(DataState.success);
    }
  }

  dynamic joinGroup(Map<String, dynamic> map, BuildContext context) async {
    messageGroupListState.add(DataState.loading);
    Map<String, dynamic> data =
        await MessageGroupRepository(map['server']).joinGroup(map);
    if (data['Status'] == 'Success') {
      showToast('Successfully join!');
    }
    messageGroupListState.add(DataState.loading);
  }

  dynamic leaveGroup(Map<String, dynamic> map, BuildContext context) async {
    messageGroupListState.add(DataState.loading);
    Map<String, dynamic> data =
        await MessageGroupRepository(map['server']).leaveGroup(map);
    if (data['Status'] == 'Success') {
      showToast('Successfully leave.');
    } else {
      showToast('${data['Status']}');
    }
    messageGroupListState.add(DataState.loading);
  }
}

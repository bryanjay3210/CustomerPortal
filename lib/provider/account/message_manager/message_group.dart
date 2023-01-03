import 'package:cp/model/moderator_message_group/moderator_message_group.dart';
import 'package:cp/repository/account/message_manager/message_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

import '../../../enum.dart';
import '../../../model/building/building.dart';
import '../../../model/customer/customer.dart';
import '../../../model/customer_message_group/customer_message_group.dart';
import '../../../model/message_group/message_group.dart';
import '../../../model/target/target.dart';
import '../../../shared_widgets/toasts.dart';
import '../../../utils/utils/on_type_functions/debouncer.dart';
import '../../main_provider.dart';

class MessageGroupProvider {
  final messageGroups$ = BehaviorSubject<DataState>.seeded(DataState.empty);
  final building$ = BehaviorSubject<DataState>.seeded(DataState.empty);
  final dropDownSearchCustomers$ =
      BehaviorSubject<ButtonState>.seeded(ButtonState.loaded);
  final buildingPopupSearch$ =
      BehaviorSubject<List<Building>>.seeded(<Building>[]);
  final moderatorsPopupSearch$ =
      BehaviorSubject<List<ModeratorMessageGroup>>.seeded(
          <ModeratorMessageGroup>[]);
  final customerPopupSearch$ =
      BehaviorSubject<List<CustomerMessageGroup>>.seeded(
          <CustomerMessageGroup>[]);
  var buildingPopupSearch = Building();
  var customerPopupSearch = <CustomerMessageGroup>[];
  final _filterDebounce = Debouncer(delay: const Duration(milliseconds: 1000));
  var selectedBuilidng = Building();
  var buildings = <Building>[];
  var messageGroups = <MessageGroup>[];
  var allMessageGroups = <MessageGroup>[];
  var currentMessageGroup = MessageGroup(CustomerList: []);
  var currentModerator = ModeratorMessageGroup();
  var currentReplyTo = ModeratorMessageGroup();
  var currentCustomers = <CustomerMessageGroup>[];
  var searchKeyword = '';
  var currentBuilding = Building();
  var isLoading = true;
  var targets = <Target>[];

  bool isResidentHall() {
    final hall = currentBuilding.ResidenceHall;
    if (hall is Map || hall.toString().toLowerCase() == 'n') {
      return false;
    }
    return true;
  }

  bool isManagerIot() {
    if (currentBuilding.IOTBuilding is Map) {
      return false;
    }
    return currentBuilding.IOTBuilding == 'Y';
  }

  getBuildings(Map<String, dynamic> map, BuildContext context) async {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    map['server'] = mainProvider.server;
    map['buildingId'] = mainProvider.user.BuildingID;
    map['loggedUser'] = mainProvider.user.UserID;
    Map<String, dynamic> data =
        await MessageGroupRepository(map['server']).getBuildings(map, context);
    final newItems = <Building>[];
    if (data['Status'] == "Success") {
      if (data['Building'] == null) {
        messageGroups$.add(DataState.empty);
        return;
      } else if (data['Building'] is Map) {
        newItems.add(Building.fromJson(data['Building']));
      } else {
        data['Building'].forEach((element) {
          if (element['IOTBuilding'] is Map) {
            element['IOTBuilding'] = '';
          }
          newItems.add(Building.fromJson(element));
        });
      }
      try {
        currentBuilding = newItems
            .firstWhere((element) => element.BuildingID == map['buildingId']);
      } catch (ex) {
        currentBuilding = Building();
      }
    } else {}
  }

  bool isCreate() {
    return currentMessageGroup.GroupID == '';
  }

  getMessageGroups(Map<String, dynamic> map, BuildContext context) async {
    messageGroups$.add(DataState.loading);
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    map['server'] = mainProvider.server;
    map['loggedUser'] = mainProvider.user.UserID;
    map['buildingId'] = mainProvider.user.BuildingID;
    Map<String, dynamic> data = await MessageGroupRepository(map['server'])
        .getMessageGroups(map, context);
    final newItems = <MessageGroup>[];
    targets.clear();
    if (data['Status'] == "Success") {
      if (data['Groups'] == null) {
        messageGroups$.add(DataState.empty);
        return;
      } else if (data['Groups'] is Map) {
        final msgGroups = <Customer>[];
        if (data['Groups']['CustomerList'] != null) {
          final customerList = data['Groups']['CustomerList'];
          if (customerList == null) {
          } else if (data['Groups']['CustomerList'] is Map) {
            if (data['Groups']['CustomerList']['Customername'] is Map) {
              return;
            }
            msgGroups.add(Customer.fromJson(data['Groups']['CustomerList']));
          } else {
            msgGroups.addAll([
              ...List.from(customerList).map((e) {
                if (e['Customername'] is Map) {
                  return Customer();
                }
                return Customer.fromJson(e);
              })
            ]);
            msgGroups.removeWhere(
                (el) => el.CustomerName == '' || el.CustomerName == null);
          }
        }

        newItems.add(MessageGroup(
          GroupID: data['Groups']['GroupID'],
          GroupName: data['Groups']['GroupName'],
          GroupType: data['Groups']['GroupType'],
          GroupAccess: data['Groups']['GroupAccess'],
          GroupDesc: data['Groups']['GroupDesc'],
          DefaultAcceptMessage: data['Groups']['DefaultAcceptMessage'],
          DefaultRejectMessage: data['Groups']['DefaultRejectMessage'],
          ModeratorsEmail: data['Groups']['ModeratorsEmail'],
          ReplyEmail: data['Groups']['ReplyEmail'],
          CanReply: data['Groups']['CanReply'],
          ModeratorCustomerID: data['Groups']['ModeratorCustomerID'],
          ModeratorUserID: data['Groups']['ModeratorUserID'],
          ModeratorUsername: data['Groups']['ModeratorUsername'],
          CustomerList: msgGroups,
        ));
        for (var element in msgGroups) {
          targets.add(Target(
              TargetEmail: element.CustomerTargetEmail is Map
                  ? ''
                  : element.CustomerTargetEmail,
              TargetID: element.CustomerTargetID));
        }
      } else {
        data['Groups'].forEach((element) {
          final msgGroups = <Customer>[];
          if (element['CustomerList'] != null) {
            final customerList = element['CustomerList'];
            if (customerList == null) {
            } else if (element['CustomerList'] is Map) {
              if (element['CustomerList']['Customername'] is Map) {
                return;
              }
              msgGroups.add(Customer.fromJson(element['CustomerList']));
            } else {
              msgGroups.addAll([
                ...List.from(customerList).map((e) {
                  if (e['Customername'] is Map) {
                    return Customer();
                  }
                  return Customer.fromJson(e);
                })
              ]);
              msgGroups.removeWhere(
                  (el) => el.CustomerName == '' || el.CustomerName == null);
            }
          }

          newItems.add(MessageGroup(
            GroupID: element['GroupID'],
            GroupName: element['GroupName'],
            GroupType: element['GroupType'],
            GroupAccess: element['GroupAccess'],
            GroupDesc: element['GroupDesc'],
            DefaultAcceptMessage: element['DefaultAcceptMessage'],
            DefaultRejectMessage: element['DefaultRejectMessage'],
            ModeratorsEmail: element['ModeratorsEmail'],
            ReplyEmail: element['ReplyEmail'],
            CanReply: element['CanReply'],
            ModeratorCustomerID: element['ModeratorCustomerID'],
            ModeratorUserID: element['ModeratorUserID'],
            ModeratorUsername: element['ModeratorUsername'],
            CustomerList: msgGroups,
          ));
          for (var element in msgGroups) {
            targets.add(Target(
                TargetEmail: element.CustomerTargetEmail is Map
                    ? ''
                    : element.CustomerTargetEmail,
                TargetID: element.CustomerTargetID));
          }
        });
      }
      newItems.sort((a, b) => a.GroupName.toString()
          .toLowerCase()
          .compareTo(b.GroupName.toString().toLowerCase()));
      messageGroups = newItems;
      allMessageGroups = newItems;
      filterMessageGroup(searchKeyword);
    } else {
      messageGroups$.add(DataState.success);
    }
  }

  initializeBuildingDropDown() {
    buildingPopupSearch$.add(buildings);
    buildingPopupSearch = selectedBuilidng.BuildingID != ''
        ? buildings.firstWhere(
            (element) => element.BuildingID == selectedBuilidng.BuildingID)
        : Building();
  }

  filterBuildingDropDown(Building building, String str) {
    buildingPopupSearch$.add([
      ...buildings.where((element) => element.BuildingName.toString()
          .toLowerCase()
          .trim()
          .contains(str.trim().toLowerCase()))
    ]);
  }

  getModerators(Map<String, dynamic> map, BuildContext context) async {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    map['server'] = mainProvider.server;
    map['loggedUser'] = mainProvider.user.UserID;
    Map<String, dynamic> data =
        await MessageGroupRepository(map['server']).getModerators(map, context);
    final newItems = <ModeratorMessageGroup>[];
    if (data['Status'] == "Success") {
      if (data['User'] == null) {
        return;
      } else if (data['User'] is Map) {
        newItems.add(ModeratorMessageGroup.fromJson(data['User']));
      } else {
        data['User'].forEach((element) {
          newItems.add(ModeratorMessageGroup.fromJson(element));
        });
      }

      newItems.sort((a, b) => a.UserName.toString()
          .toLowerCase()
          .compareTo(b.UserName.toString().toLowerCase()));
      moderatorsPopupSearch$.add(newItems);
    }
  }

  getCustomers(Map<String, dynamic> map, BuildContext context) async {
    customerPopupSearch$.add(<CustomerMessageGroup>[]);
    final mainProvider = Provider.of<MainProvider>(context, listen: false);

    map['server'] = mainProvider.server;
    map['loggedUser'] = mainProvider.user.UserID;
    map['buildingId'] = mainProvider.user.BuildingID;

    Map<String, dynamic> data =
        await MessageGroupRepository(map['server']).getCustomers(map, context);
    final newItems = <CustomerMessageGroup>[];
    if (data['Status'] == "Success") {
      if (data['Customers'] == null) {
        return;
      } else if (data['Customers'] is Map) {
        if (data['Customers']['Name'] is Map) {
          return;
        }
        newItems.add(CustomerMessageGroup.fromJson(data['Customers']));
      } else {
        data['Customers'].forEach((element) {
          if (element['Name'] is Map) {
            return;
          }
          newItems.add(CustomerMessageGroup.fromJson(element));
        });
      }
      customerPopupSearch = newItems;
      customerPopupSearch.sort((a, b) => a.Name.toString()
          .toLowerCase()
          .compareTo(b.Name.toString().toLowerCase()));
      customerPopupSearch$.add(newItems);
    }
  }

  ModeratorMessageGroup getModeratorById(dynamic moderatorUserId) {
    return moderatorsPopupSearch$.value
        .firstWhere((element) => element.UserID == moderatorUserId);
  }

  ModeratorMessageGroup getModeratorByEmail(dynamic userEmail) {
    return moderatorsPopupSearch$.value
        .firstWhere((element) => element.UserEmail == userEmail);
  }

  CustomerMessageGroup getCustomerMessageGroupById(dynamic customerId) {
    return customerPopupSearch$.value
        .firstWhere((element) => element.CustomerID == customerId);
  }

  createMessageGroup(Map<String, dynamic> map, BuildContext context) async {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    map['server'] = mainProvider.server;
    map['buildingId'] = mainProvider.user.BuildingID;
    map['loggedUser'] = mainProvider.user.UserID;
    Map<String, dynamic> data = await MessageGroupRepository(map['server'])
        .createMessageGroup(map, context);
    if (data['Status'] == "Success") {
      getMessageGroups(map, context);
    }
  }

  updateMessageGroup(Map<String, dynamic> map, BuildContext context) async {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    map['server'] = mainProvider.server;
    map['groupId'] = currentMessageGroup.GroupID;
    map['buildingId'] = mainProvider.user.BuildingID;
    map['loggedUser'] = mainProvider.user.UserID;
    Map<String, dynamic> data = await MessageGroupRepository(map['server'])
        .updateMessageGroup(map, context);
    if (data['Status'] == "Success") {
      getMessageGroups(map, context);
    }
  }

  removeGroup(Map<String, dynamic> map, BuildContext context) async {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    map['server'] = mainProvider.server;
    map['groupId'] = currentMessageGroup.GroupID;
    map['loggedUser'] = mainProvider.user.UserID;
    Map<String, dynamic> data =
        await MessageGroupRepository(map['server']).removeGroup(map, context);
    if (data['Status'] == 'Success') {
      showToast('Message Group Successfully Deleted');
      Navigator.of(context).pop();
      getMessageGroups(map, context);
    } else {}
  }

  filterMessageGroup(String text) {
    messageGroups$.add(DataState.loading);
    _filterDebounce.run(() {
      if (text.trim().isEmpty) {
        messageGroups = allMessageGroups;
        messageGroups$.add(DataState.success);
        return;
      }
      messageGroups = [
        ...allMessageGroups.where((element) => element.GroupName.toString()
            .toLowerCase()
            .trim()
            .contains(text.toLowerCase().trim()))
      ];

      if (messageGroups.isEmpty) {
        messageGroups$.add(DataState.empty);
      } else {
        messageGroups$.add(DataState.success);
      }
    });
  }
}

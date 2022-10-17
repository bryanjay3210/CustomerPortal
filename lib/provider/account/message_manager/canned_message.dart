import 'package:cp/model/canned_request/canned_request.dart';
import 'package:cp/provider/account/message_manager/message_group.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/subjects.dart';

import '../../../enum.dart';
import '../../../model/message_group/message_group.dart';
import '../../../model/target/target.dart';
import '../../../repository/account/message_manager/canned_message.dart';
import '../../../shared_widgets/toasts.dart';
import '../../../utils/utils/on_type_functions/debouncer.dart';
import '../../main_provider.dart';

class CannedMessageProvider {
  final cannedRequests$ = BehaviorSubject<DataState>.seeded(DataState.loading);
  final cannedRequestDropdownSearch$ =
      BehaviorSubject<ButtonState>.seeded(ButtonState.loaded);
  final group$ = BehaviorSubject<ButtonState>.seeded(ButtonState.loaded);
  var cannedRequests = <CannedRequest>[];
  var currentMessageGroups = <MessageGroup>[];
  var targets = <Target>[];
  var allCannedRequests = <CannedRequest>[];
  var currentCannedRequest = CannedRequest();
  var currentTargets = <Target>[];
  var isCreate = false;
  var requestId = '';
  final _filterDebounce = Debouncer(delay: const Duration(milliseconds: 1000));
  var searchKeyword = '';

  getCannedRequests(Map<String, dynamic> map, BuildContext context) async {
    cannedRequests$.add(DataState.loading);
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    map['server'] = mainProvider.server.toString();
    map['loggedUser'] = mainProvider.user.UserID;
    map['buildingId'] = mainProvider.user.BuildingID;

    Map<String, dynamic> data =
        await CannedMessageRepository(int.parse(map['server']))
            .getCannedRequests(map, context);
    var newItems = <CannedRequest>[];
    if (data['Status'] == 'Success') {
      if (data['Requests'] == null) {
        cannedRequests$.add(DataState.empty);
        return;
      } else if (data['Requests'] is Map) {
        newItems.add(CannedRequest.fromJson(data['Requests']));
      } else {
        data['Requests'].forEach((element) {
          newItems.add(CannedRequest.fromJson(element));
        });
      }
      cannedRequests = newItems;
      allCannedRequests = newItems;
      filterCannedRequests();
    } else {
      cannedRequests$.add(DataState.success);
    }
  }

  getRequestTargets(Map<String, dynamic> map, BuildContext context) async {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    final messageGroupProvider =
        Provider.of<MessageGroupProvider>(context, listen: false);
    map['server'] = mainProvider.server;
    map['loggedUser'] = mainProvider.user.UserID;
    map['buildingId'] = mainProvider.user.BuildingID;

    Map<String, dynamic> data = await CannedMessageRepository(map['server'])
        .getRequestTargets(map, context);
    var newItems = <Target>[];
    if (data['Status'] == 'Success') {
      if (data['TargetList'] == null) {
        return;
      } else if (data['TargetList'] is Map) {
        newItems.add(Target.fromJson(data['TargetList']));
      } else {
        data['TargetList'].forEach((element) {
          newItems.add(Target.fromJson(element));
        });
      }
      targets = <Target>{...newItems, ...messageGroupProvider.targets}.toList();
      targets.sort((a, b) =>
          a.TargetEmail.toLowerCase().compareTo(b.TargetEmail.toLowerCase()));
    }
  }

  removeCannedRequest(Map<String, dynamic> map, BuildContext context) async {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    map['server'] = mainProvider.server;
    map['requestId'] = requestId;
    map['loggedUser'] = mainProvider.user.UserID;
    Map<String, dynamic> data = await CannedMessageRepository(map['server'])
        .removeCannedRequest(map, context);
    if (data['Status'] == 'Success') {
      showToast('Canned Message Successfully Deleted');
      Navigator.of(context).pop();
      getCannedRequests(map, context);
    } else {}
  }

  createCannedRequest(Map<String, dynamic> map, BuildContext context) async {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    map['server'] = mainProvider.server.toString();
    map['buildingId'] = mainProvider.user.BuildingID;
    map['requestTarget'] = currentTargets.map((e) => e.TargetID).join(',');
    map['loggedUser'] = mainProvider.user.UserID;
    Map<String, dynamic> data =
        await CannedMessageRepository(int.parse(map['server']))
            .createCannedRequest(map, context);
    if (data['Status'] == "Success") {
      getCannedRequests(map, context);

      showToast('Canned Message Successfully Added');
      Navigator.of(context).pop();
    }
  }

  updateCannedRequest(Map<String, dynamic> map, BuildContext context) async {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    map['server'] = mainProvider.server.toString();
    map['requestId'] = requestId;
    map['requestTarget'] = currentTargets.map((e) => e.TargetID).join(',');
    map['buildingId'] = mainProvider.user.BuildingID;
    map['loggedUser'] = mainProvider.user.UserID;
    Map<String, dynamic> data =
        await CannedMessageRepository(int.parse(map['server']))
            .updateCannedRequest(map, context);
    if (data['Status'] == "Success") {
      getCannedRequests(map, context);

      showToast('Canned Message Successfully Updated');
      Navigator.of(context).pop();
    }
  }

  Target getTarget(String targetEmail) {
    return targets.firstWhere((element) => element.TargetEmail == targetEmail);
  }

  // Target currentRequest() {
  //   return targets.firstWhere(
  //       (element) => element.TargetID == currentCannedRequest.RequestID);
  // }

  filterCannedRequests() {
    cannedRequests$.add(DataState.loading);
    _filterDebounce.run(() {
      if (searchKeyword.trim().isEmpty) {
        cannedRequests = allCannedRequests;
        cannedRequests$.add(DataState.success);
        return;
      }
      cannedRequests = [
        ...allCannedRequests.where((element) => element.RequestTitle.toString()
            .toLowerCase()
            .trim()
            .contains(searchKeyword.toLowerCase().trim()))
      ];

      if (cannedRequests.isEmpty) {
        cannedRequests$.add(DataState.empty);
      } else {
        cannedRequests$.add(DataState.success);
      }
    });
  }
}

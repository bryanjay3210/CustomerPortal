import 'package:cp/enum.dart';
import 'package:cp/model/message_group/message_group_list.dart';
import 'package:cp/provider/account/message_group_provider.dart';
import 'package:cp/provider/main_provider.dart';
import 'package:cp/utils/utils/theme/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class MessageGroups extends StatefulWidget {
  const MessageGroups({Key? key}) : super(key: key);

  @override
  State<MessageGroups> createState() => _MessageGroupsState();
}

class _MessageGroupsState extends State<MessageGroups> {
  late BuildContext currentContext;
  @override
  void didChangeDependencies() {
    currentContext = context;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    loadData(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    final messageGroupProvider =
        Provider.of<MessageGroupListProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: mainProvider.darkTheme ? cpDarkBgColor : cpWhiteColor,
      body: StreamBuilder<DataState>(
        stream: messageGroupProvider.messageGroupListState,
        builder: (context, snapshot) {
          if (snapshot.data == DataState.loading)
            return const Center(child: CircularProgressIndicator.adaptive());
          if (snapshot.data == DataState.success &&
              messageGroupProvider.messageGroupList.isEmpty)
            return const Center(
              child: Text('Empty groups.'),
            );
          return Scrollbar(
            child: SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * .70,
              child: ListView.builder(
                itemCount: messageGroupProvider.messageGroupList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: SvgPicture.asset(
                      'assets/images/message/msg_group.svg',
                      width: 20,
                    ),
                    title: Text(messageGroupProvider
                        .messageGroupList[index].groupTitle
                        .toString()),
                    trailing: StatefulBuilder(
                      builder: (context, setState) {
                        if (messageGroupProvider
                                .messageGroupList[index].status ==
                            'Subscribed') {
                          return optionButton(
                              color: Colors.red,
                              text: 'Leave',
                              function: () => messageGroupProvider.leaveGroup({
                                    'residentID': mainProvider.user.CustomerID,
                                    'unitID': messageGroupProvider.unitID,
                                    'groupID': messageGroupProvider
                                        .messageGroupList[index].groupID,
                                    'userId': mainProvider.user.UserID,
                                    'server': mainProvider.server,
                                  }, context).then((value) =>
                                      loadData(context: currentContext)));
                        }
                        if (messageGroupProvider
                                .messageGroupList[index].status ==
                            'PendingApproval') {
                          return optionButton(
                              color: Colors.grey,
                              text: 'Pending',
                              function: () {
                                print(
                                    '${messageGroupProvider.messageGroupList[index].groupID} <-----------------------');
                                print(
                                    '${messageGroupProvider.messageGroupList[index].customerID} <-----------------------');
                              });
                        }
                        return optionButton(
                            color: Colors.green,
                            text: 'Join',
                            function: () => messageGroupProvider.joinGroup({
                                  'residentID': mainProvider.user.CustomerID,
                                  'unitID': messageGroupProvider.unitID,
                                  'groupID': messageGroupProvider
                                      .messageGroupList[index].groupID,
                                  'accessComment': '',
                                  'userId': mainProvider.user.UserID,
                                  'server': mainProvider.server,
                                }, context).then((value) =>
                                    loadData(context: currentContext)));
                      },
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget optionButton(
    {required Color color,
    required String text,
    required VoidCallback function}) {
  return Container(
    height: 30,
    width: 80,
    decoration:
        BoxDecoration(color: color, borderRadius: BorderRadius.circular(15)),
    child: TextButton(
      onPressed: function,
      child: Text(text, style: const TextStyle(color: Colors.white)),
    ),
  );
}

void loadData({required BuildContext context}) {
  final mainProvider = Provider.of<MainProvider>(context, listen: false);
  final messageGroupProvider =
      Provider.of<MessageGroupListProvider>(context, listen: false);
  messageGroupProvider.getCustomerInfo({
    'server': mainProvider.server,
    'customerId': mainProvider.user.CustomerID,
    'userId': mainProvider.user.UserID,
    'buildingId': mainProvider.user.BuildingID
  }, context).then((value) => messageGroupProvider.getMessageGroupList({
        'residentID': mainProvider.user.CustomerID,
        'unitID': messageGroupProvider.unitID,
        'server': mainProvider.server,
        'userId': mainProvider.user.UserID
      }, context));
}

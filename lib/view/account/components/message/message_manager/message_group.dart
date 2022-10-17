import 'package:cp/model/message_group/message_group.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../enum.dart';
import '../../../../../provider/account/message_manager/message_group.dart';
import '../../../../../provider/main_provider.dart';
import '../../../../../utils/utils/theme/global_colors.dart';

class MessageGroupPage extends StatefulWidget {
  const MessageGroupPage({Key? key}) : super(key: key);

  @override
  _MessageGroupPageState createState() => _MessageGroupPageState();
}

class _MessageGroupPageState extends State<MessageGroupPage> {
  var isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final messageGroupProvider =
          Provider.of<MessageGroupProvider>(context, listen: false);
      // messageGroupProvider.getBuildings({}, context);

      await messageGroupProvider.getMessageGroups({}, context);
      await messageGroupProvider.getModerators({}, context);
      await messageGroupProvider.getCustomers({}, context);
      setState(() {
        isLoading = false;
      });

      // final mainProvider = Provider.of<MainProvider>(context, listen: false);
      // final productProvider =
      //     Provider.of<ProductProvider>(context, listen: false);
      // productProvider.getCustomerProduct({
      //   'customerId': mainProvider.user.CustomerID,
      //   'planID': widget.planId,
      //   'userId': mainProvider.user.UserID,
      //   'server': mainProvider.server,
      // }, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    final isDarkMode = mainProvider.isDarkMode;
    final messageGroupProvider =
        Provider.of<MessageGroupProvider>(context, listen: false);
    return isLoading
        ? Scaffold(
            backgroundColor:
                mainProvider.darkTheme ? cpDarkBgColor : cpWhiteColor,
            body: const SizedBox(
                child: Center(child: CircularProgressIndicator.adaptive())),
          )
        : Scaffold(
            backgroundColor:
                mainProvider.darkTheme ? cpDarkBgColor : cpWhiteColor,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: const Color(0xff30313A),
                  width: double.infinity,
                  height: 130,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: const Icon(Icons.arrow_back_ios,
                                color: cpWhiteColor)),
                        const SizedBox(height: 30),
                        const Text(
                          'Message Group',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: cpWhiteColor),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text('Building Name',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      Text(
                        messageGroupProvider.currentBuilding.BuildingName,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Divider(
                    color: isDarkMode ? Colors.black45 : Colors.grey.shade100,
                    height: 20,
                    thickness: 10),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      prefixIcon: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Icon(Icons.search),
                      ),
                      filled: true,
                      // hintStyle: TextStyle(color: Colors.grey[800]),
                      hintText: "Search group",
                    ),
                    onChanged: (text) {
                      messageGroupProvider.searchKeyword = text;
                      messageGroupProvider.filterMessageGroup(text);
                    },
                  ),
                ),
                Expanded(
                    child: Container(
                        color: mainProvider.darkTheme
                            ? cpDarkBgColor
                            : cpWhiteColor,
                        child: StreamBuilder(
                          stream: messageGroupProvider.messageGroups$,
                          builder: (context, snapshot) {
                            if (snapshot.data == null) {
                              if (messageGroupProvider
                                      .selectedBuilidng.BuildingID ==
                                  '') {
                                return Center(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text('No Building Selected',
                                        style: TextStyle(fontSize: 13)),
                                  ],
                                ));
                              }
                              return const SizedBox();
                            }

                            if (snapshot.data == DataState.empty) {
                              return Center(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/account/no_messages.png',
                                    height: 150,
                                    width: 150,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text('Nothing To Show',
                                      style: TextStyle(fontSize: 13)),
                                ],
                              ));
                            }
                            if (snapshot.data == DataState.loading) {
                              return const Center(
                                child: CircularProgressIndicator.adaptive(),
                              );
                            }
                            return Scrollbar(
                              child: ListView.separated(
                                itemCount:
                                    messageGroupProvider.messageGroups.length,
                                itemBuilder: (context, index) {
                                  var message =
                                      messageGroupProvider.messageGroups[index];
                                  return ListTile(
                                    title: Text(
                                      message.GroupName is Map
                                          ? ''
                                          : message.GroupName,
                                    ),
                                    subtitle: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Chip(
                                            label: Text(message.GroupType == 'R'
                                                ? 'Required'
                                                : 'Optional'),
                                          ),
                                          const SizedBox(width: 10),
                                          Chip(
                                            label: Text(
                                                message.GroupAccess == 'O'
                                                    ? 'Open'
                                                    : 'Closed Membership'),
                                          )
                                        ]),
                                    onTap: () {
                                      Provider.of<MessageGroupProvider>(context,
                                              listen: false)
                                          .currentMessageGroup = message;
                                      Navigator.pushNamed(
                                          context, 'message_group_detail');
                                    },
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const Divider();
                                },
                              ),
                            );
                          },
                        )))
              ],
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: cpPrimaryColorActive,
              onPressed: () {
                messageGroupProvider.currentMessageGroup =
                    MessageGroup(CustomerList: []);
                Navigator.of(context).pushNamed('message_group_detail');
              },
              child: const Icon(Icons.add),
            ),
          );
  }
}

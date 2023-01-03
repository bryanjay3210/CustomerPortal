import 'package:cp/enum.dart';
import 'package:cp/main.dart';
import 'package:cp/model/invoice/invoice.dart';
import 'package:cp/provider/main_provider.dart';
import 'package:cp/utils/utils/theme/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../model/message_screen_widget/message_scree_widget.dart';
import '../../../../provider/account/message_provider.dart';
import '../../../../utils/utils/datetime/datetimeUtils.dart';
import 'messages.dart';

class MainMessageScreen extends StatefulWidget {
  const MainMessageScreen({Key? key}) : super(key: key);

  @override
  State<MainMessageScreen> createState() => _MainMessageScreenState();
}

class _MainMessageScreenState extends State<MainMessageScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    loadMessages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    final messageProvider =
        Provider.of<MessageProvider>(context, listen: false);
    bool isManager = mainProvider.isManager();
    return Scaffold(
        drawer: Drawer(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 80),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text('Messages',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 25),
            ...[
              if (!isManager)
                MessageScreenWidget('Messages', const Icon(Icons.message_sharp),
                    () {
                  Navigator.of(context).pushNamed('messages');
                }),
              // if (!isManager)
              //   MessageScreenWidget(
              //       'Address Book', const Icon(Icons.menu_book_outlined), () {
              //     Navigator.of(context).pushNamed('address_book');
              //   }),
              if (!isManager)
                MessageScreenWidget(
                    'Contact Option', const Icon(Icons.contacts_rounded), () {
                  Navigator.of(context).pushNamed('contact_option');
                }),
              if (isManager)
                MessageScreenWidget(
                    'Message Groups',
                    CircleAvatar(
                      backgroundColor: messageIconColor,
                      child: SvgPicture.asset(
                        'assets/images/message/message_groups.svg',
                        width: 20,
                      ),
                    ), () {
                  Navigator.of(context).pushNamed('message_group');
                }),
              if (isManager)
                MessageScreenWidget(
                    'Send Message',
                    CircleAvatar(
                      backgroundColor: messageIconColor,
                      child: SvgPicture.asset(
                        'assets/images/message/send_message.svg',
                        width: 20,
                      ),
                    ), () {
                  Navigator.of(context).pushNamed('send_message');
                }),
              if (isManager)
                MessageScreenWidget(
                    'Contact Options',
                    const CircleAvatar(
                        backgroundColor: messageIconColor,
                        child: Icon(
                          Icons.contacts_rounded,
                          color: cpPrimaryColorActive,
                        )), () {
                  Navigator.of(context).pushNamed('contact_option');
                }),
              if (isManager)
                MessageScreenWidget(
                    'Message Templates',
                    CircleAvatar(
                      backgroundColor: messageIconColor,
                      child: SvgPicture.asset(
                        'assets/images/message/message_templates.svg',
                        width: 20,
                      ),
                    ), () {
                  Navigator.of(context).pushNamed('message_template');
                }),
              if (isManager)
                MessageScreenWidget(
                    'Canned Messages',
                    CircleAvatar(
                      backgroundColor: messageIconColor,
                      child: SvgPicture.asset(
                        'assets/images/message/canned_message_icon.svg',
                        width: 20,
                      ),
                    ), () {
                  Navigator.of(context).pushNamed('canned_message');
                }),
            ]
                .map((e) => PopupMenuItem(
                      onTap: () async {
                        await Future.delayed(const Duration(milliseconds: 10));
                        // Navigator.pop(context);
                        e.func();
                      },
                      value: e.name,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          e.icon,
                          const SizedBox(width: 10),
                          Text(e.name)
                        ],
                      ),
                    ))
                .toList()
          ],
        )),
        key: _scaffoldKey,
        floatingActionButton: isManager
            ? null
            : FloatingActionButton(
                backgroundColor: cpPrimaryColorActive,
                onPressed: () => Navigator.of(context).pushNamed('new_message'),
                child: const Icon(Icons.add),
              ),
        body: Column(
          children: [
            Container(
              color: const Color(0xff30313A),
              width: double.infinity,
              // height: 130,
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.arrow_back_ios)),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 13, top: 5, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Messages',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: cpWhiteColor),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (_scaffoldKey.currentState == null) {
                                return;
                              }
                              _scaffoldKey.currentState!.openDrawer();
                            },
                            child: const CircleAvatar(
                              backgroundColor: messageIconAvatarColor,
                              child: Icon(Icons.more_vert),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10)
                  ],
                ),
              ),
            ),
            // const Messages()
            if (!isManager)
              Expanded(
                  child: Container(
                      alignment: Alignment.center,
                      color:
                          mainProvider.darkTheme ? cpDarkBgColor : cpWhiteColor,
                      child: SingleChildScrollView(
                        child: StreamBuilder(
                          stream: messageProvider.messageListState,
                          builder: (context, snapshot) {
                            if (snapshot.data == DataState.success &&
                                messageProvider.messageList.isEmpty) {
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
                                  const Text('No messages in your inbox.',
                                      style: TextStyle(fontSize: 13)),
                                ],
                              ));
                            }
                            if (snapshot.data == DataState.success &&
                                messageProvider.messageList.isNotEmpty) {
                              return Scrollbar(
                                child: ListView.builder(
                                  itemCount: messageProvider.messageList.length,
                                  itemBuilder: (context, index) {
                                    var message =
                                        messageProvider.messageList[index];
                                    String subject = message.Subject;
                                    String date = jsDateTimeToDateDay(
                                        message.MessageDate);
                                    String time =
                                        jsTimeToTimehhmmaa(message.MessageDate);
                                    String messageData =
                                        message.Message.toString();
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      child: Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              Navigator.of(context).pushNamed(
                                                  'message_detail',
                                                  arguments: {
                                                    'subject': subject,
                                                    'date': date,
                                                    'time': time,
                                                    'message': messageData,
                                                    'messageId':
                                                        message.MessageID,
                                                  }).then(
                                                  (value) => loadMessages());
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: mainProvider.darkTheme
                                                    ? const Color(0xff3C3F41)
                                                    : const Color(0xfff5f5f5),
                                              ),
                                              width: double.infinity,
                                              // height: 50,
                                              child: Row(
                                                children: [
                                                  SvgPicture.asset(
                                                      'assets/images/account/contact_logo.svg'),
                                                  const SizedBox(width: 10),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            message.Ack == 'N'
                                                                ? Container(
                                                                    width: 5,
                                                                    height: 5,
                                                                    decoration: const BoxDecoration(
                                                                        color: Colors
                                                                            .red,
                                                                        shape: BoxShape
                                                                            .circle),
                                                                  )
                                                                : const SizedBox(
                                                                    width: 5,
                                                                  ),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text(subject,
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                            height: 10),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10),
                                                          child: Text(
                                                              messageData,
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          13),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 3,
                                                  ),
                                                  SizedBox(
                                                      width: 60,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15),
                                                                color: const Color(
                                                                    0xffE0F7FB)),
                                                            width:
                                                                double.infinity,
                                                            height: 20,
                                                            child: Center(
                                                                child: Text(
                                                                    date,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            10,
                                                                        color: mainProvider.darkTheme
                                                                            ? Colors.black
                                                                            : cpDarkBgColor))),
                                                          ),
                                                          const SizedBox(
                                                            height: 3,
                                                          ),
                                                          Text(time,
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          10)),
                                                        ],
                                                      ))
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              );
                            }
                            return const Center(
                              child: CircularProgressIndicator.adaptive(),
                            );
                          },
                        ),
                      )))
          ],
        ));
  }

  Widget headingText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(text,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }

  Color getColor(bool isPastDue, String value) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    if (isPastDue) {
      var val = double.parse(value.replaceAll('\$', '').replaceAll(',', ''));
      if (val > 0) {
        return Colors.red;
      }
      if (val < 0) {
        return Colors.green;
      }
    }
    return mainProvider.darkTheme ? Colors.white : Colors.black;
  }

  Widget buttonContainer(
      {required String text,
      required Function() onPress,
      required bool isGradient}) {
    if (!isGradient) {
      return GestureDetector(
        onTap: onPress,
        child: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xffE1E1E1),
          child: Center(
            child: Text(text, style: const TextStyle(color: Colors.black)),
          ),
        ),
      );
    }
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xFFFFC72E), Color(0xFFF87D1F)])),
        child: Center(
          child: Text(text, style: const TextStyle(color: Colors.black)),
        ),
      ),
    );
  }

  void loadMessages() {
    final messageProvider =
        Provider.of<MessageProvider>(context, listen: false);
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    messageProvider.getMessage({
      'pollType': 'A',
      'customerID': mainProvider.user.CustomerID,
      'server': mainProvider.server,
      'userId': mainProvider.user.UserID,
    }, context);
  }
}

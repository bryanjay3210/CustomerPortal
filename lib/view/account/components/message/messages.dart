import 'package:cp/enum.dart';
import 'package:cp/provider/main_provider.dart';
import 'package:cp/utils/utils/datetime/datetimeUtils.dart';
import 'package:cp/utils/utils/theme/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../../../provider/account/message_provider.dart';

class Messages extends StatefulWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
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
    bool isEmpty = false;
    return Scaffold(
      backgroundColor: const Color(0xff30313A),
      body: Column(
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
                    'Messages',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: cpWhiteColor),
                  )
                ],
              ),
            ),
          ),
          Expanded(
              child: Container(
                  color: mainProvider.darkTheme ? cpDarkBgColor : cpWhiteColor,
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
                              var message = messageProvider.messageList[index];
                              String subject = message.Subject;
                              String date = jsDateTimeToDateDay(message.MessageDate);
                              String time = jsTimeToTimehhmmaa(message.MessageDate);
                              String messageData = message.Message.toString();
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () async{
                                        Navigator.of(context)
                                            .pushNamed('message_detail',
                                            arguments: {
                                              'subject': subject,
                                              'date': date,
                                              'time': time,
                                              'message': messageData,
                                              'messageId': message.MessageID,
                                            }).then((value) => loadMessages());
                                      } ,
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
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      message.Ack == 'N' ? Container(
                                                        width: 5,
                                                        height: 5,
                                                        decoration: const BoxDecoration(
                                                            color: Colors.red,
                                                            shape: BoxShape.circle
                                                        ),) : const SizedBox(width: 5,),
                                                      const SizedBox(width: 5,),
                                                      Text(subject,
                                                          style: const TextStyle(
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight.bold)),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 10),
                                                    child: Text(messageData,
                                                        style: const TextStyle(
                                                            fontSize: 13),
                                                        overflow: TextOverflow
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
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          color: const Color(
                                                              0xffE0F7FB)),
                                                      width: double.infinity,
                                                      height: 20,
                                                      child: Center(
                                                          child: Text(date,
                                                              style: TextStyle(
                                                                  fontSize: 10,
                                                                  color: mainProvider
                                                                          .darkTheme
                                                                      ? Colors
                                                                          .black
                                                                      : cpDarkBgColor))),
                                                    ),
                                                    const SizedBox(
                                                      height: 3,
                                                    ),
                                                    Text(time,
                                                        style: const TextStyle(
                                                            fontSize: 10)),
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
                  )))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: cpPrimaryColorActive,
        onPressed: () => Navigator.of(context).pushNamed('new_message'),
        child: const Icon(Icons.add),
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

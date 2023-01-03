import 'package:cp/enum.dart';
import 'package:cp/provider/account/message_provider.dart';
import 'package:cp/provider/main_provider.dart';
import 'package:cp/utils/utils/datetime/datetimeUtils.dart';
import 'package:cp/utils/utils/theme/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class SentMessages extends StatefulWidget {
  const SentMessages({Key? key}) : super(key: key);

  @override
  State<SentMessages> createState() => _SentMessagesState();
}

class _SentMessagesState extends State<SentMessages> {
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
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: StreamBuilder<DataState>(
        stream: messageProvider.messageListState,
        builder: (context, snapshot) {
          if(snapshot.data == DataState.success && messageProvider.sentMessageList.isEmpty){
            return Column(
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
                const Text('No sent messages.',
                    style: TextStyle(fontSize: 13)),
              ],
            );
          }
          if(snapshot.data == DataState.success && messageProvider.sentMessageList.isNotEmpty){
            return Scrollbar(
              child: SizedBox(height: double.infinity, width: double.infinity, child: ListView.builder(
                itemCount: messageProvider.sentMessageList.length,
                itemBuilder: (context, index) {
                  var message = messageProvider.sentMessageList[index];
                  String date =
                  jsDateTimeToDateDay(message.MessageDate);
                  String time =
                  jsTimeToTimehhmmaa(message.MessageDate);
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5, horizontal: 10),
                    child: Column(
                      children: [
                        Container(
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
                                        // message.Ack == 'N'
                                        //     ? Container(
                                        //   width: 5,
                                        //   height: 5,
                                        //   decoration: const BoxDecoration(
                                        //       color: Colors
                                        //           .red,
                                        //       shape: BoxShape
                                        //           .circle),
                                        // )
                                        //     : const SizedBox(
                                        //   width: 5,
                                        // ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(message.Subject,
                                            style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight:
                                                FontWeight
                                                    .bold)),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(
                                          left: 10),
                                      child: Text(message.Message,
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
                      ],
                    ),
                  );
              },)),
            );
          }
          return const Center(child: CircularProgressIndicator.adaptive(),);
        },
      ),
    );
  }

  void loadMessages() {
    final messageProvider =
    Provider.of<MessageProvider>(context, listen: false);
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    messageProvider.getSentMessages({
      'customerID': mainProvider.user.CustomerID,
      'server': mainProvider.server,
      'userId': mainProvider.user.UserID,
    }, context);
  }
}

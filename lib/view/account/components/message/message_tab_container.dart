import 'package:cp/main.dart';
import 'package:cp/view/account/components/message/messages.dart';
import 'package:cp/view/account/components/message/sent_messages.dart';
import 'package:flutter/material.dart';

class MessageTabContainer extends StatefulWidget {
  const MessageTabContainer({Key? key}) : super(key: key);

  @override
  State<MessageTabContainer> createState() => _MessageTabContainerState();
}

class _MessageTabContainerState extends State<MessageTabContainer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: const Color(0xff2b2b2b),
          body: Column(
            children: const [
              TabBar(
                indicatorColor: Colors.amber,
                tabs: [
                  Tab(text: 'Inbox'),
                  Tab(text: 'Sent'),
                ],
              ),
              Expanded(
                child: TabBarView(children: [
                  Messages(),
                  SentMessages(),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}

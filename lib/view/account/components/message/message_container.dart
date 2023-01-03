import 'package:badges/badges.dart';
import 'package:cp/enum.dart';
import 'package:cp/model/message_group/message_group.dart';
import 'package:cp/model/message_screen_widget/message_scree_widget.dart';
import 'package:cp/provider/account/message_provider.dart';
import 'package:cp/provider/main_provider.dart';
import 'package:cp/shared_widgets/shared_text.dart';
import 'package:cp/utils/utils/theme/global_colors.dart';
import 'package:cp/view/account/components/message/message_group.dart';
import 'package:cp/view/account/components/message/message_manager/contact_option_page.dart';
import 'package:cp/view/account/components/message/message_tab_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import 'messages.dart';

class MessageContainer extends StatefulWidget {
  const MessageContainer({Key? key}) : super(key: key);

  @override
  State<MessageContainer> createState() => _MessageContainerState();
}

class _MessageContainerState extends State<MessageContainer>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final appTitle$ = BehaviorSubject<String>.seeded('Messages');
  TextEditingController searchMessageCtrl = TextEditingController();
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    final messageProvider = Provider.of<MessageProvider>(context, listen: false);
    messageProvider.getUnreadMessagesCount({
      'server': mainProvider.server,
      'customerID': mainProvider.user.CustomerID,
      'userId': mainProvider.user.UserID,
    }, context);
  }

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    final messageProvider = Provider.of<MessageProvider>(context, listen: false);
    final isManager = mainProvider.isManager();

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

                  SizedBox(height: isManager ? 18 : 30),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StreamBuilder<String>(stream: appTitle$, builder: (context, snapshot) {
                        return appBarTitle(title: snapshot.data.toString());
                      }),
                      Visibility(visible: isManager, child: dropMessageScreen(mainProvider)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: mainProvider.darkTheme ? cpDarkBgColor : cpWhiteColor,
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.search),
                        const SizedBox(
                          width: 5,
                        ),
                        const VerticalDivider(
                            color: Colors.white,
                            thickness: 1,
                            indent: 10,
                            endIndent: 10),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: TextField(
                            controller: searchMessageCtrl,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Search Message'),
                            keyboardType: TextInputType.text,
                            onSubmitted: (value) {
                              if (value.isNotEmpty) {
                                messageProvider.getMessage({
                                  'pollType': 'A',
                                  'customerID': mainProvider.user.CustomerID,
                                  'server': mainProvider.server,
                                  'userId': mainProvider.user.UserID,
                                }, context).then((_) => messageProvider
                                    .searchMessage(searchMsg: value));
                              } else {
                                messageProvider.getMessage({
                                  'pollType': 'A',
                                  'customerID': mainProvider.user.CustomerID,
                                  'server': mainProvider.server,
                                  'userId': mainProvider.user.UserID,
                                }, context);
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 35,
                    child: TabBar(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _tabController,
                      indicatorColor: Colors.green,
                      onTap: (value) {
                        if (value == 0) {
                          appTitle$.add('Messages');
                        } else if (value == 1) {
                          appTitle$.add('Message Groups');
                        } else {
                          appTitle$.add('Message Contact Options');
                        }
                      },
                      tabs: [
                        tabElement(
                          mainProvider: mainProvider,
                          messageProvider: messageProvider,
                          icon: 'assets/images/message/msg.svg',
                          text: "Messages",
                        ),
                        tabElement(
                            mainProvider: mainProvider,
                            messageProvider: messageProvider,
                            icon: 'assets/images/message/msg_group.svg',
                            text: "Groups"),
                        tabElement(
                            mainProvider: mainProvider,
                            messageProvider: messageProvider,
                            icon: 'assets/images/message/msg_option.svg',
                            text: "Options"),
                      ],
                      labelColor: Colors.black,
                      // add it here
                      indicator: RectangularIndicator(
                        color: Colors.grey.withOpacity(0.3),
                        bottomLeftRadius: 10,
                        bottomRightRadius: 10,
                        topLeftRadius: 10,
                        topRightRadius: 10,
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  Expanded(
                      child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _tabController,
                    children: const [
                      MessageTabContainer(),
                      MessageGroups(),
                      ContactOptionPage(),
                    ],
                  )),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget tabElement({
  required String icon,
  required String text,
  required MainProvider mainProvider,
  required MessageProvider messageProvider
}) {
  return Tab(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          icon,
          width: 20,
        ),
        const SizedBox(
          width: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text,
                style: TextStyle(
                    color: mainProvider.darkTheme ? cpWhiteColor : cpDarkBgColor,
                    fontWeight: FontWeight.bold)),
            StreamBuilder<int>(
              stream: messageProvider.messageCount,
              builder: (context, snapshot) {
                if(!snapshot.hasData){
                  return const SizedBox();
                }
               return Visibility(visible: text == 'Messages', child: Badge(badgeContent: Text(snapshot.data.toString()), animationType: BadgeAnimationType.scale, child: const SizedBox(height: 40,)));
            },),
          ],
        ),
      ],
    ),
  );
}

Widget appBarTitle({required String title}) {
  return Text(
    title,
    style: const TextStyle(
        fontWeight: FontWeight.bold, fontSize: 25, color: cpWhiteColor),
  );
}

Widget dropMessageScreen(MainProvider mainProvider) {
  final isManager = mainProvider.isManager();
  return PopupMenuButton(
    child: const IconButton(
      splashRadius: 25,
      icon: Icon(
        Icons.more_vert,
        color: Colors.white,
      ),
      onPressed: null,
    ),
    onSelected: (_) {},
    itemBuilder: (context) {
      return [
        ...[
          if (!isManager)
            MessageScreenWidget('Messages', const Icon(Icons.message_sharp),
                    () {
                  Navigator.of(context).pushNamed('message_container');
                }),
          if (!isManager)
            MessageScreenWidget(
                'Address Book', const Icon(Icons.menu_book_outlined), () {
              Navigator.of(context).pushNamed('address_book');
            }),
          // if (!isManager)
          //   MessageScreenWidget(
          //       'Contact Option', const Icon(Icons.contacts_rounded), () {
          //     Navigator.of(context).pushNamed('contact_option');
          //   }),
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
      ];
    },
  );
}


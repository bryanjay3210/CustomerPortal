import 'package:badges/badges.dart';
import 'package:cp/enum.dart';
import 'package:cp/provider/account/message_provider.dart';
import 'package:cp/provider/main_provider.dart';
import 'package:cp/utils/utils/theme/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../model/message_screen_widget/message_scree_widget.dart';
import '../../provider/account/credit_card_provider.dart';
import '../../provider/account/profile_provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final profileProvider =
          Provider.of<ProfileProvider>(context, listen: false);
      final ccProvider =
          Provider.of<CreditCardProvider>(context, listen: false);
      final mainProvider = Provider.of<MainProvider>(context, listen: false);
      profileProvider.getProfile({
        'customerId': mainProvider.user.CustomerID,
        'userId': mainProvider.user.UserID,
        'server': mainProvider.server
      }, context);
      ccProvider.getCreditCardInfo(
          {'userId': mainProvider.user.UserID, 'server': mainProvider.server},
          context);
      final messageProvider =
          Provider.of<MessageProvider>(context, listen: false);
      messageProvider.getMessage({
        'pollType': 'A',
        'customerID': mainProvider.user.CustomerID,
        'server': mainProvider.server,
        'userId': mainProvider.user.UserID,
      }, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    final messageProvider =
        Provider.of<MessageProvider>(context, listen: false);
    return Scaffold(
        backgroundColor: const Color(0xff30313A),
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 290,
                width: double.infinity,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 30, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Account',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: cpWhiteColor),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 170, 30, 0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          color: const Color(0xff464242),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 90, 20, 0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: GestureDetector(
                          onTap: () =>
                              Navigator.of(context).pushNamed('profile'),
                          child: Container(
                            width: double.infinity,
                            height: 120,
                            color: const Color(0xffFCC76F),
                            child: StreamBuilder<Object>(
                                stream: profileProvider.profileListState,
                                builder: (context, snapshot) {
                                  final data = profileProvider.profile;
                                  if (snapshot.data == DataState.success &&
                                      data.isNotEmpty) {
                                    final profile = data[0];
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          '${profile.UserFirstName.toString()} ${profile.UserLastName.toString()}',
                                          style: TextStyle(
                                              color: mainProvider.darkTheme
                                                  ? cpGreyDarkColor
                                                  : cpWhiteColor,
                                              fontSize: 30,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                                'assets/images/account/mail_logo.svg',
                                                color: mainProvider.darkTheme
                                                    ? cpDarkBgColor
                                                    : cpWhiteColor),
                                            const SizedBox(
                                              width: 2,
                                            ),
                                            Text(
                                                profile.UserEmail.toString() ==
                                                        '{}'
                                                    ? ''
                                                    : profile.UserEmail
                                                        .toString(),
                                                style: TextStyle(
                                                    color:
                                                        mainProvider.darkTheme
                                                            ? cpGreyDarkColor
                                                            : cpWhiteColor)),
                                          ],
                                        ),
                                        GestureDetector(
                                            onTap: () => Navigator.of(context)
                                                .pushNamed('profile'),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text('Profiles ',
                                                    style: TextStyle(
                                                        color: mainProvider
                                                                .darkTheme
                                                            ? cpGreyDarkColor
                                                            : cpWhiteColor)),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  size: 15,
                                                  color: mainProvider.darkTheme
                                                      ? cpGreyDarkColor
                                                      : cpWhiteColor,
                                                )
                                              ],
                                            )),
                                      ],
                                    );
                                  }
                                  return const Center(
                                    child: CircularProgressIndicator.adaptive(),
                                  );
                                }),
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(20, 260, 0, 0),
                      child: Text(
                        'My Account',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  child: SingleChildScrollView(
                    child: Container(
                      color:
                          mainProvider.darkTheme ? cpDarkBgColor : cpWhiteColor,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 25),
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () => Navigator.of(context)
                                      .pushNamed('payment'),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 13),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: SvgPicture.asset(
                                              'assets/images/account/payments_logo.svg'),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Text(
                                          'Payments',
                                          style: TextStyle(fontSize: 15),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const Divider(thickness: 2),
                                GestureDetector(
                                  onTap: () => Navigator.of(context)
                                      .pushNamed('product'),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 13),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: SvgPicture.asset(
                                              'assets/images/account/products_logo.svg'),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Text(
                                          'Products',
                                          style: TextStyle(fontSize: 15),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const Divider(thickness: 2),
                                GestureDetector(
                                  onTap: () => Navigator.of(context)
                                      .pushNamed('invoice'),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 13),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: SvgPicture.asset(
                                              'assets/images/account/invoices_logo.svg'),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Text(
                                          'Invoices',
                                          style: TextStyle(fontSize: 15),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const Divider(thickness: 2),
                                GestureDetector(
                                  onTap: () => Navigator.of(context)
                                      .pushNamed('transaction'),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 13),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: SvgPicture.asset(
                                              'assets/images/account/transactions_logo.svg'),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Text(
                                          'Transactions',
                                          style: TextStyle(fontSize: 15),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const Divider(thickness: 2),
                                GestureDetector(
                                  onTap: () => Navigator.of(context)
                                      .pushNamed('credit_card'),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 13),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: SvgPicture.asset(
                                              'assets/images/account/credit_card_logo.svg'),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Text(
                                          'Edit Credit Card',
                                          style: TextStyle(fontSize: 15),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const Divider(thickness: 2),
                                Column(
                                  children: [
                                    if (!mainProvider.isManager())
                                      GestureDetector(
                                        onTap: () => Navigator.of(context)
                                            .pushNamed('address_book'),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 13),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                height: 20,
                                                width: 20,
                                                child: SvgPicture.asset(
                                                    'assets/images/account/address_book_logo.svg'),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Text(
                                                'Address Book',
                                                style: TextStyle(fontSize: 15),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    if (!mainProvider.isManager())
                                      const Divider(thickness: 2),
                                    mainProvider.isManager()
                                        ? dropMessageScreen(mainProvider)
                                        : GestureDetector(
                                            onTap: () => Navigator.of(context)
                                                .pushNamed('message_container'),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 13),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    height: 20,
                                                    width: 20,
                                                    child: SvgPicture.asset(
                                                        'assets/images/account/messages_logo.svg'),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Row(
                                                    children: const [
                                                       Text(
                                                        'Messages',
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      ),
                                                      // StreamBuilder<DataState>(
                                                      //   stream: messageProvider
                                                      //       .messageListState,
                                                      //   builder: (context,
                                                      //       snapshot) {
                                                      //     int unreadMsgCount =
                                                      //         messageProvider
                                                      //             .messageList
                                                      //             .where((element) =>
                                                      //                 element
                                                      //                     .Ack ==
                                                      //                 'N')
                                                      //             .length;
                                                      //     return unreadMsgCount ==
                                                      //             0
                                                      //         ? const SizedBox()
                                                      //         : Badge(
                                                      //             badgeContent: Text(
                                                      //                 unreadMsgCount
                                                      //                     .toString()),
                                                      //             animationType:
                                                      //                 BadgeAnimationType
                                                      //                     .scale,
                                                      //             child:
                                                      //                 const SizedBox(
                                                      //               width: 20,
                                                      //               height: 20,
                                                      //             ));
                                                      //   },
                                                      // )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * .30,
                            width: double.infinity,
                            color: mainProvider.darkTheme
                                ? cpDarkBgColor
                                : cpWhiteColor,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget dropMessageScreen(MainProvider mainProvider) {
    return PopupMenuButton(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 13.0),
        child: Row(
          children: [
            SizedBox(
              height: 20,
              width: 20,
              child:
                  SvgPicture.asset('assets/images/account/messages_logo.svg'),
            ),
            const SizedBox(
              width: 10,
            ),
            const Text(
              'Messages',
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
      onSelected: (_) {},
      itemBuilder: (context) {
        return [
          ...[
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
}

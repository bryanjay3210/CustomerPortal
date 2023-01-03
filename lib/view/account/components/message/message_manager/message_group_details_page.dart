import 'package:cp/provider/account/message_manager/message_group.dart';
import 'package:cp/view/shared_widgets/button.dart';
import 'package:cp/view/shared_widgets/common_widgets.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../enum.dart';
import '../../../../../model/customer_message_group/customer_message_group.dart';
import '../../../../../model/moderator_message_group/moderator_message_group.dart';
import '../../../../../provider/main_provider.dart';
import '../../../../../shared_widgets/shared_dialog.dart';
import '../../../../../shared_widgets/shared_text_field.dart';
import '../../../../../shared_widgets/toasts.dart';
import '../../../../../utils/utils/theme/global_colors.dart';

class MessageGroupDetailsPage extends StatefulWidget {
  const MessageGroupDetailsPage({Key? key}) : super(key: key);

  @override
  _MessageGroupDetailsPageState createState() =>
      _MessageGroupDetailsPageState();
}

class _MessageGroupDetailsPageState extends State<MessageGroupDetailsPage> {
  final groupNameCtrler = TextEditingController();
  final groupDescCtrler = TextEditingController();
  final defaultAcceptMessage = TextEditingController();
  final defaultRejectMessage = TextEditingController();
  var canReply = false;
  var isRequired = false;
  var isOptional = false;
  var isClosedMembership = false;
  var isLoading = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final messageGroupProvider =
          Provider.of<MessageGroupProvider>(context, listen: false);

      final messageGroup = messageGroupProvider.currentMessageGroup;

      await messageGroupProvider.initializeBuildingDropDown();

      if (!messageGroupProvider.isCreate()) {
        canReply = messageGroup.CanReply == 'Y';
        isRequired = messageGroup.GroupType == 'R';
        isOptional = !isRequired;
        isClosedMembership = messageGroup.GroupAccess == 'C';
        groupNameCtrler.text = messageGroup.GroupName;
        groupDescCtrler.text = messageGroup.GroupDesc;
        defaultAcceptMessage.text = messageGroup.DefaultAcceptMessage;
        defaultRejectMessage.text = messageGroup.DefaultRejectMessage;
        messageGroupProvider.currentModerator =
            messageGroupProvider.getModeratorById(messageGroup.ModeratorUserID);
        if (messageGroup.CanReply == 'Y') {
          messageGroupProvider.currentReplyTo =
              messageGroupProvider.getModeratorByEmail(messageGroup.ReplyEmail);
        }
        messageGroupProvider.currentCustomers = [
          ...messageGroupProvider.currentMessageGroup.CustomerList.map((e) =>
              messageGroupProvider.getCustomerMessageGroupById(e.CustomerID))
        ];
      } else {
        messageGroupProvider.currentModerator = ModeratorMessageGroup();
        messageGroupProvider.currentCustomers = <CustomerMessageGroup>[];
      }
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    final messageGroupProvider =
        Provider.of<MessageGroupProvider>(context, listen: false);
    final isDarkMode = mainProvider.isDarkMode;

    return WillPopScope(
      onWillPop: () async {
        return !isLoading;
      },
      child: Scaffold(
          appBar: popUpPageAppBar(messageGroupProvider.isCreate()
              ? 'Create Message Group'
              : 'Update Message Group'),
          body: isLoading
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Expanded(
                        child: Center(
                            child: CircularProgressIndicator.adaptive())),
                  ],
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Building',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          messageGroupProvider.currentBuilding.BuildingName,
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 20),
                        textFieldShared(context,
                            title: '*Group Name',
                            readOnly: false,
                            isDarkMode: isDarkMode,
                            ctrler: groupNameCtrler,
                            hasUnderlineBorder: true),
                        const SizedBox(width: 10),
                        textFieldShared(context,
                            title: '*Group Description',
                            readOnly: false,
                            isDarkMode: isDarkMode,
                            ctrler: groupDescCtrler,
                            hasUnderlineBorder: true),
                        const SizedBox(width: 10),
                        textFieldShared(context,
                            title: '*Default Accept Message',
                            readOnly: false,
                            isDarkMode: isDarkMode,
                            ctrler: defaultAcceptMessage,
                            hasUnderlineBorder: true),
                        const SizedBox(width: 10),
                        textFieldShared(context,
                            title: '*Default Reject Message',
                            readOnly: false,
                            isDarkMode: isDarkMode,
                            ctrler: defaultRejectMessage,
                            hasUnderlineBorder: true),
                        Row(
                          children: [
                            Checkbox(
                              onChanged: (bool? newValue) {
                                setState(() {
                                  canReply = !canReply;
                                });
                              },
                              value: canReply,
                            ),
                            const Text('Can Reply?'),
                          ],
                        ),
                        const SizedBox(height: 10),
                        if (canReply) const Text('*Select Reply To'),
                        if (canReply) const SizedBox(height: 10),
                        if (canReply)
                          StreamBuilder<ButtonState>(
                              stream:
                                  messageGroupProvider.dropDownSearchCustomers$,
                              builder: (context, snapshot) {
                                return DropdownSearch<ModeratorMessageGroup>(
                                  popupProps: const PopupProps.menu(
                                    showSearchBox: true,
                                  ),
                                  itemAsString: (ModeratorMessageGroup b) =>
                                      b.UserName,
                                  items: messageGroupProvider
                                      .moderatorsPopupSearch$.value,
                                  selectedItem:
                                      messageGroupProvider.currentReplyTo,
                                  onChanged: (value) {
                                    if (value == null) {
                                      return;
                                    }
                                  },
                                );
                              }),
                        if (canReply) const SizedBox(height: 10),
                        const Text('*Group Type'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  // value: isCardAutoBilling,
                                  onChanged: (bool? newValue) {
                                    setState(() {
                                      isOptional = isRequired;
                                      isRequired = !isRequired;
                                      isClosedMembership = false;
                                    });
                                  },
                                  value: isRequired,
                                ),
                                const Text('Required'),
                              ],
                            ),
                            const SizedBox(width: 20),
                            Row(
                              children: [
                                Checkbox(
                                  // value: isCardAutoBilling,
                                  onChanged: (bool? newValue) {
                                    setState(() {
                                      isRequired = isOptional;
                                      isOptional = !isOptional;
                                    });
                                  },
                                  value: isOptional,
                                ),
                                const Text('Optional'),
                              ],
                            ),
                          ],
                        ),
                        if (isOptional) const SizedBox(height: 10),
                        if (isOptional) const Text('Closed Membership'),
                        if (isOptional)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    onChanged: (bool? newValue) {
                                      setState(() {
                                        isClosedMembership = true;
                                      });
                                    },
                                    value: isClosedMembership,
                                  ),
                                  const Text('Yes'),
                                ],
                              ),
                              const SizedBox(width: 20),
                              Row(
                                children: [
                                  Checkbox(
                                    onChanged: (bool? newValue) {
                                      setState(() {
                                        isClosedMembership = false;
                                      });
                                    },
                                    value: !isClosedMembership,
                                  ),
                                  const Text('No'),
                                ],
                              ),
                            ],
                          ),
                        const SizedBox(height: 10),
                        const Text('*Select Moderator'),
                        const SizedBox(height: 10),
                        StreamBuilder<List<ModeratorMessageGroup>>(
                            stream: messageGroupProvider.moderatorsPopupSearch$,
                            builder: (context, snapshot) {
                              if (snapshot.data == null) {
                                return const SizedBox();
                              }
                              if (snapshot.data!.isEmpty) {
                                return const SizedBox();
                              }
                              final moderators = snapshot.data;
                              return DropdownSearch<ModeratorMessageGroup>(
                                popupProps: const PopupProps.menu(
                                  showSearchBox: true,
                                ),
                                itemAsString: (ModeratorMessageGroup b) =>
                                    b.UserName,
                                items: moderators!,
                                onChanged: (value) {
                                  if (value == null) {
                                    return;
                                  }
                                  messageGroupProvider.currentModerator = value;
                                },
                                selectedItem:
                                    messageGroupProvider.currentModerator,
                              );
                            }),
                        const SizedBox(height: 20),
                        Visibility(
                          visible: !isRequired,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('*Select Customers'),
                              const SizedBox(height: 10),
                              StreamBuilder<List<CustomerMessageGroup>>(
                                  stream: messageGroupProvider.customerPopupSearch$,
                                  builder: (context, snapshot) {
                                    if (snapshot.data == null) {
                                      return const SizedBox();
                                    }
                                    if (snapshot.data!.isEmpty) {
                                      return const SizedBox();
                                    }
                                    final customers = snapshot.data;
                                    return DropdownSearch<
                                        CustomerMessageGroup>.multiSelection(
                                        popupProps: PopupPropsMultiSelection.menu(
                                          showSearchBox: true,
                                          containerBuilder: (context, popupWidget) =>
                                              Column(
                                                children: [
                                                  Expanded(child: popupWidget),
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                    children: [
                                                      ElevatedButton(
                                                          style: TextButton.styleFrom(
                                                              backgroundColor:
                                                              Colors.red),
                                                          onPressed: () {
                                                            Navigator.of(context).pop();
                                                            messageGroupProvider
                                                                .currentCustomers = [];
                                                            messageGroupProvider
                                                                .customerPopupSearch$
                                                                .add(messageGroupProvider
                                                                .customerPopupSearch);
                                                            Future.delayed(
                                                                const Duration(
                                                                    milliseconds: 100),
                                                                    () {
                                                                  messageGroupProvider
                                                                      .customerPopupSearch$
                                                                      .add(messageGroupProvider
                                                                      .customerPopupSearch);
                                                                });
                                                          },
                                                          child: const Text(
                                                            'Unselect All',
                                                          )),
                                                      const SizedBox(width: 25),
                                                      ElevatedButton(
                                                          style: TextButton.styleFrom(
                                                              backgroundColor:
                                                              cpPrimaryColor),
                                                          onPressed: () {
                                                            Navigator.of(context).pop();
                                                            messageGroupProvider
                                                                .currentCustomers =
                                                                messageGroupProvider
                                                                    .customerPopupSearch;
                                                            messageGroupProvider
                                                                .customerPopupSearch$
                                                                .add(messageGroupProvider
                                                                .customerPopupSearch);
                                                            Future.delayed(
                                                                const Duration(
                                                                    milliseconds: 100),
                                                                    () {
                                                                  messageGroupProvider
                                                                      .customerPopupSearch$
                                                                      .add(messageGroupProvider
                                                                      .customerPopupSearch);
                                                                });
                                                          },
                                                          child:
                                                          const Text('Select All')),
                                                      const SizedBox(width: 10)
                                                    ],
                                                  )
                                                ],
                                              ),
                                        ),
                                        itemAsString: (CustomerMessageGroup b) =>
                                        b.Name,
                                        items: customers!,
                                        onChanged: ((value) {
                                          if (value == null) {
                                            return;
                                          }
                                          messageGroupProvider.currentCustomers =
                                              value;
                                        }),
                                        selectedItems:
                                        messageGroupProvider.currentCustomers);
                                  }),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                        StretchableButton(
                          text: 'Save',
                          onPressed: () async {
                            if (groupNameCtrler.text.isEmpty) {
                              showToast('Group Name is empty');
                              return;
                            }

                            if (groupDescCtrler.text.isEmpty) {
                              showToast('Group Description is empty');
                              return;
                            }

                            if (defaultAcceptMessage.text.isEmpty) {
                              showToast('Default Accept Message is empty');
                              return;
                            }

                            if (defaultRejectMessage.text.isEmpty) {
                              showToast('Default Reject Message is empty');
                              return;
                            }

                            if (canReply) {
                              if (messageGroupProvider.currentReplyTo.UserID ==
                                  '') {
                                showToast('Reply To is empty');
                                return;
                              }
                            }

                            if (!isRequired && !isOptional) {
                              showToast('Group Type is empty');
                              return;
                            }

                            if (messageGroupProvider.currentModerator.UserID ==
                                '') {
                              showToast('Moderator is empty');
                              return;
                            }

                            setState(() {
                              isLoading = true;
                            });
                            final map = {
                              'groupName': groupNameCtrler.text,
                              'canReply': canReply ? 'Y' : 'N',
                              'groupDesc': groupDescCtrler.text,
                              'groupType': isRequired ? 'R' : 'O',
                              'groupAccess': isClosedMembership ? 'C' : 'O',
                              'defaultAcceptMsg': defaultAcceptMessage.text,
                              'defaultRejectMsg': defaultRejectMessage.text,
                              'replyEmail': canReply
                                  ? messageGroupProvider
                                      .currentReplyTo.UserEmail
                                  : '',
                              'moderatorsEmail': messageGroupProvider
                                  .currentModerator.UserEmail,
                              'moderatorCustomerId': messageGroupProvider
                                  .currentModerator.CustomerID,
                              'moderatorUserId':
                                  messageGroupProvider.currentModerator.UserID,
                              'customerList': [
                                ...messageGroupProvider.currentCustomers
                                    .map((e) => int.parse(e.CustomerID))
                              ],
                            };

                            if (messageGroupProvider.isCreate()) {
                              await messageGroupProvider.createMessageGroup(
                                  map, context);
                              showToast('Message Group Successfully Added');
                            } else {
                              await messageGroupProvider.updateMessageGroup(
                                  map, context);
                              showToast('Message Group Successfully Updated');
                            }

                            setState(() {
                              isLoading = false;
                              Navigator.of(context).pop();
                            });
                          },
                        ),
                        const SizedBox(height: 10),
                        if (!messageGroupProvider.isCreate())
                          StretchableButton(
                              text: 'Delete',
                              onPressed: () async {
                                final res = await showConfirmDialog(context,
                                    'Are you sure you want to delete this message group?');
                                if (res) {
                                  messageGroupProvider.removeGroup({}, context);
                                }
                              },
                              color: Colors.red),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                )),
    );
  }
}

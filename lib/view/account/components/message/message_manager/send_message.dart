import 'package:cp/model/message_group/message_group.dart';
import 'package:cp/model/message_template_widget/message_template_widget.dart';
import 'package:cp/shared_widgets/shared_dialog.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../constants.dart';
import '../../../../../enum.dart';
import '../../../../../model/customer_message_group/customer_message_group.dart';
import '../../../../../provider/account/message_manager/message_group.dart';
import '../../../../../provider/account/message_manager/message_template.dart';
import '../../../../../provider/account/message_manager/send_message.dart';
import '../../../../../provider/main_provider.dart';
import '../../../../../shared_widgets/shared_text_field.dart';
import '../../../../../shared_widgets/toasts.dart';
import '../../../../../utils/utils/theme/global_colors.dart';

class SendMessagePage extends StatefulWidget {
  const SendMessagePage({Key? key}) : super(key: key);

  @override
  _SendMessagePageState createState() => _SendMessagePageState();
}

class _SendMessagePageState extends State<SendMessagePage> {
  var isLoading = true;
  final messageCtrler = TextEditingController();
  final subjectCtrler = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final messageGroupProvider =
          Provider.of<MessageGroupProvider>(context, listen: false);
      final messageTemplateProvider =
          Provider.of<MessageTemplateProvider>(context, listen: false);
      final sendMessageProvider =
          Provider.of<SendMessageProvider>(context, listen: false);
      sendMessageProvider.currentCustomers = [];
      sendMessageProvider.currentMessageGroups = [];
      await messageGroupProvider.getMessageGroups({}, context);
      await messageGroupProvider.getCustomers({}, context);
      await messageTemplateProvider.getTemplates({}, context);
      sendMessageProvider.messageTemplateWidgets$.add([
        ...messageTemplateProvider.templates
            .map<MessageTemplateWidget>((e) => MessageTemplateWidget(
                TemplateName: e.TemplateName,
                TemplateText: e.TemplateText,
                TemplateID: e.TemplateID,
                isSelected: false))
            .toList()
      ]);
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    final isDarkMode = mainProvider.isDarkMode;
    final messageGroupProvider =
        Provider.of<MessageGroupProvider>(context, listen: false);
    final sendMessageProvider =
        Provider.of<SendMessageProvider>(context, listen: false);
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
            body: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: IntrinsicHeight(
                // height: mqHeight(context),
                child: Column(
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
                              'Compose Message',
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Message Groups'),
                          const SizedBox(height: 5),
                          StreamBuilder<ButtonState>(
                              stream: sendMessageProvider.messageGroup$,
                              builder: (context, snapshot) {
                                if (snapshot.data == null) {
                                  return const SizedBox();
                                }
                                if (snapshot.data == ButtonState.loading) {
                                  return const SizedBox();
                                }

                                return DropdownSearch<
                                        MessageGroup>.multiSelection(
                                    popupProps: PopupPropsMultiSelection.menu(
                                      showSearchBox: true,
                                      containerBuilder:
                                          (context, popupWidget) => Column(
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
                                                    sendMessageProvider
                                                        .currentMessageGroups = [];
                                                    sendMessageProvider
                                                        .messageGroup$
                                                        .add(ButtonState
                                                            .loading);
                                                    Future.delayed(
                                                        const Duration(
                                                            milliseconds: 100),
                                                        () {
                                                      sendMessageProvider
                                                          .messageGroup$
                                                          .add(ButtonState
                                                              .loaded);
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
                                                    sendMessageProvider
                                                            .currentMessageGroups =
                                                        messageGroupProvider
                                                            .messageGroups;
                                                    sendMessageProvider
                                                        .messageGroup$
                                                        .add(ButtonState
                                                            .loading);
                                                    Future.delayed(
                                                        const Duration(
                                                            milliseconds: 100),
                                                        () {
                                                      sendMessageProvider
                                                          .messageGroup$
                                                          .add(ButtonState
                                                              .loaded);
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
                                    itemAsString: (MessageGroup b) =>
                                        b.GroupName,
                                    items: messageGroupProvider.messageGroups,
                                    onChanged: ((value) {
                                      sendMessageProvider.currentMessageGroups =
                                          value;
                                    }),
                                    selectedItems: sendMessageProvider
                                        .currentMessageGroups);
                              }),
                          const SizedBox(height: 15),
                          const Text('Customers'),
                          const SizedBox(height: 5),
                          StreamBuilder<ButtonState>(
                              stream: sendMessageProvider.customers$,
                              builder: (context, snapshot) {
                                if (snapshot.data == null) {
                                  return const SizedBox();
                                }
                                if (snapshot.data == ButtonState.loading) {
                                  return const SizedBox();
                                }

                                return DropdownSearch<
                                        CustomerMessageGroup>.multiSelection(
                                    popupProps: PopupPropsMultiSelection.menu(
                                      showSearchBox: true,
                                      containerBuilder:
                                          (context, popupWidget) => Column(
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
                                                    sendMessageProvider
                                                        .currentCustomers = [];
                                                    sendMessageProvider
                                                        .customers$
                                                        .add(ButtonState
                                                            .loading);
                                                    Future.delayed(
                                                        const Duration(
                                                            milliseconds: 100),
                                                        () {
                                                      sendMessageProvider
                                                          .customers$
                                                          .add(ButtonState
                                                              .loaded);
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
                                                    sendMessageProvider
                                                            .currentCustomers =
                                                        messageGroupProvider
                                                            .customerPopupSearch;
                                                    sendMessageProvider
                                                        .customers$
                                                        .add(ButtonState
                                                            .loading);
                                                    Future.delayed(
                                                        const Duration(
                                                            milliseconds: 100),
                                                        () {
                                                      sendMessageProvider
                                                          .customers$
                                                          .add(ButtonState
                                                              .loaded);
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
                                    items: messageGroupProvider
                                        .customerPopupSearch,
                                    onChanged: ((value) {
                                      sendMessageProvider.currentCustomers =
                                          value;
                                    }),
                                    selectedItems:
                                        sendMessageProvider.currentCustomers);
                              }),
                          const SizedBox(height: 15),
                          const Text('Subject'),
                          const SizedBox(height: 5),
                          textFieldShared2(context, ctrler: subjectCtrler),
                          const SizedBox(height: 35),
                          StreamBuilder<MessageTemplateWidget>(
                              stream: sendMessageProvider.currentTemplate$,
                              builder: (context, snapshot) {
                                if (snapshot.data == null) {
                                  return const SizedBox();
                                }
                                return textFieldShared(context,
                                    suffixIcon: GestureDetector(
                                      onTap: () async {
                                        if (sendMessageProvider
                                                .currentMessageGroups.isEmpty &&
                                            sendMessageProvider
                                                .currentCustomers.isEmpty) {
                                          showToast(
                                              'Message Group & Customer is empty');
                                          return;
                                        }

                                        if (messageCtrler.text.trim().isEmpty) {
                                          showToast('Message is empty');
                                          return;
                                        }

                                        if (await showConfirmDialog(context,
                                            'Are you sure you want to send this message?')) {
                                          sendMessageProvider.sendMessage({
                                            'subject': subjectCtrler.text,
                                            'sendText': messageCtrler.text,
                                            'template':
                                                snapshot.data!.TemplateID
                                          }, context);
                                          FocusScope.of(context).unfocus();
                                        }
                                      },
                                      child: const Icon(
                                        Icons.send,
                                        color: cpPrimaryColor,
                                      ),
                                    ),
                                    title: 'Message',
                                    ctrler: messageCtrler,
                                    isTextArea: true,
                                    hasUnderlineBorder: true,
                                    readOnly: false);
                              }),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    showDialogShared(
                                        context,
                                        SizedBox(
                                            width: mqWidth(context) - 50,
                                            child: Column(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey.shade500,
                                                    borderRadius:
                                                        const BorderRadius
                                                                .vertical(
                                                            top:
                                                                Radius.circular(
                                                                    15)),
                                                  ),
                                                  height: 50,
                                                  width: double.infinity,
                                                  child: const Center(
                                                    child: Text(
                                                        'Select Template to Apply',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15)),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: ListView.separated(
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return ListTile(
                                                        onTap: () {
                                                          final isSelected =
                                                              sendMessageProvider
                                                                  .messageTemplateWidgets$
                                                                  .value[index]
                                                                  .isSelected;
                                                          final newData = [
                                                            ...sendMessageProvider
                                                                .messageTemplateWidgets$
                                                                .value
                                                                .map<MessageTemplateWidget>((e) =>
                                                                    e.copyWith(
                                                                        isSelected:
                                                                            false))
                                                                .toList()
                                                          ];

                                                          if (isSelected) {
                                                          } else {
                                                            newData[
                                                                index] = newData[
                                                                    index]
                                                                .copyWith(
                                                                    isSelected:
                                                                        !newData[index]
                                                                            .isSelected);
                                                          }

                                                          sendMessageProvider
                                                              .messageTemplateWidgets$
                                                              .add(newData);

                                                          if (newData[index]
                                                                      .TemplateText ==
                                                                  '' ||
                                                              isSelected) {
                                                            messageCtrler.text =
                                                                '';
                                                            sendMessageProvider
                                                                .currentTemplate$
                                                                .add(MessageTemplateWidget(
                                                                    isSelected:
                                                                        false,
                                                                    TemplateID:
                                                                        ''));
                                                          } else {
                                                            messageCtrler
                                                                .text = newData[
                                                                    index]
                                                                .TemplateText;
                                                            sendMessageProvider
                                                                .currentTemplate$
                                                                .add(newData[
                                                                    index]);
                                                          }
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        title: Text(
                                                            sendMessageProvider
                                                                .messageTemplateWidgets$
                                                                .value[index]
                                                                .TemplateName),
                                                      );
                                                    },
                                                    itemCount: sendMessageProvider
                                                        .messageTemplateWidgets$
                                                        .value
                                                        .length,
                                                    separatorBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return const Divider();
                                                    },
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      TextButton(
                                                        child: Text('Cancel',
                                                            style: TextStyle(
                                                                color: isDarkMode
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black)),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                      const SizedBox(width: 10),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )));
                                  },
                                  child: const Text('Use Template'),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              cpPrimaryColor),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      )))),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('       Cancel       '),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.grey.shade500),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      )))),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

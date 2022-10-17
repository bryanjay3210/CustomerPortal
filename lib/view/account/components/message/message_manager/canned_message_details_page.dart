import 'package:cp/provider/account/message_manager/canned_message.dart';
import 'package:cp/provider/account/message_manager/message_group.dart';
import 'package:cp/view/shared_widgets/button.dart';
import 'package:cp/view/shared_widgets/common_widgets.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../enum.dart';
import '../../../../../model/customer/customer.dart';
import '../../../../../model/message_group/message_group.dart';
import '../../../../../model/target/target.dart';
import '../../../../../provider/main_provider.dart';
import '../../../../../shared_widgets/shared_dialog.dart';
import '../../../../../shared_widgets/shared_text_field.dart';
import '../../../../../shared_widgets/toasts.dart';
import '../../../../../utils/utils/theme/global_colors.dart';

class CannedMessageDetailsPage extends StatefulWidget {
  const CannedMessageDetailsPage({Key? key}) : super(key: key);

  @override
  _CannedMessageDetailsPageState createState() =>
      _CannedMessageDetailsPageState();
}

class _CannedMessageDetailsPageState extends State<CannedMessageDetailsPage> {
  final requestTitleCtrler = TextEditingController();
  var isLoading = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final cannedMessageProvider =
          Provider.of<CannedMessageProvider>(context, listen: false);
      cannedMessageProvider.currentMessageGroups = [];
      final currentRequest = cannedMessageProvider.currentCannedRequest;
      if (!cannedMessageProvider.isCreate) {
        requestTitleCtrler.text = currentRequest.RequestTitle;
        cannedMessageProvider.currentTargets = cannedMessageProvider
            .currentCannedRequest.RequestTarget
            .toString()
            .split(',')
            .map((e) {
          if (e.isEmpty) {
            return Target(TargetEmail: 'No Email');
          }
          return cannedMessageProvider.getTarget(e);
        }).toList();
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
    final cannedMessageProvider =
        Provider.of<CannedMessageProvider>(context, listen: false);
    final isDarkMode = mainProvider.isDarkMode;
    return WillPopScope(
      onWillPop: () async {
        return !isLoading;
      },
      child: Scaffold(
          appBar: popUpPageAppBar(cannedMessageProvider.isCreate
              ? 'Create Canned Message'
              : 'Update Canned Message'),
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
                            title: '*Request Title',
                            readOnly: false,
                            isDarkMode: isDarkMode,
                            ctrler: requestTitleCtrler,
                            hasUnderlineBorder: true),
                        const SizedBox(height: 20),
                        const Text('Message Groups'),
                        const SizedBox(height: 5),
                        StreamBuilder<ButtonState>(
                            stream: cannedMessageProvider.group$,
                            builder: (context, snapshot) {
                              if (snapshot.data == null) {
                                return const SizedBox();
                              }

                              if (snapshot.data == ButtonState.loading) {
                                return const SizedBox();
                              }

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DropdownSearch<MessageGroup>.multiSelection(
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
                                                    cannedMessageProvider
                                                        .currentMessageGroups = [];
                                                    cannedMessageProvider
                                                        .currentTargets = [];
                                                    cannedMessageProvider.group$
                                                        .add(ButtonState
                                                            .loading);
                                                    Future.delayed(
                                                        const Duration(
                                                            milliseconds: 100),
                                                        () {
                                                      cannedMessageProvider
                                                          .group$
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
                                                    cannedMessageProvider
                                                            .currentMessageGroups =
                                                        messageGroupProvider
                                                            .messageGroups;
                                                    for (var element
                                                        in cannedMessageProvider
                                                            .currentMessageGroups) {
                                                      final list = <Target>[];
                                                      for (var i in element
                                                          .CustomerList) {
                                                        if (i.CustomerTargetEmail
                                                                is Map ==
                                                            false) {
                                                          list.add(Target(
                                                              TargetEmail: i
                                                                  .CustomerTargetEmail,
                                                              TargetID: i
                                                                  .CustomerTargetID));
                                                        }
                                                      }
                                                      cannedMessageProvider
                                                          .currentTargets
                                                          .addAll(list);
                                                    }

                                                    cannedMessageProvider.group$
                                                        .add(ButtonState
                                                            .loading);
                                                    Future.delayed(
                                                        const Duration(
                                                            milliseconds: 100),
                                                        () {
                                                      cannedMessageProvider
                                                          .group$
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
                                      cannedMessageProvider.group$
                                          .add(ButtonState.loading);
                                      cannedMessageProvider
                                          .currentMessageGroups = value;
                                      cannedMessageProvider.currentTargets = [];
                                      for (var element in value) {
                                        final list = <Target>[];
                                        for (var i in element.CustomerList) {
                                          if (i.CustomerTargetEmail is Map ==
                                              false) {
                                            list.add(Target(
                                                TargetEmail:
                                                    i.CustomerTargetEmail,
                                                TargetID: i.CustomerTargetID));
                                          }
                                        }
                                        cannedMessageProvider.currentTargets
                                            .addAll(list);
                                      }

                                      Future.delayed(
                                          const Duration(milliseconds: 100),
                                          () {
                                        cannedMessageProvider.group$
                                            .add(ButtonState.loaded);
                                      });
                                    }),
                                    selectedItems: cannedMessageProvider
                                        .currentMessageGroups,
                                  ),
                                  const SizedBox(height: 20),
                                  const Text('*Request Target'),
                                  const SizedBox(height: 5),
                                  StreamBuilder<ButtonState>(
                                      stream: cannedMessageProvider
                                          .cannedRequestDropdownSearch$,
                                      builder: (context, snapshot) {
                                        if (snapshot.data == null) {
                                          return const SizedBox();
                                        }
                                        if (snapshot.data ==
                                            ButtonState.loading) {
                                          return const SizedBox();
                                        }

                                        return DropdownSearch<
                                            Target>.multiSelection(
                                          popupProps:
                                              PopupPropsMultiSelection.menu(
                                            showSearchBox: true,
                                            containerBuilder:
                                                (context, popupWidget) =>
                                                    Column(
                                              children: [
                                                Expanded(child: popupWidget),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    ElevatedButton(
                                                        style: TextButton
                                                            .styleFrom(
                                                                backgroundColor:
                                                                    Colors.red),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                          cannedMessageProvider
                                                              .currentTargets = [];

                                                          cannedMessageProvider
                                                              .cannedRequestDropdownSearch$
                                                              .add(ButtonState
                                                                  .loading);
                                                          Future.delayed(
                                                              const Duration(
                                                                  milliseconds:
                                                                      100), () {
                                                            cannedMessageProvider
                                                                .cannedRequestDropdownSearch$
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
                                                          Navigator.of(context)
                                                              .pop();
                                                          cannedMessageProvider
                                                                  .currentTargets =
                                                              cannedMessageProvider
                                                                  .targets;
                                                          cannedMessageProvider
                                                              .cannedRequestDropdownSearch$
                                                              .add(ButtonState
                                                                  .loading);
                                                          Future.delayed(
                                                              const Duration(
                                                                  milliseconds:
                                                                      100), () {
                                                            cannedMessageProvider
                                                                .cannedRequestDropdownSearch$
                                                                .add(ButtonState
                                                                    .loaded);
                                                          });
                                                        },
                                                        child: const Text(
                                                            'Select All')),
                                                    const SizedBox(width: 10)
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          itemAsString: (Target b) =>
                                              b.TargetEmail,
                                          items: cannedMessageProvider.targets
                                              .where((element) =>
                                                  element.TargetEmail != '')
                                              .toList(),
                                          selectedItems: cannedMessageProvider
                                              .currentTargets,
                                          onChanged: (value) {
                                            if (value == null) {
                                              return;
                                            }
                                            cannedMessageProvider
                                                .currentTargets = value;
                                          },
                                        );
                                      }),
                                ],
                              );
                            }),
                        const SizedBox(height: 40),
                        StretchableButton(
                          text: 'Save',
                          onPressed: () async {
                            if (requestTitleCtrler.text.isEmpty) {
                              showToast('Request title is empty');
                              return;
                            }

                            if (cannedMessageProvider.currentTargets.isEmpty) {
                              showToast('Request target is empty');
                              return;
                            }

                            setState(() {
                              isLoading = true;
                            });
                            final map = {
                              'requestTitle': requestTitleCtrler.text
                            };
                            // cannedMessageProvider.currentTargets
                            //     .removeWhere((element) {
                            //   return element.ResidentName == '';
                            // });
                            if (cannedMessageProvider.isCreate) {
                              await cannedMessageProvider.createCannedRequest(
                                  map, context);
                            } else {
                              await cannedMessageProvider.updateCannedRequest(
                                  map, context);
                            }

                            setState(() {
                              isLoading = false;
                            });
                          },
                        ),
                        const SizedBox(height: 10),
                        if (!cannedMessageProvider.isCreate)
                          StretchableButton(
                              text: 'Delete',
                              onPressed: () async {
                                final res = await showConfirmDialog(context,
                                    'Are you sure you want to delete this canned message?');
                                if (res) {
                                  cannedMessageProvider
                                      .removeCannedRequest({}, context);
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

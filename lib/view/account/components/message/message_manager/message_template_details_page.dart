import 'package:cp/provider/account/message_manager/message_group.dart';
import 'package:cp/provider/account/message_manager/message_template.dart';
import 'package:cp/view/shared_widgets/button.dart';
import 'package:cp/view/shared_widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../enum.dart';
import '../../../../../provider/main_provider.dart';
import '../../../../../shared_widgets/shared_dialog.dart';
import '../../../../../shared_widgets/shared_text_field.dart';
import '../../../../../shared_widgets/toasts.dart';

class MessageTemplateDetailsPage extends StatefulWidget {
  const MessageTemplateDetailsPage({Key? key}) : super(key: key);

  @override
  _MessageTemplateDetailsPageState createState() =>
      _MessageTemplateDetailsPageState();
}

class _MessageTemplateDetailsPageState
    extends State<MessageTemplateDetailsPage> {
  final templateNameCtrler = TextEditingController();
  final templateTextCtrler = TextEditingController();
  final templateVariablesCtler = TextEditingController();
  var _currentSelectedValue = '';
  var selectedCustomers = <int>[];
  var isLoading = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final messageTemplateProvider =
          Provider.of<MessageTemplateProvider>(context, listen: false);
      await messageTemplateProvider.getTemplateVariable({}, context);
      final messageTemplate = messageTemplateProvider.selectedTemplate;

      if (!messageTemplateProvider.isCreate()) {
        templateNameCtrler.text = messageTemplate.TemplateName;
        templateTextCtrler.text = messageTemplate.TemplateText;
      } else {}
      setState(() {
        isLoading = false;
      });
    });
  }

  void addTemplateVariable(String newString) {
    var cursorPos = templateTextCtrler.selection.base.offset;

    // Right text of cursor position
    String suffixText = templateTextCtrler.text.substring(cursorPos);

    // Add new text on cursor position
    String specialChars = ' $newString ';
    int length = specialChars.length;

    // Get the left text of cursor
    String prefixText = templateTextCtrler.text.substring(0, cursorPos);

    templateTextCtrler.text = prefixText + specialChars + suffixText;

    // Cursor move to end of added text
    templateTextCtrler.selection = TextSelection(
      baseOffset: cursorPos + length,
      extentOffset: cursorPos + length,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    final messageTemplateProvider =
        Provider.of<MessageTemplateProvider>(context, listen: false);
    final messageGroupProvider =
        Provider.of<MessageGroupProvider>(context, listen: false);
    final isDarkMode = mainProvider.isDarkMode;

    return WillPopScope(
      onWillPop: () async {
        return !isLoading;
      },
      child: Scaffold(
          appBar: popUpPageAppBar(messageTemplateProvider.isCreate()
              ? 'Create Template Group'
              : 'Update Template Group'),
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
                        textFieldShared(
                          context,
                          title: '*Template Name',
                          readOnly: false,
                          isDarkMode: isDarkMode,
                          ctrler: templateNameCtrler,
                          hasUnderlineBorder: true,
                        ),
                        const SizedBox(height: 10),
                        textFieldShared(context,
                            title: 'Template Text',
                            ctrler: templateTextCtrler,
                            isTextArea: true,
                            hasUnderlineBorder: true,
                            readOnly: false),
                        const SizedBox(height: 10),
                        const Text('Template Variable',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 200,
                          child: StreamBuilder<DataState>(
                              stream: messageTemplateProvider.templateVariable$,
                              builder: (context, snapshot) {
                                if (snapshot.data == null) {
                                  return const SizedBox();
                                }

                                if (snapshot.data == DataState.empty) {
                                  return const Center(
                                      child: Text('No Template Variable'));
                                }
                                final variables =
                                    messageTemplateProvider.templateVariables;
                                return ListView.builder(
                                  itemCount: messageTemplateProvider
                                      .templateVariables.length,
                                  itemBuilder: (context, index) {
                                    final variable = variables[index];
                                    return GestureDetector(
                                        onTap: () {
                                          addTemplateVariable(
                                              variable.VariableName);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 3.0),
                                          child: Card(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                  '${variable.VariableName} : ${variable.VariableSub}'),
                                            ),
                                          ),
                                        ));
                                  },
                                );
                              }),
                        ),
                        const SizedBox(height: 40),
                        StretchableButton(
                          text: 'Save',
                          onPressed: () async {
                            // if (messageTemplateProvider
                            //         .buildingDetail.BuildingID ==
                            //     '') {
                            //   showToast('Building is empty');
                            //   return;
                            // }

                            if (templateNameCtrler.text.isEmpty) {
                              showToast('Template name is empty');
                              return;
                            }
                            if (templateTextCtrler.text.isEmpty) {
                              showToast('Template text is empty');
                              return;
                            }

                            setState(() {
                              isLoading = true;
                            });

                            final map = {
                              'templateName': templateNameCtrler.text,
                              'templateText': templateTextCtrler.text,
                            };

                            if (messageTemplateProvider.isCreate()) {
                              await messageTemplateProvider
                                  .createMessageTemplate(map, context);
                              showToast('Message Template Successfully Added');
                            } else {
                              await messageTemplateProvider
                                  .updateMessageTemplate(map, context);
                              showToast(
                                  'Message Template Successfully Updated');
                            }

                            setState(() {
                              isLoading = false;
                              Navigator.of(context).pop();
                            });
                          },
                        ),
                        const SizedBox(height: 10),
                        if (!messageTemplateProvider.isCreate())
                          StretchableButton(
                              text: 'Delete',
                              onPressed: () async {
                                final res = await showConfirmDialog(context,
                                    'Are you sure you want to delete this message template?');
                                if (res) {
                                  messageTemplateProvider
                                      .removeTemplate({}, context);
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

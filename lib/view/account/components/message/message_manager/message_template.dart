import 'package:cp/model/message_group/message_group.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../enum.dart';
import '../../../../../model/message_template/message_template.dart';
import '../../../../../provider/account/message_manager/message_group.dart';
import '../../../../../provider/account/message_manager/message_template.dart';
import '../../../../../provider/main_provider.dart';
import '../../../../../utils/utils/theme/global_colors.dart';

class MessageTemplatePage extends StatefulWidget {
  const MessageTemplatePage({Key? key}) : super(key: key);

  @override
  _MessageTemplatePageState createState() => _MessageTemplatePageState();
}

class _MessageTemplatePageState extends State<MessageTemplatePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final messageTemplateProvider =
          Provider.of<MessageTemplateProvider>(context, listen: false);
      // messageGroupProvider.getBuildings({}, context);
      messageTemplateProvider.getTemplates({}, context);
      // final mainProvider = Provider.of<MainProvider>(context, listen: false);
      // final productProvider =
      //     Provider.of<ProductProvider>(context, listen: false);
      // productProvider.getCustomerProduct({
      //   'customerId': mainProvider.user.CustomerID,
      //   'planID': widget.planId,
      //   'userId': mainProvider.user.UserID,
      //   'server': mainProvider.server,
      // }, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    final isDarkMode = mainProvider.isDarkMode;
    final messageGroupProvider =
        Provider.of<MessageGroupProvider>(context, listen: false);
    final messageTemplateProvider =
        Provider.of<MessageTemplateProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: mainProvider.darkTheme ? cpDarkBgColor : cpWhiteColor,
      body: Column(
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
                    'Message Templates',
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
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text('Building Name',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                Text(
                  messageGroupProvider.currentBuilding.BuildingName,
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          // Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 15.0),
          //     child: dropDownBuildings(messageTemplateProvider)),
          const SizedBox(height: 5),
          Divider(
              color: isDarkMode ? Colors.black45 : Colors.grey.shade100,
              height: 20,
              thickness: 10),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                prefixIcon: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(Icons.search),
                ),
                filled: true,
                // hintStyle: TextStyle(color: Colors.grey[800]),
                hintText: "Search template",
              ),
              onChanged: (text) {
                messageTemplateProvider.keywordSearch = text;
                messageTemplateProvider.filterMessageTemplate(text);
              },
            ),
          ),
          Expanded(
              child: Container(
                  color: mainProvider.darkTheme ? cpDarkBgColor : cpWhiteColor,
                  child: StreamBuilder(
                    stream: messageTemplateProvider.messageTemplates$,
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text('No Building Selected',
                                style: TextStyle(fontSize: 13)),
                          ],
                        ));
                      }

                      if (snapshot.data == DataState.empty) {
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
                            const Text('Nothing To Show',
                                style: TextStyle(fontSize: 13)),
                          ],
                        ));
                      }
                      if (snapshot.data == DataState.loading) {
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      }
                      return Scrollbar(
                        child: ListView.separated(
                          itemCount: messageTemplateProvider.templates.length,
                          itemBuilder: (context, index) {
                            var template =
                                messageTemplateProvider.templates[index];
                            return ListTile(
                              title: Text(
                                template.TemplateName is Map
                                    ? ''
                                    : template.TemplateName,
                              ),
                              subtitle: Text(template.TemplateText),
                              onTap: () {
                                messageTemplateProvider.selectedTemplate =
                                    template;
                                Navigator.pushNamed(
                                    context, 'message_template_detail');
                              },
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider();
                          },
                        ),
                      );
                    },
                  )))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: cpPrimaryColorActive,
        onPressed: () {
          messageTemplateProvider.selectedTemplate = MessageTemplate();
          Navigator.of(context).pushNamed('message_template_detail');
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget dropDownBuildings(MessageTemplateProvider msgTemplateProvider) {
    final provider = Provider.of<MessageGroupProvider>(context, listen: false);
    final selected = provider.selectedBuilidng;

    return StreamBuilder<DataState>(
        stream: provider.building$,
        builder: (context, snapshot) {
          final list = provider.buildings;
          if (snapshot.data == null || snapshot.data != DataState.success) {
            return const SizedBox();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Select Building Name',
                  style: TextStyle(fontSize: 18, color: Colors.black)),
              const SizedBox(height: 10),
              PopupMenuButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        selected.BuildingName,
                        style:
                            const TextStyle(fontSize: 18, color: Colors.black),
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.grey,
                    ),
                  ],
                ),
                itemBuilder: (context) {
                  return [
                    ...list
                        .map((e) => PopupMenuItem(
                              onTap: () async {
                                setState(() {
                                  provider.selectedBuilidng = e;
                                  msgTemplateProvider.buildingDetail = e;
                                });
                                msgTemplateProvider.getTemplates({}, context);
                              },
                              value: e.BuildingID,
                              child: Text(e.BuildingName),
                            ))
                        .toList()
                  ];
                },
              ),
            ],
          );
        });
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../enum.dart';
import '../../../../../model/canned_request/canned_request.dart';
import '../../../../../provider/account/message_manager/canned_message.dart';
import '../../../../../provider/account/message_manager/message_group.dart';
import '../../../../../provider/main_provider.dart';
import '../../../../../utils/utils/theme/global_colors.dart';

class CannedMessagePage extends StatefulWidget {
  const CannedMessagePage({Key? key}) : super(key: key);

  @override
  _CannedMessagePageState createState() => _CannedMessagePageState();
}

class _CannedMessagePageState extends State<CannedMessagePage> {
  var isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final cannedMessageProvider =
          Provider.of<CannedMessageProvider>(context, listen: false);
      final messageGroupProvider =
          Provider.of<MessageGroupProvider>(context, listen: false);
      await cannedMessageProvider.getCannedRequests({}, context);
      await messageGroupProvider.getMessageGroups({}, context);
      await cannedMessageProvider.getRequestTargets({}, context);
      setState(() {
        isLoading = false;
      });

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
    final cannedMessageProvider =
        Provider.of<CannedMessageProvider>(context, listen: false);
    final isDarkMode = mainProvider.isDarkMode;
    final messageGroupProvider =
        Provider.of<MessageGroupProvider>(context, listen: false);
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
                          'Canned Message',
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
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      Text(
                        messageGroupProvider.currentBuilding.BuildingName,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
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
                      hintText: "Search Request",
                    ),
                    onChanged: (text) {
                      cannedMessageProvider.searchKeyword = text;
                      cannedMessageProvider.filterCannedRequests();
                    },
                  ),
                ),
                Expanded(
                    child: Container(
                        color: mainProvider.darkTheme
                            ? cpDarkBgColor
                            : cpWhiteColor,
                        child: StreamBuilder(
                          stream: cannedMessageProvider.cannedRequests$,
                          builder: (context, snapshot) {
                            if (snapshot.data == null) {
                              return const SizedBox();
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
                                itemCount:
                                    cannedMessageProvider.cannedRequests.length,
                                itemBuilder: (context, index) {
                                  var request = cannedMessageProvider
                                      .cannedRequests[index];
                                  return ListTile(
                                    title: Text(
                                      request.RequestTitle is Map
                                          ? ''
                                          : request.RequestTitle,
                                    ),
                                    subtitle: Text(request.RequestTarget
                                                    .toString()
                                                .length >
                                            50
                                        ? '${request.RequestTarget.toString().substring(0, 49)}...'
                                        : request.RequestTarget),
                                    onTap: () {
                                      cannedMessageProvider.isCreate = false;
                                      cannedMessageProvider
                                          .currentCannedRequest = request;
                                      cannedMessageProvider.requestId =
                                          request.RequestID;
                                      Navigator.pushNamed(
                                          context, 'canned_message_detail');
                                    },
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
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
                cannedMessageProvider.isCreate = true;
                cannedMessageProvider.currentTargets = [];
                cannedMessageProvider.currentCannedRequest = CannedRequest();
                Navigator.of(context).pushNamed('canned_message_detail');
              },
              child: const Icon(Icons.add),
            ),
          );
  }
}

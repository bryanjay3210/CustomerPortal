import 'package:cp/view/shared_widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../../enum.dart';
import '../../../provider/iot/home_provider.dart';
import '../../../provider/main_provider.dart';
import '../../../shared_widgets/shared_button.dart';
import '../../../shared_widgets/shared_dialog.dart';
import '../../../utils/utils/theme/global_colors.dart';

class RoomManagerPage extends StatefulWidget {
  const RoomManagerPage({Key? key}) : super(key: key);

  @override
  _RoomManagerPageState createState() => _RoomManagerPageState();
}

class _RoomManagerPageState extends State<RoomManagerPage> {
  @override
  Widget build(BuildContext context) {
    final roomNameCtrler = TextEditingController();
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    final iot = mainProvider.iot;
    final server = mainProvider.server;
    final user = mainProvider.user;
    return SafeArea(
      child: Scaffold(
        appBar: popUpPageAppBar('My Rooms'),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            showDialogShared(
                context,
                Container(
                  height: 220,
                  width: 330,
                  decoration: BoxDecoration(
                    color: mainProvider.darkTheme
                        ? cpDarkContainerColor
                        : cpGreyLightColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          'Create Room',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                            color: mainProvider.darkTheme
                                ? cpWhiteColor
                                : cpGreyDarkColor,
                          ),
                        ),
                      ),
                      const Divider(
                        height: 0,
                        thickness: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: TextFormField(
                          controller: roomNameCtrler,
                          decoration: const InputDecoration(
                            // hintText: 'Room Name',
                            labelText: 'Room Name',
                            labelStyle: TextStyle(
                              color: cpGreyLightColor400,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 16),
                        child: StretchableButton(
                          text: 'Create Room',
                          onPressed: () async {
                            if (roomNameCtrler.text.trim().isEmpty) {
                              Fluttertoast.showToast(
                                  msg: "Please put room name",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black54,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              return;
                            }
                            homeProvider.createRoom({
                              'server': server,
                              'customerId': user.CustomerID,
                              'unitId': iot.ControllerBuildingUnitID,
                              'roomName': roomNameCtrler.text,
                            }, context);
                            Navigator.pop(context);
                            roomNameCtrler.text = '';
                          },
                        ),
                      ),
                    ],
                  ),
                ));
          },
          backgroundColor: cpPrimaryColorActive,
        ),
        body: StreamBuilder<DataState>(
            stream: homeProvider.rooms$,
            builder: (context, snapshot) {
              if (snapshot.data == null || snapshot.data != DataState.success) {
                return const Center(
                    child: CircularProgressIndicator.adaptive());
              }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: mainProvider.darkTheme
                            ? cpDarkContainerColor
                            : cpGreyLightColor,
                      ),
                      child: Column(
                        children: [
                          ...homeProvider.rooms.map((e) {
                            return Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    e.RoomName,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 18,
                                      color: mainProvider.darkTheme
                                          ? cpWhiteColor
                                          : cpGreyDarkColor100,
                                    ),
                                  ),
                                  trailing: GestureDetector(
                                      onTap: () async {},
                                      child: const Icon(
                                          Icons.arrow_forward_ios_outlined)),
                                  onTap: () {
                                    homeProvider.selectedRoom = e;
                                    Navigator.pushNamed(context, 'room_update');
                                  },
                                ),
                                const Divider(
                                  height: 0,
                                  thickness: 1,
                                ),
                              ],
                            );
                          }).toList()
                        ],
                      ),
                    ),
                    const SizedBox(height: 50)
                  ],
                ),
              );
            }),
      ),
    );
  }
}

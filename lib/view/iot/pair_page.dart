import 'package:cp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

import '../../enum.dart';
import '../../provider/main_provider.dart';
import '../../provider/iot/pair_provider.dart';
import '../../shared_widgets/shared_dialog.dart';
import '../../utils/utils/theme/global_colors.dart';
import '../shared_widgets/button.dart';
import '../shared_widgets/common_widgets.dart';

class PairPage extends StatefulWidget {
  const PairPage({Key? key}) : super(key: key);

  @override
  State<PairPage> createState() => _PairPageState();
}

class _PairPageState extends State<PairPage> {
  var maskFormatter = MaskTextInputFormatter(
      mask: "################", filter: {"#": RegExp('[a-f-A-F0-9]')});
  final descriptionCtrler = TextEditingController();
  final pairNameCtrler = TextEditingController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final mainProvider = Provider.of<MainProvider>(context, listen: false);
      final pairProvider = Provider.of<PairProvider>(context, listen: false);

      pairProvider.getDevices({
        'server': mainProvider.server,
        'gatewayId': mainProvider.iot.ControllerID,
      }, context);
      // loaded$.add(true);
      // {BedName: {}, CustomerName: qacustomer13@rpssp.com, UserFname:qacustomer13, UserLname: rpssp, UnitID: 308412, UnitName: Unit 1000, CustomerID: 321736, UserID: 305506, Suspended: N},
    });
  }

  @override
  Widget build(BuildContext context) {
    final pairProvider = Provider.of<PairProvider>(context, listen: false);
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    return Scaffold(
        appBar: popUpPageAppBar('Pair Device'),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: 'pair_page_2',
              child: const Icon(Icons.add),
              onPressed: () async {
                showDialogShared(
                    context,
                    Container(
                      height: 300,
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
                              'Pair New Device',
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
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: pairNameCtrler,
                                    inputFormatters: [maskFormatter],
                                    decoration: const InputDecoration(
                                      // hintText: 'Room Name',
                                      labelText: 'Zigbee MAC Address',
                                      labelStyle: TextStyle(
                                        color: cpGreyLightColor400,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  TextFormField(
                                    controller: descriptionCtrler,
                                    decoration: const InputDecoration(
                                      // hintText: 'Room Name',
                                      labelText: 'Description',
                                      labelStyle: TextStyle(
                                        color: cpGreyLightColor400,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                          Container(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, bottom: 16),
                            child: StretchableButton(
                              text: 'Pair Device',
                              onPressed: () async {
                                if (descriptionCtrler.text.trim().isEmpty ||
                                    pairNameCtrler.text.trim().isEmpty ||
                                    pairNameCtrler.text.trim().length < 16) {
                                  Fluttertoast.showToast(
                                      msg: "Please fill up all fields",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.black54,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                  return;
                                }
                                pairProvider.addDevice({
                                  'server': mainProvider.server,
                                  'gatewayId': mainProvider.iot.ControllerID,
                                  'deviceMac': pairNameCtrler.text,
                                  'deviceName': descriptionCtrler.text
                                }, context, () {
                                  Navigator.pop(context);
                                  descriptionCtrler.text = '';
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ));
              },
              backgroundColor: cpPrimaryColorActive,
            ),
          ],
        ),
        body: SingleChildScrollView(
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'Connected Devices',
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
                    StreamBuilder<DataState>(
                        stream: pairProvider.devices$,
                        builder: (context, snapshot) {
                          if (snapshot.data == null) {
                            return const Padding(
                                padding: EdgeInsets.all(20),
                                child: CircularProgressIndicator.adaptive());
                          }

                          if (snapshot.data == DataState.empty) {
                            return const Padding(
                              padding: EdgeInsets.only(top: 48.0, bottom: 20),
                              child: Center(child: Text('No Device/s Found')),
                            );
                          }
                          return Column(
                            children: [
                              ...pairProvider.devices.map((e) {
                                return Column(
                                  children: [
                                    ListTile(
                                      leading: e.Online == 'ONLINE'
                                          ? const Icon(Icons.circle,
                                              color: Colors.green)
                                          : const Icon(Icons.circle,
                                              color: Colors.grey),
                                      title: Text(
                                        e.Name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18,
                                          // color: cpGreyDarkColor100,
                                        ),
                                      ),
                                      subtitle: Text(e.UUID,
                                          style: const TextStyle(
                                              color: cpGreyLightColor400)),
                                      trailing: GestureDetector(
                                          child: SvgPicture.asset(
                                              'assets/images/home/scene/delete_icon.svg'),
                                          onTap: () async {
                                            final res = await showConfirmDialog(
                                                context,
                                                'Are you sure you want to delete this device?');
                                            if (res) {
                                              pairProvider.deleteDevice({
                                                'server': mainProvider.server,
                                                "gatewayId": mainProvider
                                                    .iot.ControllerID,
                                                "thingId": e.ThingID,
                                              }, context);
                                            }
                                          }),
                                    ),
                                    const Divider(
                                      height: 0,
                                      thickness: 1,
                                    ),
                                  ],
                                );
                              }).toList(),
                            ],
                          );
                        }),
                  ],
                ),
              ),
              const SizedBox(height: 60)
            ],
          ),
        ));
  }
}

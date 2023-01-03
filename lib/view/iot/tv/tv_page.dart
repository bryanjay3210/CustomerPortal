import 'package:cp/provider/main_provider.dart';
import 'package:cp/utils/utils/keyboard/text_capitalize.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import '../../../enum.dart';
import '../../../model/tv_device/tv_device.dart';
import '../../../provider/iot/tv_provider.dart';
import '../../../shared_widgets/shared_dialog.dart';
import '../../../shared_widgets/shared_text_field.dart';
import '../../../shared_widgets/toasts.dart';
import '../../../utils/utils/theme/global_colors.dart';
import '../../shared_widgets/button.dart';

class TvPage extends StatefulWidget {
  const TvPage({Key? key}) : super(key: key);

  @override
  State<TvPage> createState() => _TvPageState();
}

class _TvPageState extends State<TvPage> {
  final deviceNameCtrler = TextEditingController();
  final fourCodeCtrler = TextEditingController();
  final searchCtrler = TextEditingController();
  var maskFormatter = MaskTextInputFormatter(
      mask: "####-####", filter: {"#": RegExp('[a-zA-Z0-9]')});
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final tvProvider = Provider.of<TvProvider>(context, listen: false);

      tvProvider.getTvs({}, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final tvProvider = Provider.of<TvProvider>(context, listen: false);
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: cpPrimaryColorActive,
        onPressed: () {
          fourCodeCtrler.text = '';
          tvProvider.selectedTvDevice = TvDevice();
          showAddDeviceDialog(mainProvider, tvProvider);
        },
        child: const Icon(Icons.add),
      ),
      body: SizedBox(
        height: mqHeight(context),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              children: [
                Container(
                  height: 200,
                  color: cpGreyDarkColor,
                ),
                const SizedBox(),
              ],
            ),
            Positioned(
              height: mqHeight(context) - 50,
              top: 50,
              left: 5,
              right: 5,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: const [
                        Text('IPTV Devices',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white))
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, right: 15, left: 15),
                    child: textFieldShared2(context,
                        ctrler: searchCtrler,
                        isFloatingLabel: false,
                        prefixIcon: const Icon(Icons.search),
                        labelText: 'Search Device',
                        fillColor: Colors.white, onChanged: (text) {
                      tvProvider.filterTvDevices(text);
                    }),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          StreamBuilder<DataState>(
                              stream: tvProvider.tvDevices$,
                              builder: (context, snapshot) {
                                if (snapshot.data == null ||
                                    snapshot.data == DataState.loading) {
                                  return const Padding(
                                      padding: EdgeInsets.all(20),
                                      child:
                                          CircularProgressIndicator.adaptive());
                                }
                                if (snapshot.data == DataState.empty) {
                                  return const SizedBox(
                                    height: 300,
                                    child:
                                        Center(child: Text('Nothing to show')),
                                  );
                                }
                                final data = tvProvider.tvDevices;
                                return Container(
                                  height: (data.length * 75) + 20,
                                  margin: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Provider.of<MainProvider>(context)
                                            .darkTheme
                                        ? cpDarkContainerColor
                                        : cpGreyLightColor,
                                  ),
                                  child: Column(
                                    children: [
                                      ...data.map((e) {
                                        return Column(
                                          children: [
                                            ListTile(
                                              title: Text(
                                                e.device_name,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 18,
                                                  color:
                                                      Provider.of<MainProvider>(
                                                                  context)
                                                              .darkTheme
                                                          ? cpWhiteColor
                                                          : cpGreyDarkColor100,
                                                ),
                                              ),
                                              subtitle: Text(e.mac),
                                              trailing: const Icon(Icons
                                                  .arrow_forward_ios_outlined),
                                              onTap: () {
                                                tvProvider.selectedTvDevice = e;
                                                showAddDeviceDialog(
                                                    mainProvider, tvProvider);
                                              },
                                            ),
                                            const Divider(
                                              height: 0,
                                              thickness: 1,
                                            ),
                                          ],
                                        );
                                      }).toList(),
                                    ],
                                  ),
                                );
                              }),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 100)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  showAddDeviceDialog(MainProvider mainProvider, TvProvider tvProvider) {
    final selected = tvProvider.selectedTvDevice;
    final isUpdate = selected.device_name.toString().isNotEmpty;
    var isDelete = false;
    deviceNameCtrler.text = selected.device_name;
    showDialogShared(
        context,
        WillPopScope(
          onWillPop: () {
            return Future.value(!isDelete);
          },
          child: Container(
            height: 300,
            width: 350,
            decoration: BoxDecoration(
              color: mainProvider.darkTheme
                  ? cpDarkContainerColor
                  : cpGreyLightColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: StreamBuilder<DataState>(
                stream: tvProvider.tvDevices$,
                builder: (context, snapshot) {
                  if (snapshot.data == null ||
                      snapshot.data == DataState.loading) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            isUpdate
                                ? isDelete
                                    ? 'Deleting Device'
                                    : 'Updating Device'
                                : 'Adding Device',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 5),
                        const Padding(
                            padding: EdgeInsets.all(20),
                            child: CircularProgressIndicator.adaptive()),
                      ],
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          isUpdate ? 'Update Device' : 'Add Device',
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
                                controller: deviceNameCtrler,
                                decoration: const InputDecoration(
                                  labelText: 'Device Name',
                                  labelStyle: TextStyle(
                                    color: cpGreyLightColor400,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              if (!isUpdate)
                                TextFormField(
                                  inputFormatters: <TextInputFormatter>[
                                    TextCapitalize(),
                                    maskFormatter
                                  ],
                                  controller: fourCodeCtrler,
                                  decoration: const InputDecoration(
                                    labelText: '4-4 Code',
                                    labelStyle: TextStyle(
                                      color: cpGreyLightColor400,
                                    ),
                                  ),
                                ),
                            ],
                          )),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 16),
                        child: StretchableButton(
                          text: isUpdate ? 'Update' : 'Add',
                          onPressed: () async {
                            if (isUpdate) {
                              if (deviceNameCtrler.text.trim().isEmpty) {
                                showToast(
                                  "Please fill up device name",
                                );
                                return;
                              }
                              tvProvider.updateDeviceTv(
                                  {'deviceName': deviceNameCtrler.text},
                                  context, () {
                                Navigator.of(context).pop();
                                showToast('Device Successfully Updated');
                              });
                              return;
                            } else {
                              fourCodeCtrler.text =
                                  fourCodeCtrler.text.toUpperCase();
                              if (deviceNameCtrler.text.trim().isEmpty ||
                                  fourCodeCtrler.text.trim().isEmpty) {
                                showToast(
                                  "Please fill up all fields",
                                );
                                return;
                              }

                              if (fourCodeCtrler.text.trim().length < 8) {
                                showToast(
                                  "4-4 Code requires 8 unique characters",
                                );
                                return;
                              }

                              tvProvider.addDeviceTv({
                                'fourfour': fourCodeCtrler.text,
                                'deviceName': deviceNameCtrler.text
                              }, context, () {
                                Navigator.of(context).pop();
                                fourCodeCtrler.text = '';
                                deviceNameCtrler.text = '';
                                showToast('Device Successfully Added');
                              });
                            }
                          },
                        ),
                      ),
                      if (isUpdate)
                        Container(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, bottom: 16),
                          child: StretchableButton(
                            text: 'Delete',
                            color: Colors.red,
                            onPressed: () async {
                              if (await showConfirmDialog(context,
                                  'Are you sure you want to delete this tv/device')) {
                                isDelete = true;
                                tvProvider.removeDeviceTv({}, context, () {
                                  showToast('Device Successfully Deleted');
                                  Navigator.of(context).pop();
                                });
                              }
                            },
                          ),
                        ),
                    ],
                  );
                }),
          ),
        ));
  }
}

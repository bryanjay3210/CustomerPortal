import 'package:cp/provider/manager/common_tv_provider.dart';
import 'package:cp/shared_widgets/shared_dialog.dart';
import 'package:cp/view/shared_widgets/common_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/main_provider.dart';
import '../../../shared_widgets/shared_text_field.dart';
import '../../../shared_widgets/toasts.dart';
import '../../../utils/utils/theme/global_colors.dart';
import '../../shared_widgets/switch_widget.dart';

class CommonAreaTvDetailsPage extends StatefulWidget {
  const CommonAreaTvDetailsPage({Key? key}) : super(key: key);

  @override
  State<CommonAreaTvDetailsPage> createState() =>
      _CommonAreaTvDetailsPageState();
}

class _CommonAreaTvDetailsPageState extends State<CommonAreaTvDetailsPage> {
  final locationCtrler = TextEditingController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final commonTvProvider =
          Provider.of<CommonTvProvider>(context, listen: false);

      locationCtrler.text = commonTvProvider.selectedDeviceTv.Location;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final commonTvProvider =
        Provider.of<CommonTvProvider>(context, listen: false);
    final isDarkMode =
        Provider.of<MainProvider>(context, listen: false).isDarkMode;

    final deviceTv = commonTvProvider.selectedDeviceTv;

    return Scaffold(
        appBar: popUpPageAppBar('Common Area TV Controller'),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 15,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textFieldShared2(context,
                            ctrler: locationCtrler,
                            prefixIcon: const Icon(Icons.location_on_rounded),
                            readOnly: false,
                            labelText: 'Location',
                            textColor: isDarkMode ? Colors.white : Colors.black,
                            isFloatingLabel: true, onChanged: (text) {
                          setState(
                            () {
                              commonTvProvider.selectedDeviceTv =
                                  deviceTv.copyWith(Location: text);

                              commonTvProvider
                                  .onLocationNameChange({}, context);
                            },
                          );
                        }),
                        const SizedBox(
                          height: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 4.0),
                                  child: Icon(Icons.live_tv_rounded),
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  'Channel Name',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 12),
                              child: dropDownChannel(commonTvProvider, context),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: const [
                                  Icon(Icons.volume_up_rounded),
                                  SizedBox(width: 5),
                                  Text(
                                    'Volume',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  Expanded(
                                    child: CupertinoSlider(
                                      value: double.parse(deviceTv.Volume),
                                      thumbColor: cpPrimaryColorActive,
                                      activeColor: cpPrimaryColorActive,
                                      min: 0,
                                      max: 100,
                                      onChanged: (value) async {
                                        setState(
                                          () {
                                            final val =
                                                value.round().toString();
                                            commonTvProvider.selectedDeviceTv =
                                                deviceTv.copyWith(Volume: val);

                                            commonTvProvider.onVolumeChange({
                                              'level': val,
                                              'mac': deviceTv.MAC,
                                            }, context);
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(deviceTv.Volume)
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => showToast('Currently not available'),
                    child: AbsorbPointer(
                      absorbing: true,
                      child: cpSwitchThingWidget(
                          commonTvProvider,
                          'Caption',
                          const Icon(Icons.closed_caption),
                          deviceTv.CC == '1', () {
                        setState(() {
                          final status = deviceTv.OnOff == '1';

                          commonTvProvider.selectedDeviceTv = commonTvProvider
                              .selectedDeviceTv
                              .copyWith(CC: deviceTv.CC == '1' ? '0' : '1');
                          commonTvProvider.onCaptionChange({
                            'status': status ? 'Off' : 'On',
                            'mac': deviceTv.MAC
                          }, context);
                        });
                      }),
                    ),
                  ),
                  AbsorbPointer(
                    absorbing: true,
                    child: cpSwitchThingWidget(commonTvProvider, 'Community',
                        const Icon(Icons.groups_rounded), true, () {
                      // setState(() {
                      //   final status = deviceTv.OnOff == '1';

                      //   commonTvProvider.selectedDeviceTv = commonTvProvider
                      //       .selectedDeviceTv
                      //       .copyWith(CC: deviceTv.CC == '1' ? '0' : '1');
                      //   commonTvProvider.onCaptionChange({
                      //     'status': status ? 'Off' : 'On',
                      //     'mac': deviceTv.MAC
                      //   }, context);
                      // });
                    }),
                  ),
                  cpSwitchThingWidget(
                      commonTvProvider,
                      'Power',
                      const Icon(Icons.power_settings_new_rounded),
                      deviceTv.OnOff == '1', () {
                    setState(() {
                      final status = deviceTv.OnOff == '1';
                      commonTvProvider.selectedDeviceTv = commonTvProvider
                          .selectedDeviceTv
                          .copyWith(OnOff: status ? '0' : '1');

                      commonTvProvider.onPowerChange({
                        'status': status ? 'Off' : 'On',
                        'mac': deviceTv.MAC
                      }, context);
                    });
                  }),
                  const SizedBox(height: 30),
                  ElevatedButton(
                      style: TextButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () async {
                        if (await showConfirmDialog(context,
                            'Are you sure you want to delete this tv?')) {
                          await commonTvProvider.removeTv({
                            'device': locationCtrler.text,
                          }, context, () {
                            showToast('Tv/Device Successfully Removed');
                            Navigator.of(context).pop();
                          });
                        }
                      },
                      child: const Text('Remove this TV'))
                ],
              ),
            ),
          ],
        ));
  }

  Widget cpSwitchThingWidget(CommonTvProvider provider, String name, Icon icon,
      bool status, dynamic callback) {
    return SwitchWidget(
      icon: icon,
      text: name,
      status: status,
      callback: callback,
    );
  }

  Widget dropDownChannel(CommonTvProvider provider, BuildContext context) {
    final list = provider.allChannels;
    return PopupMenuButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              provider.selectedChannel.Name,
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
                  onTap: () {
                    if (e.Name == 'No Channel Name') {
                      showToast('Please select valid channel');
                      return;
                    }
                    setState(() {
                      provider.selectedChannel = provider.allChannels
                          .firstWhere((element) => element.Name == e.Name);

                      provider.onChannelChange({}, context);
                    });
                  },
                  value: e.Name,
                  child: Text(e.Name)))
              .toList()
        ];
      },
    );
  }
}

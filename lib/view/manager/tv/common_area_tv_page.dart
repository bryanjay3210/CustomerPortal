import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../enum.dart';
import '../../../model/channel/channel.dart';
import '../../../provider/main_provider.dart';
import '../../../provider/manager/common_tv_provider.dart';
import '../../../shared_widgets/shared_dialog.dart';
import '../../../shared_widgets/shared_text_field.dart';
import '../../../shared_widgets/toasts.dart';
import '../../../utils/utils/keyboard/text_capitalize.dart';
import '../../../utils/utils/theme/global_colors.dart';
import '../../shared_widgets/button.dart';

class CommonAreaTvPage extends StatefulWidget {
  const CommonAreaTvPage({Key? key}) : super(key: key);

  @override
  State<CommonAreaTvPage> createState() => _CommonAreaTvPageState();
}

class _CommonAreaTvPageState extends State<CommonAreaTvPage> {
  final searchCtrler = TextEditingController();
  final locationCtrler = TextEditingController();
  final fourCodeCtrler = TextEditingController();
  var maskFormatter = MaskTextInputFormatter(
    mask: "####-####",
    filter: {"#": RegExp('[a-zA-Z0-9]')},
  );
  var willPop = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<CommonTvProvider>(context, listen: false)
          .getChannels({}, context);
      try {
        await Provider.of<CommonTvProvider>(context, listen: false)
            .getCommonAreaTvs({}, context);
      } catch (ex) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    final commonTvProvider =
        Provider.of<CommonTvProvider>(context, listen: false);

    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    final isDarkMode = mainProvider.isDarkMode;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            locationCtrler.text = '';
            fourCodeCtrler.text = '';
            showDialogShared(
                context,
                WillPopScope(
                  onWillPop: () async {
                    return willPop;
                  },
                  child: Container(
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
                            'Add Device',
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
                                  controller: locationCtrler,
                                  decoration: const InputDecoration(
                                    labelText: 'Location',
                                    labelStyle: TextStyle(
                                      color: cpGreyLightColor400,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  textCapitalization:
                                      TextCapitalization.characters,
                                  controller: fourCodeCtrler,
                                  inputFormatters: <TextInputFormatter>[
                                    TextCapitalize(),
                                    maskFormatter
                                  ],
                                  decoration: const InputDecoration(
                                    // hintText: 'Room Name',
                                    labelText: '4-4 Code',
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
                            text: 'Add Device',
                            onPressed: () async {
                              fourCodeCtrler.text =
                                  fourCodeCtrler.text.toUpperCase();
                              if (locationCtrler.text.trim().isEmpty ||
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
                              willPop = false;
                              await commonTvProvider.addDevice({
                                'device': locationCtrler.text,
                                'fourfour': fourCodeCtrler.text,
                                'searchKeyword': searchCtrler.text
                              }, context, () {
                                willPop = true;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ));
          },
          backgroundColor: cpPrimaryColor,
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
                height: mqHeight(context) * .90,
                top: 20,
                left: 5,
                right: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text('Common Area TV Controller',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 15.0, right: 15, left: 15),
                      child: textFieldShared2(context,
                          ctrler: searchCtrler,
                          isFloatingLabel: false,
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: null,
                          labelText: 'Search keyword...',
                          fillColor: Colors.white, onChanged: (text) {
                        commonTvProvider.filterDeviceTvs(text);
                      }),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            StreamBuilder<DataState>(
                                stream: commonTvProvider.deviceTv$,
                                builder: (context, snapshot) {
                                  if (snapshot.data == null ||
                                      snapshot.data == DataState.loading) {
                                    return const Center(
                                      child:
                                          CircularProgressIndicator.adaptive(),
                                    );
                                  }
                                  if (snapshot.data == DataState.empty) {
                                    return const SizedBox(
                                      height: 300,
                                      child: Center(
                                          child: Text('Nothing to show')),
                                    );
                                  }
                                  final data = commonTvProvider.deviceTvs;
                                  return Column(
                                    children: [
                                      Container(
                                          height: ((data.length * 120) + 20),
                                          margin: const EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            color: mainProvider.darkTheme
                                                ? cpDarkContainerColor
                                                : cpGreyLightColor,
                                          ),
                                          child: ListView.builder(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: commonTvProvider
                                                  .deviceTvs.length,
                                              itemBuilder: (context, ctx) {
                                                final deviceTv =
                                                    commonTvProvider
                                                        .deviceTvs[ctx];
                                                var channel = Channel(
                                                    Name: 'No Channel Name',
                                                    Number: '0');
                                                if (commonTvProvider
                                                    .allChannels.isNotEmpty) {
                                                  channel = commonTvProvider
                                                      .allChannels
                                                      .firstWhere(
                                                          (element) =>
                                                              element.Number ==
                                                              deviceTv.Channel,
                                                          orElse: () =>
                                                              channel);
                                                }

                                                return ListTile(
                                                  onTap: () {
                                                    commonTvProvider
                                                            .currentSearchKeyword =
                                                        searchCtrler.text;
                                                    commonTvProvider
                                                            .selectedDeviceTv =
                                                        deviceTv;
                                                    commonTvProvider
                                                            .selectedChannel =
                                                        commonTvProvider.getChannel(
                                                            commonTvProvider
                                                                .selectedDeviceTv);
                                                    Navigator.pushNamed(context,
                                                        'common_area_tv_detail');
                                                  },
                                                  title: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      if (channel.Icon
                                                              .toString()
                                                          .isNotEmpty)
                                                        ConstrainedBox(
                                                          constraints:
                                                              const BoxConstraints(
                                                                  maxHeight:
                                                                      30),
                                                          child: Container(
                                                            color: isDarkMode
                                                                ? null
                                                                : Colors
                                                                    .grey[400],
                                                            child:
                                                                Image.network(
                                                              channel.Icon,
                                                            ),
                                                          ),
                                                        ),
                                                      if (channel.Icon
                                                              .toString()
                                                          .isNotEmpty)
                                                        const SizedBox(
                                                            width: 5),
                                                      Expanded(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                  '${channel.Name.toString().toLowerCase() == 'no channel name' ? '             ' : ''}${channel.Name}'),
                                                            ),
                                                            if (channel.Number
                                                                    .toString() !=
                                                                '0')
                                                              Text(
                                                                  '(${deviceTv.Channel})'),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  contentPadding:
                                                      const EdgeInsets.all(8),
                                                  subtitle: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const SizedBox(height: 5),
                                                      Text(
                                                          '               ${deviceTv.Location}'),
                                                      const SizedBox(height: 5),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    8.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                const Icon(Icons
                                                                    .volume_up_rounded),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Text(deviceTv
                                                                            .Volume ==
                                                                        '0'
                                                                    ? '0   '
                                                                    : deviceTv
                                                                        .Volume),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: const [
                                                                Icon(Icons
                                                                    .groups),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Text(
                                                                  'Yes',
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                const Icon(Icons
                                                                    .closed_caption_outlined),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Text(
                                                                  deviceTv.CC ==
                                                                          '0'
                                                                      ? 'Off'
                                                                      : 'On',
                                                                ),
                                                              ],
                                                            ),
                                                            Icon(
                                                              Icons.circle,
                                                              color: deviceTv
                                                                          .OnOff ==
                                                                      '0'
                                                                  ? Colors.red
                                                                  : Colors
                                                                      .green,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const Divider()
                                                    ],
                                                  ),
                                                );
                                              })),
                                      const SizedBox(height: 35)
                                    ],
                                  );
                                }),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 40)
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

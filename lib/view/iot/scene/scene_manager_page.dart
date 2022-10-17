import 'package:cp/view/shared_widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../enum.dart';
import '../../../provider/iot/home_provider.dart';
import '../../../provider/main_provider.dart';
import '../../../shared_widgets/shared_button.dart';
import '../../../shared_widgets/shared_dialog.dart';
import '../../../utils/utils/theme/global_colors.dart';

class SceneManagerPage extends StatefulWidget {
  const SceneManagerPage({Key? key}) : super(key: key);

  @override
  _SceneManagerPageState createState() => _SceneManagerPageState();
}

class _SceneManagerPageState extends State<SceneManagerPage> {
  @override
  Widget build(BuildContext context) {
    final sceneNameCtrler = TextEditingController();
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    final mainProvider = Provider.of<MainProvider>(context, listen: false);

    String icon(String scene) {
      if (scene == 'Away') {
        return sceneIcon.elementAt(1).values.elementAt(1);
      } else if (scene == 'Home') {
        return sceneIcon.elementAt(2).values.elementAt(1);
      } else if (scene == 'Asleep') {
        return sceneIcon.elementAt(0).values.elementAt(1);
      } else if (scene == 'Add More') {
        return sceneIcon.elementAt(4).values.elementAt(1);
      } else {
        return sceneIcon.elementAt(3).values.elementAt(1);
      }
    }

    return SafeArea(
      child: Scaffold(
        appBar: popUpPageAppBar('My Scenes'),
        floatingActionButton: FloatingActionButton(
          backgroundColor: cpPrimaryColorActive,
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
                          'Create Scene',
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
                          controller: sceneNameCtrler,
                          decoration: const InputDecoration(
                            labelText: 'Scene Name',
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
                          text: 'Create Scene',
                          onPressed: () async {
                            if (sceneNameCtrler.text.trim().isEmpty) {
                              Fluttertoast.showToast(
                                  msg: "Please put scene name",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black54,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              return;
                            }

                            homeProvider.createScene({
                              'customerId': mainProvider.user.CustomerID,
                              'unitId':
                                  mainProvider.iot.ControllerBuildingUnitID,
                              'sceneName': sceneNameCtrler.text,
                              'server': mainProvider.server,
                            }, context);
                            sceneNameCtrler.text = '';
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ));
          },
          child: const Icon(Icons.add),
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
                child: StreamBuilder<DataState>(
                    stream: homeProvider.scenes$,
                    builder: (context, snapshot) {
                      if (snapshot.data == null ||
                          snapshot.data != DataState.success) {
                        return const Padding(
                            padding: EdgeInsets.all(20),
                            child: Center(
                                child: CircularProgressIndicator.adaptive()));
                      }
                      return Column(
                        children: [
                          ...homeProvider.scenes.map((e) {
                            return Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    e.SceneName,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 18,
                                      color: mainProvider.darkTheme
                                          ? cpWhiteColor
                                          : cpGreyDarkColor100,
                                    ),
                                  ),
                                  trailing: GestureDetector(
                                    onTap: () async {
                                      final res = await showConfirmDialog(
                                          context,
                                          'Are you sure you want to delete this scene?');
                                      if (res) {
                                        homeProvider.deleteScene({
                                          'server': mainProvider.server,
                                          "customerId":
                                              mainProvider.user.CustomerID,
                                          "unitId": mainProvider
                                              .iot.ControllerBuildingUnitID,
                                          "sceneId": e.SceneID
                                        }, context);
                                      }
                                    },
                                    child: SvgPicture.asset(
                                        'assets/images/home/scene/delete_icon.svg'),
                                  ),
                                  onTap: () {},
                                ),
                                const Divider(
                                  height: 0,
                                  thickness: 1,
                                ),
                              ],
                            );
                          }).toList()
                        ],
                      );
                    }),
              ),
              const SizedBox(height: 60)
            ],
          ),
        ),
      ),
    );
  }
}

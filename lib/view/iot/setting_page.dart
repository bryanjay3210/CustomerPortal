import 'dart:async';

import 'package:cp/utils/utils/theme/global_colors.dart';
import 'package:cp/utils/utils/version/version.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/subjects.dart';
import 'package:slide_action/slide_action.dart';
import '../../provider/iot/home_provider.dart';
import '../../provider/login_provider.dart';
import '../../provider/main_provider.dart';
import '../../shared_widgets/shared_dialog.dart';
import '../../shared_widgets/toasts.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    final isNoIOT = mainProvider.iot.Status == 'NoIOT';
    final holdToUnlock = BehaviorSubject.seeded(false);
    final swipeToUnlock = BehaviorSubject.seeded(false);
    return Scaffold(
        appBar: AppBar(
            systemOverlayStyle:
                const SystemUiOverlayStyle(statusBarColor: cpGreyDarkColor),
            foregroundColor: cpWhiteColor,
            title: const Text(
              'Settings',
            ),
            backgroundColor: cpGreyDarkColor),
        body: Column(
          children: [
            if (!isNoIOT && !mainProvider.isManager())
              Column(
                children: [
                  ListTile(
                    tileColor: mainProvider.darkTheme
                        ? cpDarkContainerColor
                        : cpGreyLightColor,
                    title: Text(
                      'My Rooms',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                        color: mainProvider.darkTheme
                            ? cpWhiteColor
                            : cpGreyDarkColor100,
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios_outlined),
                    onTap: () async {
                      Navigator.pushNamed(context, 'room_management');
                    },
                  ),
                  const Divider(
                    height: 0,
                    thickness: 1,
                  ),
                ],
              ),
            if (!isNoIOT && !mainProvider.isManager())
              ListTile(
                tileColor: mainProvider.darkTheme
                    ? cpDarkContainerColor
                    : cpGreyLightColor,
                title: Text(
                  'My Scenes',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                    color: mainProvider.darkTheme
                        ? cpWhiteColor
                        : cpGreyDarkColor100,
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios_outlined),
                onTap: () async {
                  Navigator.pushNamed(context, 'scene_management');
                },
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                tileColor: mainProvider.darkTheme
                    ? cpDarkContainerColor
                    : cpGreyLightColor,
                title: Text(
                  'Dark Theme',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                    color: mainProvider.darkTheme
                        ? cpWhiteColor
                        : cpGreyDarkColor100,
                  ),
                ),
                trailing: CupertinoSwitch(
                  thumbColor: cpGreyLightColor,
                  trackColor: cpGreyDarkColor,
                  activeColor: cpPrimaryColor,
                  value: mainProvider.darkTheme,
                  onChanged: (bool value) {
                    setState(() {
                      mainProvider.darkTheme = !mainProvider.darkTheme;
                      mainProvider.isDark.add(mainProvider.darkTheme);
                      final isNoIOT = mainProvider.iot.Status == 'NoIOT';
                      final isManager = mainProvider.isManager();
                    });
                  },
                ),
                onTap: () {},
              ),
            ),
            Container(
              color: mainProvider.darkTheme
                  ? cpDarkContainerColor
                  : cpGreyLightColor,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                        style: TextButton.styleFrom(
                            side: const BorderSide(
                                width: 1, color: cpDivLightColor)),
                        onPressed: () async {
                          final res = await showConfirmDialog(
                              context, 'Are you sure you want to logout?');
                          if (res) {
                            loginProvider.onLogout();
                            Provider.of<HomeProvider>(context, listen: false)
                                .removeLocalWidgetOrder();
                            Navigator.pushReplacementNamed(context, 'login');
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Logout',
                              style: TextStyle(
                                  color: Provider.of<MainProvider>(context)
                                          .darkTheme
                                      ? cpWhiteColor
                                      : cpDivLightColor),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.logout,
                              color:
                                  Provider.of<MainProvider>(context).darkTheme
                                      ? cpWhiteColor
                                      : cpDivLightColor,
                            )
                          ],
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                    FutureBuilder(
                      future: getVersion(),
                      builder: (context, snapshot) =>
                          Text(snapshot.data.toString()),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}

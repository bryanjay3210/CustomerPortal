import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/utils/theme/global_colors.dart';

AppBar popUpPageAppBar(String title, {List<Widget>? widget}) {
  return AppBar(
    systemOverlayStyle:
        const SystemUiOverlayStyle(statusBarColor: cpGreyDarkColor),
    foregroundColor: cpWhiteColor,
    title: Text(
      title,
    ),
    backgroundColor: cpGreyDarkColor,
    actions: widget,
  );
}

AppBar popUpPageAppBar2(String title, GestureTapCallback callback) {
  return AppBar(
    leading: BackButton(onPressed: () {
      callback();
    }),
    systemOverlayStyle:
        const SystemUiOverlayStyle(statusBarColor: cpGreyDarkColor),
    foregroundColor: cpWhiteColor,
    title: Text(
      title,
    ),
    backgroundColor: cpGreyDarkColor,
  );
}

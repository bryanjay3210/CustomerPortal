import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cp/utils/utils/theme/app_preference.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:rxdart/subjects.dart';

import '../model/iot/iot.dart';
import '../model/user/user.dart';

class MainProvider {
  var server = 3;
  final bottomNavSelected$ = BehaviorSubject<int>.seeded(0);
  final isDark = BehaviorSubject<bool>.seeded(false);
  AppPreference appPreference = AppPreference();
  User user = User();
  Iot iot = Iot();
  bool isDarkMode = true;
  bool get darkTheme => isDarkMode;

  set darkTheme(value) {
    isDarkMode = value;
    appPreference.setThemePref(value);
  }

  bool isManager() {
    return user.UserType == 'BldgAdmin';
  }

  checkConnectivity(VoidCallback callback) {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if ((result.index != 4 || result.index != 0)) {
        callback();
      }
    });
  }
}

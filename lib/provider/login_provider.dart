import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import '../enum.dart';
import '../model/iot/iot.dart';
import '../model/user/user.dart';
import '../repository/login_repository.dart';
import '../shared_widgets/toasts.dart';
import 'account/message_manager/message_group.dart';
import 'main_provider.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart' as crypto;
import 'package:convert/convert.dart';

import 'manager/customer_provider.dart';

class LoginProvider {
//stream
  final loginState$ = BehaviorSubject<ButtonState>.seeded(ButtonState.loaded);
  final hive = Hive.box('user_pass');
  onLogin(Map<String, dynamic> map, BuildContext context,
      VoidCallback callback) async {
    final fName = map.values.elementAt(0);
    final lName = map.values.elementAt(1);
    final server = map.values.elementAt(2);
    loginState$.add(ButtonState.loading);
    Map<String, dynamic> data =
        await LoginRepository(server).getLoginPost(context, fName, lName);
    if (data['Status'] == 'Success') {
      final user = User.fromJson(data);
      final mainProvider = Provider.of<MainProvider>(context, listen: false);
      mainProvider.user = user;
      if (mainProvider.isManager()) {
        final customerProvider =
            Provider.of<CustomerProvider>(context, listen: false);
        map['buildingId'] = user.CustomerID;
        await Provider.of<MessageGroupProvider>(context, listen: false)
            .getBuildings({}, context);
        await customerProvider.getProductBundles(map, context);
      }
      mainProvider.server = server;
      final remember = map['rememberMe'];
      if (remember == null) {
      } else {
        if (remember) {
          saveRememberMe({'username': fName, 'rememberMe': map['rememberMe']});
        } else {
          removeRememberMe();
        }
      }

      await saveLocalCredential(map);
      Map<String, dynamic> iotInfo =
          await LoginRepository(server).getIOT(user.UserID);
      if (iotInfo['Status'] == 'Success') {
        mainProvider.iot = Iot.fromJson(iotInfo);
        Provider.of<MainProvider>(context, listen: false)
            .bottomNavSelected$
            .add(0);
      } else if (iotInfo['Status'] == 'NoIOT') {
        mainProvider.iot = mainProvider.iot.copyWith(Status: 'NoIOT');
        Provider.of<MainProvider>(context, listen: false)
            .bottomNavSelected$
            .add(mainProvider.isManager() ? 3 : 0);
      } else {
        mainProvider.iot = mainProvider.iot.copyWith(Status: 'NoIOT');
        Provider.of<MainProvider>(context, listen: false)
            .bottomNavSelected$
            .add(mainProvider.isManager() ? 3 : 0);
      }
      if (callback != null) {
        callback();
      }
    } else {
      loginState$.add(ButtonState.loaded);
      Navigator.pushReplacementNamed(context, 'login');
      showToast('Login Failed');
    }

    loginState$.add(ButtonState.loaded);
  }

  generateMd5(String data) {
    var content = const Utf8Encoder().convert(data);
    var md5 = crypto.md5;
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }

  Future<String> inputUserName() async {
    final localData = await getRememberMe();
    if (localData != null) {
      final rememberMe = localData['rememberMe'];
      if (rememberMe) return localData['username'];
    }
    return '';
  }

  onLogout() async {
    await removeLocalCredential();
  }

  saveLocalCredential(Map<String, dynamic> val) async {
    await hive.put('cred', val);
  }

  getLocalCredential() async {
    return await hive.get('cred');
  }

  removeLocalCredential() async {
    return await hive.delete('cred');
  }

  saveRememberMe(Map<String, dynamic> val) async {
    await hive.put('remember_me', val);
  }

  getRememberMe() async {
    return await hive.get('remember_me');
  }

  removeRememberMe() async {
    return await hive.delete('remember_me');
  }
}

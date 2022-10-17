import 'package:flutter/widgets.dart';
import '../service/api_request.dart';

class LoginRepository extends RequestApi {
  LoginRepository(int server) : super(server);

  dynamic getLoginPost(
      BuildContext context, String username, String password) async {
    dynamic dataUrl = {
      "Command": "Auth",
      "Subcommand1": "Login",
      "User": username,
      "Password": password
    };

    return await getApi(dataUrl, context: context);
  }

  dynamic getIOT(String userId) async {
    dynamic dataUrl = {
      "Command": "User",
      "Subcommand1": "IOTCheck",
      "UserID": userId
    };
    return await getApi(dataUrl, type: 'iot');
  }

  // dynamic getIOT(LoginInfo loginInfo) async {
  //   dynamic dataUrl = {
  //     "Command": "User",
  //     "Subcommand1": "IOTCheck",
  //     "UserID": "${loginInfo.UserID}"
  //   };
  //   return await getApi(dataUrl, type: 'iot');
  // }
}

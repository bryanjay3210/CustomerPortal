import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import '../../shared_widgets/shared_dialog.dart';
import '../../shared_widgets/toasts.dart';
import '../constants.dart';
import '../service/urls.dart';

class RequestApi {
  int server;

  RequestApi(this.server);

  Dio dio() {
    return Dio(BaseOptions(
        headers: {"Content-Type": "application/json"},
        baseUrl: servers.elementAt(server).values.elementAt(2),
        receiveDataWhenStatusError: true,
        connectTimeout: kIsWeb ? 0 : 5000,
        receiveTimeout: kIsWeb ? 0 : 5000));
  }

  Future<dynamic> getApi(dynamic request,
      {String? type, BuildContext? context, FormData? formData}) async {
    Map<String, dynamic>? data;
    request = json.encode(request);
    print('📋API REQUEST📋:');
    print(request);
    final connection = await Connectivity().checkConnectivity();
    if (connection.index == 4) {
      showError(context, 'Error', 'You are currently Offline');
      showToast('You are currently Offline');
      return {'status': 'You are currently Offline'};
    }

    try {
      Response res = formData == null
          ? await dio()
              .post(formatAPI(dataUrl: request, type: type, serverType: server))
          : await dio().post(
              formatAPI(dataUrl: request, type: type, serverType: server),
              data: formData);
      Map<String, dynamic> result = res.data;

      if (result['Status'].toString().toLowerCase() == 'success' ||
          result['Status'] == 'HTML Code-200' ||
          result['Status'] == 'Valid' ||
          result['status'].toString().toLowerCase() == 'e-0000 ok' ||
          result['rc'] == 'E-0000 ok') {
        print('✅API RESULT SUCCEEDED:✅');
        debugPrint(result.toString());
        result = result.map((_, value) {
          dynamic t = value;
          if (value is Map) {
            if (t.toString() == "{}") {
              t = '';
            }
          } else if (value is List) {
            if (_[2] == "Name") {
              t = '';
            }
          } else {
            t = t.replaceAll('{}', '');
          }
          return MapEntry(_, t);
        });
        data = result;
      } else {
        print('🌓API RESULT ALMOST:🌓');
        print(result);
        showError(context, 'Error',
            result['Status'] ?? result['status'] ?? 'Error: No Message');
        data = result;
      }
    } catch (e) {
      print('❌API RESULT FAILED:❌');
      showError(context, 'Error', 'Error: Error Message Unreadable');
      data = {'status': 'failed'};
    }
    return data;
  }

  showError(BuildContext? context, request, dynamic message) async {
    print("error $message");
    if (context != null) {
      await showDialogShared(
        context,
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.red,
              ),
              alignment: Alignment.center,
              height: 100,
              width: 100,
              padding: const EdgeInsets.all(10),
              child: Text(
                message,
                textAlign: TextAlign.center,
                maxLines: 5,
                style: const TextStyle(color: Colors.white),
              )),
        ),
      );
    }
  }

  showLoadingNow(BuildContext? context) {
    if (context != null) {
      // showLoading(context);
    }
  }

  removeLoading(BuildContext? context) {
    if (context != null) {
      // Navigator.of(context).pop();
    }
  }
}

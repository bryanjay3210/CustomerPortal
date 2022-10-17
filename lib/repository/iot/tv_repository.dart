import 'package:cp/service/api_request.dart';
import 'package:flutter/widgets.dart';

class TvRepository extends RequestApi {
  TvRepository(int server) : super(server);

  dynamic getTvs(Map<String, dynamic> map, BuildContext context) async {
    dynamic dataUrl = {
      "cmd": "STBFetchMac",
      "cid": map['cid'],
      "LoggedUser": map['loggedUser']
    };
    return await getApi(dataUrl, type: 'dvr');
  }

  dynamic addDeviceTv(Map<String, dynamic> map, BuildContext context) async {
    dynamic dataUrl = {
      "cmd": "STBBind",
      "MAC": "",
      "4-4": map['fourfour'],
      "Device": map['deviceName'],
      "cid": map['cid'],
      "operation": "A",
      "community": "N",
      "LoggedUser": map['loggedUser']
    };
    return await getApi(dataUrl, type: 'dvr', context: context);
  }

  dynamic updateDeviceTv(Map<String, dynamic> map, BuildContext context) async {
    dynamic dataUrl = {
      "cmd": "STBResidenceUpdate",
      // "id": "364",
      // "Device": "test 2",
      // "LoggedUser": "31100"
      "id": map["deviceId"],
      "Device": map["deviceName"],
      "LoggedUser": map["loggedUser"]
    };
    return await getApi(dataUrl, type: 'dvr');
  }

  dynamic removeDeviceTv(Map<String, dynamic> map, BuildContext context) async {
    dynamic dataUrl = {
      "cmd": "STBBind",
      "MAC": map["mac"],
      "4-4": "",
      "cid": map["cid"],
      "operation": "R",
      "community": "N",
      "LoggedUser": map['loggedUser']
    };
    return await getApi(dataUrl, type: 'dvr');
  }
}

import 'package:cp/service/api_request.dart';
import 'package:flutter/widgets.dart';

class CommonTvRepository extends RequestApi {
  CommonTvRepository(int server) : super(server);

  dynamic getChannels(Map<String, dynamic> map, BuildContext context) async {
    dynamic dataUrl = {
      "cmd": "Channel",
      "Subcommand1": "CommonAreaList",
      "CustomerID": map['customerId'],
      "LoggedUser": map['loggedUser']
    };
    return await getApi(dataUrl, type: 'dvr', context: context);
  }

  dynamic onPowerChange(Map<String, dynamic> map, BuildContext context) async {
    dynamic dataUrl = {
      "cmd": "Function",
      "Subcommand1": "Power",
      "Subcommand2": map['status'],
      "MAC": map['mac']
    };
    return await getApi(dataUrl, type: 'dvr', context: context);
  }

  dynamic onVolumeChange(Map<String, dynamic> map, BuildContext context) async {
    dynamic dataUrl = {
      "cmd": "Function",
      "Subcommand1": "Volume",
      "Level": map['level'],
      "CC": map['cc'],
      "MAC": map['mac']
    };
    return await getApi(dataUrl, type: 'dvr', context: context);
  }

  dynamic onCaptionChange(
      Map<String, dynamic> map, BuildContext context) async {
    dynamic dataUrl = {
      "cmd": "Function",
      "Subcommand1": "CC",
      "Subcommand2": map['status'],
      "MAC": map['mac'],
    };
    return await getApi(dataUrl, type: 'dvr', context: context);
  }

  dynamic onChannelChange(
      Map<String, dynamic> map, BuildContext context) async {
    dynamic dataUrl = {
      "cmd": "Function",
      "Subcommand1": "Channel",
      "EPG_Chan": map['channel'],
      "MAC": map['mac']
    };
    return await getApi(dataUrl, type: 'dvr', context: context);
  }

  dynamic onLocationNameChange(
      Map<String, dynamic> map, BuildContext context) async {
    dynamic dataUrl = {
      "cmd": "Function",
      "Subcommand1": "Manage",
      "Subcommand2": "U",
      // "TVID": "${this.tvId}",
      // "Location": "${encodeURIComponent(encodeURIComponent(this.location))}",
      // "MAC": "${encodeURIComponent(encodeURIComponent(this.mac))}"
      "TVID": map['tvId'],
      "Location": map['location'],
      "MAC": map['mac']
    };
    return await getApi(dataUrl, type: 'dvr', context: context);
  }

  dynamic addDevice(Map<String, dynamic> map, BuildContext context) async {
    dynamic dataUrl = {
      "cmd": "STBBind",
      "MAC": "",
      "4-4": map['fourfour'],
      "cid": map['customerId'],
      "operation": "A",
      "community": "Y",
      "Device": map['device'],
      "LoggedUser": map["loggedUser"]
    };
    return await getApi(dataUrl, type: 'dvr', context: context);
  }

  dynamic getCommonAreaTvs(
      Map<String, dynamic> map, BuildContext context) async {
    dynamic dataUrl = {
      "cmd": "Function",
      "Subcommand1": "Manage",
      "Subcommand2": "L",
      "CustomerID": map['customerId'],
      "LoggedUser": map['loggedUser']
    };
    return await getApi(dataUrl, type: 'dvr', context: context);
  }

  dynamic removeTv(Map<String, dynamic> map, BuildContext context) async {
    dynamic dataUrl = {
      "cmd": "Function",
      "Subcommand1": "Manage",
      "Subcommand2": "R",
      // "CustomerID": "${this.userInfo.CustomerID}",
      // "MAC": "${encodeURIComponent(encodeURIComponent(data.MAC))}"
      "CustomerID": map['customerId'],
      "MAC": map['mac'],
      'LoggedUser': map['loggedUser']
    };
    return await getApi(dataUrl, type: 'dvr', context: context);
  }

  // dynamic onCommunityStatusChanged(
  //     Map<String, dynamic> map, BuildContext context) async {
  //   dynamic dataUrl = {
  //     "cmd": "STBBind",
  //     "MAC": map['mac'],
  //     "4-4": "",
  //     // "cid": "321820",
  //     // "operation": "A",
  //     // "community": "N",
  //     // "Device": "211111111dd12112",
  //     // "LoggedUser": "1"
  //     "cid": map['customerId'],
  //     "operation": "A",
  //     "community": "N",
  //     "Device": map["deviceId"],
  //     "LoggedUser": map['loggedUser']
  //   };
  //   return await getApi(dataUrl, type: 'dvr', context: context);
  // }
}

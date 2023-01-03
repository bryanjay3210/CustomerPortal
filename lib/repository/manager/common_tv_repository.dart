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
      "TVID": map['tvId'],
      "Location": map['location'],
      "MAC": map['mac']
    };
    return await getApi(dataUrl, type: 'dvr', context: context);
  }

  dynamic onCommunityChanged(
      Map<String, dynamic> map, BuildContext context) async {
    dynamic dataUrl = {
      "cmd": "STBResidenceUpdate",
      "id": map['id'],
      "Device": map['device'],
      "community": map['community'],
      "from_community_list": 'Y',
      "LoggedUser": map['loggedUser']
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
      "CustomerID": map['customerId'],
      "MAC": map['mac'],
      'LoggedUser': map['loggedUser']
    };
    return await getApi(dataUrl, type: 'dvr', context: context);
  }
}

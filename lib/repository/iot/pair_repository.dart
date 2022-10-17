import 'package:cp/service/api_request.dart';

class PairRepository extends RequestApi {
  PairRepository(int server) : super(server);

  dynamic pairDevice(Map<String, dynamic> map) async {
    dynamic dataUrl = {
      "Command": "Building",
      "Subcommand1": "PairDevice",
      // "GatewayID": "${this.iotInfo.ControllerID}"
    };
    return await getApi(dataUrl, type: 'iot');
  }

  dynamic getDevices(Map<String, dynamic> map) async {
    dynamic dataUrl = {
      "Command": "Building",
      "Subcommand1": "DeviceList",
      "GatewayID": map['gatewayId']
    };
    return await getApi(dataUrl, type: 'iot');
  }

  dynamic pairDeviceManual(Map<String, dynamic> map) async {
    dynamic dataUrl = {
      "Command": "Building",
      "Subcommand1": "PairDevice",
      "GatewayID": map['gatewayId'],
      "DeviceMAC": map['deviceMac'],
      "DeviceName": map['deviceName']
    };
    return await getApi(dataUrl, type: 'iot');
  }

  dynamic removeDevice(Map<String, dynamic> map) async {
    dynamic dataUrl = {
      "Command": "Building",
      "Subcommand1": "RemoveDevice",
      "GatewayID": map['gatewayId'],
      "ThingID": map['thingId']
    };
    return await getApi(dataUrl, type: 'iot');
  }
}

import 'package:cp/service/api_request.dart';

class HomeRepository extends RequestApi {
  HomeRepository(int server) : super(server);

  dynamic getScenes(Map<String, dynamic> map) async {
    dynamic dataUrl = {
      "Command": "Scene",
      "Subcommand1": "List",
      "CustomerID": map['customerId'],
      "UnitID": map['unitId']
    };
    return await getApi(dataUrl, type: 'iot');
  }

  dynamic changeDevice(Map<String, dynamic> map) async {
    dynamic dataUrl = {
      "Command": "Item",
      "Subcommand1": "ChangeDevice",
      "HubUUID": map['hubUuid'],
      "BldgID": map['bldgId'],
      "ItemName": map['itemName'],
      "NewValue": map['newValue'],
      "CustomerID": map['customerId'],
    };
    return await getApi(dataUrl, type: 'iot');
  }

  dynamic createScene(Map<String, dynamic> map) async {
    dynamic dataUrl = {
      "Command": "Scene",
      "Subcommand1": "Create",
      "CustomerID": map['customerId'],
      "UnitID": map['unitId'],
      "SceneName": map['sceneName']
    };
    return await getApi(dataUrl, type: 'iot');
  }

  dynamic populateFavorites(Map<String, dynamic> map) async {
    dynamic dataUrl = {
      "Command": "Room",
      "Subcommand1": "DeviceUpdate",
      "CustomerID": map['customerId'],
      "UnitID": map['unitId'],
      "RoomID": map['roomId'],
      "Item": map['item'],
    };
    return await getApi(dataUrl, type: 'iot');
  }

  dynamic getRooms(Map<String, dynamic> map) async {
    dynamic dataUrl = {
      "Command": "Room",
      "Subcommand1": "List",
      "CustomerID": map['customerId'],
      "UnitID": map['unitId']
    };
    return await getApi(dataUrl, type: 'iot');
  }

  dynamic deleteScene(Map<String, dynamic> map) async {
    dynamic dataUrl = {
      "Command": "Scene",
      "Subcommand1": "Remove",
      "CustomerID": map['customerId'],
      "UnitID": map['unitId'],
      "SceneID": map['sceneId']
    };
    return await getApi(dataUrl, type: 'iot');
  }

  dynamic getAllThings(Map<String, dynamic> map) async {
    dynamic dataUrl = {
      "Command": "Item",
      "Subcommand1": "List",
      "Building": map['building'],
      "Unit": map['unit']
    };
    return await getApi(dataUrl, type: 'iot');
  }

  dynamic getMessage(Map<String, dynamic> map) async {
    dynamic dataUrl = {
      "Command": "Message",
      "Subcommand1": "PollMessage",
      "Subcommand2": "N",
      "CustomerID": map['customerId']
    };
    return await getApi(dataUrl, type: 'iot');
  }

  dynamic createRoom(Map<String, dynamic> map) async {
    dynamic dataUrl = {
      "Command": "Room",
      "Subcommand1": "Create",
      "CustomerID": map['customerId'],
      "UnitID": map['unitId'],
      "RoomName": map['roomName']
    };
    return await getApi(dataUrl, type: 'iot');
  }

  dynamic removeRoom(Map<String, dynamic> map) async {
    dynamic dataUrl = {
      "Command": "Room",
      "Subcommand1": "Remove",
      "CustomerID": map['customerId'],
      "UnitID": map['unitId'],
      "RoomID": map['roomId']
    };
    return await getApi(dataUrl, type: 'iot');
  }

  dynamic changeRoomItems(Map<String, dynamic> map) async {
    dynamic dataUrl = {
      "Command": "Room",
      "Subcommand1": "DeviceUpdate",
      "CustomerID": map['customerId'],
      "UnitID": map['unitId'],
      "RoomID": map['roomId'],
      "Item": map['items']
    };
    return await getApi(dataUrl, type: 'iot');
  }
}

import 'dart:collection';

import 'package:cp/model/room/room.dart';
import 'package:cp/provider/account/message_manager/message_group.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/subjects.dart';

import '../../constants.dart';
import '../../enum.dart';
import '../../model/scene/scene.dart';
import '../../model/scene/scene_item/scene_item.dart';
import '../../model/thing/thing.dart';
import '../../repository/iot/home_repository.dart';
import '../../utils/utils/on_type_functions/debouncer.dart';
import '../main_provider.dart';

class HomeProvider {
  final hive = Hive.box('home_provider');
  final scenes$ = BehaviorSubject<DataState>.seeded(DataState.initial);
  var scenes = <Scene>[];
  var rooms = <Room>[];
  final currentRoom$ = BehaviorSubject<DataState>.seeded(DataState.initial);
  final rooms$ = BehaviorSubject<DataState>.seeded(DataState.initial);
  final globallySelectedRoom$ =
      BehaviorSubject<DataState>.seeded(DataState.initial);
  final things$ = BehaviorSubject<bool>.seeded(false);
  final _setTempDebouncer =
      Debouncer(delay: const Duration(milliseconds: 2000));
  List<Map<String, List<Thing>>> currentRoom = [];
  Map<String, Thing> thermostat = {};
  List<Map<String, List<Thing>>> orderedAllThings = [];
  List<Thing> allThings = [];
  var thermoNewValue = 0;
  var selectedRoom = Room();
  List<Map<String, String>> selectedItems = [];
  var favoritesRoom = Room().copyWith(RoomName: 'Favorites', RoomID: null);
  var globallySelectedRoom = Room().copyWith(RoomName: 'Favorites');

  String getId(String str) {
    var thermoId = '';
    currentRoom.forEach((element) {
      thermoId = element.keys
          .firstWhere((element) => element.toLowerCase().contains(str));
    });
    return thermoId;
  }

  refreshHome(BuildContext context) async {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    if (mainProvider.iot.Status == 'Success' && !mainProvider.isManager()) {
      things$.add(false);
      await getScenes({
        'customerId': mainProvider.user.CustomerID,
        'unitId': mainProvider.iot.ControllerBuildingUnitID,
        'server': mainProvider.server
      }, context);
      await getRooms({
        'server': mainProvider.server,
        'customerId': mainProvider.user.CustomerID,
        'unitId': mainProvider.iot.ControllerBuildingUnitID,
      }, context);
      await getAllThings({
        'server': mainProvider.server,
        'building': mainProvider.iot.ControllerBuildingID,
        'unit': mainProvider.iot.ControllerBuildingUnitID
      }, context);
      things$.add(true);
    } else {
      things$.add(true);
    }
  }

  double thingContainerHeight() {
    var height = 0.0;
    for (var i in currentRoom) {
      // i.keys.
      final name = i.keys.first;
      if (name.contains('S31 Lite') ||
          name.contains('TS') ||
          name.contains('ZB-CL') ||
          name.contains('RGBW')) {
        height = height + 55;
      } else if (name.contains('Thermostat')) {
        height = height + 420;
      } else if (name.contains('ROOM')) {
        height = height + 140;
      } else {}
    }
    return height;
  }

  Future<List<Scene>> getScenes(
      Map<String, dynamic> map, BuildContext context) async {
    final sceneList = <Scene>[];
    scenes$.add(DataState.loading);
    Map<String, dynamic> data =
        await HomeRepository(map['server']).getScenes(map);
    if (data['Status'] != 'Success') {
      scenes$.add(DataState.initial);
      return sceneList;
    }
    data['Scene'].forEach((element) {
      final newItems = <SceneItem>[];
      if (element['Items'] != null) {
        for (var i = 0; i < element['Items'].length; i++) {
          final items = element['Items'];
          if (items == null) {
          } else if (items.runtimeType.toString() == '_JsonMap') {
            newItems.add(SceneItem.fromJson(items));
          } else if (items.runtimeType.toString() ==
              '_InternalLinkedHashMap<String, dynamic>') {
            var hMap = HashMap.from(items);
            newItems.add(SceneItem.fromJson(hMap.cast()));
          } else {
            newItems.addAll(
                [...List.from(items).map((e) => SceneItem.fromJson(e))]);
          }
        }
      }

      sceneList.add(Scene(
          SceneName: element['SceneName'],
          SceneID: element['SceneID'],
          Items: newItems));
    });
    scenes = [...sceneList];
    scenes$.add(DataState.success);
    return sceneList;
  }

  setScene(Map<String, dynamic> map, BuildContext context) async {
    Map<String, dynamic> data =
        await HomeRepository(map['server']).changeDevice(map);
    if (data['Status'] == 'Success') {
    } else {}
  }

  setDevice(Map<String, dynamic> map, BuildContext context) async {
    Map<String, dynamic> data =
        await HomeRepository(map['server']).changeDevice(map);
    if (data['Status'] == 'Success') {
    } else {
      // await
    }
  }

  setTemp(Map<String, dynamic> map, BuildContext context) async {
    if (thermoNewValue != 0) {
      _setTempDebouncer.run(() async {
        thermoNewValue = 0;
        Map<String, dynamic> data =
            await HomeRepository(map['server']).changeDevice(map);
        if (data['Status'] == 'Success') {
        } else {}
      });
    }
  }

  createRoom(Map<String, dynamic> map, BuildContext context) async {
    rooms$.add(DataState.loading);
    Map<String, dynamic> data =
        await HomeRepository(map['server']).createRoom(map);
    await getRooms(map, context);
    rooms$.add(DataState.success);
  }

  changeRoomItems(Map<String, dynamic> map, BuildContext context) async {
    globallySelectedRoom$.add(DataState.loading);
    Map<String, dynamic> data =
        await HomeRepository(map['server']).changeRoomItems(map);

    await getRooms(map, context);
    selectedItems.clear();
    globallySelectedRoom$.add(DataState.success);
  }

  createScene(Map<String, dynamic> map, BuildContext context) async {
    scenes$.add(DataState.loading);
    Map<String, dynamic> data =
        await HomeRepository(map['server']).createScene(map);
    await getScenes(map, context);
  }

  getAllThings(Map<String, dynamic> map, BuildContext context) async {
    Map<String, dynamic> data =
        await HomeRepository(map['server']).getAllThings(map);
    if (data['Status'] == "Success") {
      final things = <Thing>[];
      if (data['Item'] == null) {
        return;
      }
      data['Item'].forEach((element) {
        final newItems = Thing.fromJson(element);
        things.add(newItems);
      });
      List<Map<String, List<Thing>>> groupedThings = [];
      allThings.clear();
      allThings.addAll(things);
      for (var el in things) {
        final id = el.ThingUUID;
        final itemLabel = el.ItemLabel;
        if (id.toString().contains('RoomBank') ||
            el.ItemCategory.toString().toLowerCase().contains('leak') ||
            el.ItemCategory.toString().toLowerCase().contains('motion') ||
            el.ItemCategory.toString().toLowerCase().contains('array') ||
            itemLabel.toString().toLowerCase().contains('child lock') ||
            // el.ItemLabel.toString().toLowerCase().contains('dimmer') ||
            // el.ItemLabel.toString().toLowerCase().contains('hue') ||
            // el.ItemLabel.toString().toLowerCase().contains('saturation') ||
            // el.ItemLabel.toString().toLowerCase().contains('brightness') ||
            itemLabel.toString().toLowerCase().contains('program mode')) {
          continue;
        }

        final isAdded =
            groupedThings.where((element) => element.containsKey(id));
        if (isAdded.isNotEmpty) {
          for (var e in groupedThings) {
            if (e.containsKey(id)) {
              e.update(id, (list) => [...list, el]);
            }
          }
        } else {
          groupedThings.add({
            id: [el]
          });
        }
      }
      orderedAllThings = groupedThings;
    }
  }

  setCurrentThings(Map<String, dynamic> map, BuildContext context) async {
    Map<String, dynamic> data =
        await HomeRepository(map['server']).populateFavorites(map);
  }

  Future<List<Room>> getRooms(
      Map<String, dynamic> map, BuildContext context) async {
    rooms$.add(DataState.loading);
    Map<String, dynamic> data =
        await HomeRepository(map['server']).getRooms(map);
    final roomList = <Room>[];
    currentRoom$.add(DataState.loading);
    rooms$.add(DataState.loading);
    if (data['Status'] != "Success") {
      rooms$.add(DataState.initial);
      return roomList;
    }
    data['Room'].forEach((element) {
      final newItems = <Thing>[];
      if (element['Items'] != null) {
        for (var i = 0; i < element['Items'].length; i++) {
          final items = element['Items'];
          if (items == null) {
          } else if (items.runtimeType.toString() == '_JsonMap') {
            newItems.add(Thing.fromJson(items));
          } else if (items.runtimeType.toString() ==
              '_InternalLinkedHashMap<String, dynamic>') {
            var hMap = HashMap.from(items);
            newItems.add(Thing.fromJson(hMap.cast()));
          } else {
            newItems
                .addAll([...List.from(items).map((e) => Thing.fromJson(e))]);
          }
        }
      }
      final room = Room(
          RoomID: element['RoomID'],
          CustomerId: element['CustomerId'],
          UnitId: element['UnitId'],
          RoomName: element['RoomName'],
          Items: newItems);

      roomList.add(room);
    });

    rooms = [...roomList];
    rooms$.add(DataState.success);
    currentRoom = getThingsByRoom(globallySelectedRoom.RoomName);
    updateThermostat();
    await thingSequencing();

    currentRoom$.add(DataState.success);
    return rooms;
  }

  List<Map<String, List<Thing>>> getThingsByRoom(String roomName) {
    List<Map<String, List<Thing>>> room = [];
    final things = rooms
        .singleWhere((element) =>
            element.RoomName.toString().toLowerCase() ==
            roomName.toString().toLowerCase())
        .Items;
    var realThermoStat = Thing(ThingUUID: 3);
    try {
      realThermoStat = things.firstWhere((element) {
        return element.ItemLabel.toString().toLowerCase() == 'newsetpoint';
      });
    } catch (ex) {}

    for (var el in things) {
      final id = el.ThingUUID;

      if (id.toString().contains('RoomBank') ||
          el.ItemCategory.toString().toLowerCase().contains('leak') ||
          el.ItemCategory.toString().toLowerCase().contains('motion') ||
          el.ItemCategory.toString().toLowerCase().contains('array') ||
          el.ItemLabel.toString().toLowerCase().contains('child lock') ||
          el.ItemLabel.toString().toLowerCase().contains('program mode') ||
          // el.ItemLabel.toString().toLowerCase().contains('dimmer') ||
          // el.ItemLabel.toString().toLowerCase().contains('hue') ||
          // el.ItemLabel.toString().toLowerCase().contains('saturation') ||
          // el.ItemLabel.toString().toLowerCase().contains('brightness') ||
          (el.ItemCategory.toString().toLowerCase().contains('thermostat') &&
              id != realThermoStat.ThingUUID)) {
        continue;
      }
      final isAdded = room.where((element) => element.containsKey(id));
      if (isAdded.isNotEmpty) {
        for (var e in room) {
          if (e.containsKey(id)) {
            e.update(id, (list) => [...list, el]);
          }
        }
      } else {
        room.add({
          id: [el]
        });
      }
    }
    return room;
  }

  Future<void> thingSequencing() async {
    final storedSequence = await getWidgetOrder();

    if (storedSequence.length == currentRoom.length) {
      List<Map<String, List<Thing>>> newFavorites = [];
      for (var i in storedSequence.values) {
        var o = currentRoom.firstWhere((element) => element.keys.first == i);
        for (var j in o.values) {
          newFavorites.add({i: j});
        }
      }
      currentRoom = newFavorites;
    }
  }

  void updateThermostat() {
    thermostat.clear();
    var thermoInfo = [];
    try {
      thermoInfo = [
        ...currentRoom
            .firstWhere((element) => element.keys.first.contains('Thermostat'))
            .values
      ];
    } catch (ex) {}
    if (thermoInfo.isEmpty) {
      thermostat = {};
      return;
    }
    for (var e in thermoInfo) {
      for (var o in e) {
        thermostat.addAll({o.ItemLabel: o});
      }
    }
  }

  deleteScene(Map<String, dynamic> map, BuildContext context) async {
    scenes$.add(DataState.loading);
    Map<String, dynamic> data =
        await HomeRepository(map['server']).deleteScene(map);
    if (data['Status'] == 'Success') {
      scenes.removeWhere((element) => element.SceneID == map['sceneId']);
      scenes$.add(DataState.success);
    }
  }

  removeRoom(Map<String, dynamic> map, BuildContext context) async {
    rooms$.add(DataState.loading);
    Map<String, dynamic> data =
        await HomeRepository(map['server']).removeRoom(map);
    if (data['Status'] == 'Success') {
      rooms.removeWhere((element) => element.RoomID == map['roomId']);
      rooms$.add(DataState.success);

      Navigator.pop(context);
    }
  }

  updateSystemMode(int x) {
    thermostat['System Mode'] = thermostat['System Mode']!
        .copyWith(ItemState: systemModeMap.elementAt(x));
  }

  Future<void> saveWidgetOrder() async {
    Map<int, dynamic> map = {};
    for (var i = 0; i < currentRoom.length; i++) {
      map.addAll({i: currentRoom[i].keys.elementAt(0)});
    }
    await hive.put('room:${globallySelectedRoom.RoomName}', map);
  }

  removeLocalWidgetOrder() async {
    return await hive.clear();
  }

  Future<dynamic> getWidgetOrder() async {
    final orders = await hive.get('room:${globallySelectedRoom.RoomName}');
    if (orders == null) {
      return {};
    }

    return orders;
  }

  saveSequence() async {
    await saveWidgetOrder();
  }
}

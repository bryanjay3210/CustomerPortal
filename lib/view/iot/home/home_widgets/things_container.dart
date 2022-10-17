import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../../provider/iot/home_provider.dart';
import '../../../../provider/main_provider.dart';
import '../../../shared_widgets/switch_widget.dart';
import 'dusun_thermostat.dart';
import 'right_shade/right_shade.dart';
import 'thing_padding_setter.dart';

class ThingsContainer extends StatefulWidget {
  final HomeProvider homeProvider;
  const ThingsContainer({Key? key, required this.homeProvider})
      : super(key: key);

  @override
  State<ThingsContainer> createState() => _ThingsContainerState();
}

class _ThingsContainerState extends State<ThingsContainer> {
  void reorderData(int oldindex, int newindex) {
    setState(() {
      if (newindex > oldindex) {
        newindex -= 1;
      }
      final items = widget.homeProvider.currentRoom.removeAt(oldindex);
      widget.homeProvider.currentRoom.insert(newindex, items);
      widget.homeProvider.saveSequence();
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.homeProvider.thingContainerHeight() == 0
        ? const SizedBox(
            height: 200,
            child: Center(child: Text('No Visible Device')),
          )
        : SizedBox(
            height: widget.homeProvider.thingContainerHeight() + 100,
            child: Theme(
              data: ThemeData(canvasColor: Colors.transparent),
              child: ReorderableListView(
                physics: const NeverScrollableScrollPhysics(),
                primary: false,
                shrinkWrap: true,
                buildDefaultDragHandles: false,
                onReorderStart: (i) {
                  HapticFeedback.mediumImpact();
                },
                onReorderEnd: (int i) {},
                children: <Widget>[
                  for (int index = 0;
                      index < widget.homeProvider.currentRoom.length;
                      index++)
                    Container(
                      color: Colors.transparent,
                      key: ValueKey('$index'),
                      child: ReorderableDelayedDragStartListener(
                          index: index,
                          child: widget.homeProvider.currentRoom[index].keys.first
                                      .contains('S31 Lite') ||
                                  widget.homeProvider.currentRoom[index].keys.first
                                      .contains('TS') ||
                                  widget.homeProvider.currentRoom[index].keys.first
                                      .contains('RGBW') ||
                                  widget.homeProvider.currentRoom[index].keys.first
                                      .contains('ZB-CL')
                              ? ThingPaddingSetter(
                                  hasPadding: (widget.homeProvider.currentRoom.length == (index + 1)
                                      ? false
                                      : widget.homeProvider.currentRoom[index + 1].keys.first.contains('TS') ||
                                          widget.homeProvider.currentRoom[index + 1].keys.first
                                              .contains('S31 Lite') ||
                                          widget.homeProvider
                                              .currentRoom[index + 1].keys.first
                                              .contains('RGBW') ||
                                          widget.homeProvider
                                              .currentRoom[index + 1].keys.first
                                              .contains('ZB-CL')),
                                  child: cpSwitchThingWidget(index, widget.homeProvider))
                              : widget.homeProvider.currentRoom[index].keys.first.contains('Thermostat')
                                  ? const DusunThermostat()
                                  : widget.homeProvider.currentRoom[index].keys.first.contains('ROOM')
                                      ? ThingPaddingSetter(
                                          child: RightShade(
                                            index: index,
                                          ),
                                          hasPadding: ((widget.homeProvider
                                                      .currentRoom.length ==
                                                  (index + 1))
                                              ? false
                                              : widget
                                                  .homeProvider
                                                  .currentRoom[index + 1]
                                                  .keys
                                                  .first
                                                  .contains('ROOM')),
                                        )
                                      : const SizedBox()),
                    )
                ],
                onReorder: reorderData,
              ),
            ));
  }

  Widget cpSwitchThingWidget(int index, HomeProvider homeProvider) {
    var name = '';
    final currentDevice = homeProvider.currentRoom[index].values.first[0];
    final humanName = currentDevice.ThingHumanName;
    final itemLabel = currentDevice.ItemLabel;
    final itemThingUUID = currentDevice.ThingUUID;
    final itemState = currentDevice.ItemState;
    final itemName = currentDevice.ItemName;
    final channelUUID = currentDevice.ChannelUUID;

    if (humanName.runtimeType.toString() == '_JsonMap') {
      name = itemLabel;
    } else if (humanName.runtimeType.toString() ==
        '_InternalLinkedHashMap<String, dynamic>') {
      name = itemLabel;
    } else {
      name = humanName;
    }
    return SwitchWidget(
      text: name,
      icon: icon(name),
      status: itemState == '1' ||
          itemState == 'On' ||
          itemState == 'on' ||
          itemState == 1,
      callback: () {
        final newDevice = homeProvider.currentRoom[index].values.first[0];
        final newState = newDevice.copyWith(
            ItemState: newDevice.ItemState == '1' ||
                    newDevice.ItemState == 'On' ||
                    newDevice.ItemState == 'on' ||
                    newDevice.ItemState == 1
                ? 'off'
                : 'on');
        homeProvider.currentRoom[index]
            .update(itemThingUUID, (value) => [newState]);
        final mainProvider = Provider.of<MainProvider>(context, listen: false);
        final iot = mainProvider.iot;

        homeProvider.setDevice({
          'hubUuid': iot.ControllerUUID,
          'bldgId': iot.ControllerBuildingID,
          'itemName': itemName,
          'newValue': newState.ItemState,
          'customerId': mainProvider.user.CustomerID,
          'server': mainProvider.server
        }, context);
      },
    );
  }

  Icon icon(String str) {
    return const Icon(Icons.abc);
  }
}

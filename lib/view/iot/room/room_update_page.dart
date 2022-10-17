import 'package:cp/main.dart';
import 'package:cp/view/shared_widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../enum.dart';
import '../../../provider/iot/home_provider.dart';
import '../../../provider/main_provider.dart';
import '../../../shared_widgets/shared_dialog.dart';
import '../../../utils/utils/theme/global_colors.dart';
import '../../shared_widgets/button.dart';
import '../../shared_widgets/checkbox_widget.dart';

class RoomUpdatePage extends StatefulWidget {
  const RoomUpdatePage({Key? key}) : super(key: key);

  @override
  _RoomUpdatePageState createState() => _RoomUpdatePageState();
}

class _RoomUpdatePageState extends State<RoomUpdatePage> {
  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    final iot = mainProvider.iot;
    final server = mainProvider.server;
    final user = mainProvider.user;

    return SafeArea(
      child: Scaffold(
        appBar: popUpPageAppBar2(homeProvider.selectedRoom.RoomName, () {
          if (homeProvider.selectedItems.isNotEmpty) {
            homeProvider.changeRoomItems({
              'server': server,
              'customerId': user.CustomerID,
              'unitId': iot.ControllerBuildingUnitID,
              'roomId': homeProvider.selectedRoom.RoomID,
              'items': homeProvider.selectedItems,
            }, context);
          }
          Navigator.pop(context);
        }),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: mainProvider.darkTheme
                  ? cpDarkContainerColor
                  : cpGreyLightColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StreamBuilder<DataState>(
                    stream: homeProvider.rooms$,
                    builder: (context, snapshot) {
                      if (snapshot.data == null ||
                          snapshot.data != DataState.success) {
                        return const Center(
                          child: Padding(
                              padding: EdgeInsets.all(20),
                              child: CircularProgressIndicator.adaptive()),
                        );
                      }
                      return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            for (var i in homeProvider.orderedAllThings)
                              Column(
                                children: [
                                  for (var o in i.values)
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 20),
                                          child: Text(
                                              (o.first.ThingHumanName
                                                              .runtimeType
                                                              .toString() ==
                                                          '_JsonMap' ||
                                                      o.first.ThingHumanName
                                                              .runtimeType
                                                              .toString() ==
                                                          '_InternalLinkedHashMap<String, dynamic>')
                                                  ? o.first.ItemCategory
                                                  : o.first.ThingHumanName,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15)),
                                        ),
                                        const SizedBox(height: 5),
                                        for (var e in o)
                                          CheckBoxWidget(
                                            callback: () {},
                                            status: (homeProvider
                                                .selectedRoom.Items
                                                .where((element) =>
                                                    element.ItemName ==
                                                    e.ItemName)
                                                .isNotEmpty),
                                            text: (e.ItemLabel.runtimeType
                                                            .toString() ==
                                                        '_JsonMap' ||
                                                    e.ItemLabel.runtimeType
                                                            .toString() ==
                                                        '_InternalLinkedHashMap<String, dynamic>')
                                                ? 'Unknown Label'
                                                : e.ItemLabel,
                                            itemId: e.ItemID,
                                            homeProvider: homeProvider,
                                          )
                                      ],
                                    )
                                ],
                              ),
                            removeWidget(homeProvider)
                          ]);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  removeWidget(HomeProvider homeProvider) {
    final disabled = homeProvider.selectedRoom.RoomName == 'Favorites';
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        width: 300,
        child: disabled
            ? const SizedBox()
            : StretchableButton(
                onPressed: () async {
                  final res = await showConfirmDialog(
                      context, 'Are you sure you want to delete this room?');
                  if (res) {
                    homeProvider.removeRoom({
                      'server': mainProvider.server,
                      "customerId": mainProvider.user.CustomerID,
                      "unitId": mainProvider.iot.ControllerBuildingUnitID,
                      "roomId": homeProvider.selectedRoom.RoomID
                    }, context);
                  }
                },
                text: 'Remove Room',
              ));
  }
}

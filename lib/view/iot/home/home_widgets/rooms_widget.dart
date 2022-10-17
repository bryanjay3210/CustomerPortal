import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../enum.dart';
import '../../../../provider/iot/home_provider.dart';
import '../../../../provider/main_provider.dart';
import '../../../shared_widgets/room_container.dart';

class RoomsWidget extends StatefulWidget {
  const RoomsWidget({Key? key}) : super(key: key);

  @override
  _CatDashboardSectionState createState() => _CatDashboardSectionState();
}

class _CatDashboardSectionState extends State<RoomsWidget> {
  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    return SizedBox(
        height: 150,
        child: StreamBuilder<DataState>(
            stream: homeProvider.rooms$,
            builder: (context, snapshot) {
              final data = homeProvider.rooms;

              if (snapshot.data == null || snapshot.data == DataState.initial) {
                return const Center(
                    child: CircularProgressIndicator.adaptive());
              }

              return ListView.builder(
                itemCount: data.length + 1,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: ((context, index) {
                  if (index == data.length) {
                    return RoomContainer(
                      svgImage: 'add_room_icon2',
                      title: 'My Rooms',
                      tap: () {
                        Navigator.pushNamed(context, 'room_management');
                      },
                    );
                  }
                  final room = data[index];
                  return RoomContainer(
                      svgImage: roomIcon(room.RoomName),
                      title: room.RoomName,
                      tap: () async {
                        if (room.RoomName ==
                            homeProvider.globallySelectedRoom.RoomName) {
                          return;
                        }
                        homeProvider.globallySelectedRoom$
                            .add(DataState.loading);
                        homeProvider.globallySelectedRoom = room;
                        await homeProvider.getRooms({
                          'server': mainProvider.server,
                          'customerId': mainProvider.user.CustomerID,
                          'unitId': mainProvider.iot.ControllerBuildingUnitID,
                        }, context);
                        homeProvider.globallySelectedRoom$
                            .add(DataState.success);
                      });
                }),
              );
            }));
  }

  String roomIcon(String str) {
    final name = str.toLowerCase();
    if (name.contains('cinema')) {
      return 'cinema_room_icon';
    } else if (name.contains('tv')) {
      return 'tv_room_icon';
    } else if (name.contains('office')) {
      return 'office_icon';
    }
    return 'living_room_icon';
  }
}

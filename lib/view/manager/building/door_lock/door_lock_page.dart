import 'package:cp/provider/iot/door_lock/door_lock_provider.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../enum.dart';
import '../../../../model/building/building.dart';
import '../../../../model/unit/unit.dart';
import '../../../../provider/main_provider.dart';
import '../../../../provider/manager/building_provider.dart';
import '../../../../utils/utils/theme/global_colors.dart';
import 'door_lock_widget.dart';

class DoorLockPage extends StatefulWidget {
  const DoorLockPage({Key? key}) : super(key: key);

  @override
  State<DoorLockPage> createState() => _DoorLockPageState();
}

class _DoorLockPageState extends State<DoorLockPage> {
  final lowerCtrler = TextEditingController();
  final upperCtrler = TextEditingController();
  final setPointCtrler = TextEditingController();

  int convertedValue(double val) {
    return int.parse((val * 1.8).round().toString()) + 32;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final doorLockProvider =
          Provider.of<DoorLockProvider>(context, listen: false);
      doorLockProvider.getBuildings({}, context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final buildingProvider =
        Provider.of<BuildingProvider>(context, listen: false);
    final doorLockProvider =
        Provider.of<DoorLockProvider>(context, listen: false);
    final isDarkMode =
        Provider.of<MainProvider>(context, listen: false).isDarkMode;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'door_lock_details_manager');
        },
        child: const Icon(Icons.add),
        backgroundColor: cpPrimaryColor,
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<DataState>(
            stream: doorLockProvider.buildings$,
            builder: (context, snapshot) {
              if (snapshot.data == null || snapshot.data == DataState.empty) {
                return const SizedBox();
              }

              if (snapshot.data == DataState.loading) {
                return const SizedBox(
                  height: 300,
                  child: Center(child: CircularProgressIndicator.adaptive()),
                );
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10, top: 20, bottom: 20),
                    child: Text('Door Locks',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 20),
                  IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // const Text('',
                                //     style: TextStyle(
                                //         fontSize: 15,
                                //         fontWeight: FontWeight.bold)),
                                // const SizedBox(height: 20),
                                dropDownBuildings(),
                                const SizedBox(height: 20),
                                dropDownUnits(),
                              ]),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              );
            }),
      ),
    );
  }

  Widget dropDownBuildings() {
    final provider = Provider.of<DoorLockProvider>(context, listen: false);

    return DropdownSearch<Building>(
        popupProps: const PopupPropsMultiSelection.menu(
          showSearchBox: true,
        ),
        itemAsString: (Building b) =>
            '${b.BuildingName} ${b.Type} ${b.BuildingID}',
        items: provider.buildings,
        onChanged: ((value) async {
          if (value == null) {
            return;
          }
          provider.selectedBuilding = value;
          print(value);
          // await contactOptionProvider.getContactOption(
          //     {'customerId': contactOptionProvider.currentCustomer.CustomerID},
          //     context, () {
          //   final provider = contactOptionProvider.currentProvider;
          // });
          provider.getUnits({}, context);
        }),
        selectedItem: provider.selectedBuilding);
  }

  Widget dropDownUnits() {
    final provider = Provider.of<DoorLockProvider>(context, listen: false);

    return StreamBuilder<DataState>(
        stream: provider.units$,
        builder: (context, snapshot) {
          if (snapshot.data == null || snapshot.data == DataState.initial) {
            return const SizedBox();
          }
          if (snapshot.data == DataState.loading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          return DropdownSearch<Unit>(
              popupProps: const PopupPropsMultiSelection.menu(
                showSearchBox: true,
              ),
              itemAsString: (Unit b) => b.UnitName,
              items: provider.units,
              onChanged: ((value) async {
                if (value == null) {
                  return;
                }
                provider.selectedUnit = value;
                print(value);
                // await contactOptionProvider.getContactOption(
                //     {'customerId': contactOptionProvider.currentCustomer.CustomerID},
                //     context, () {
                //   final provider = contactOptionProvider.currentProvider;
                // });
                provider.getDLockList({}, context);
              }),
              selectedItem: provider.selectedUnit);
        });
  }
}

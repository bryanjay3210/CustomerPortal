import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/subjects.dart';
import '../../../../constants.dart';
import '../../../../model/thing/thing.dart';
import '../../../../provider/iot/home_provider.dart';
import '../../../../provider/main_provider.dart';
import '../../../../utils/utils/theme/global_colors.dart';
import '../../../shared_widgets/switch_widget.dart';
import '../../../shared_widgets/system_mode_widget.dart';
import 'thermostat_painter.dart';
import 'string_transformer.dart';

class DusunThermostat extends StatefulWidget {
  const DusunThermostat({Key? key}) : super(key: key);

  @override
  _DusunThermostatState createState() => _DusunThermostatState();
}

class _DusunThermostatState extends State<DusunThermostat> {
  final systemMode$ = BehaviorSubject<int>.seeded(0);
  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    final thermo = homeProvider.thermostat;
    final thermostat$ = BehaviorSubject<Map<String, Thing>>.seeded(thermo);
    final iot = mainProvider.iot;
    systemMode$.add(systemModeMap.indexOf(thermo['System Mode'].toString()));

    void changeThermostatValue(Map<String, Thing> thermostat, int num) {
      final newState = double.parse(
          homeProvider.thermostat['CurrentSetpoint']!.ItemState.toString());
      homeProvider.thermoNewValue = homeProvider.thermoNewValue + num;
      homeProvider.thermostat['CurrentSetpoint'] =
          homeProvider.thermostat['CurrentSetpoint']!.copyWith(
              ItemState:
                  (newState + (num == 1 ? 0.555556 : -0.555556)).toString());
      homeProvider.setTemp({
        'hubUuid': iot.ControllerUUID,
        'bldgId': iot.ControllerBuildingID,
        'itemName': thermostat['NewSetpoint']!.ItemName,
        'newValue': (6 * homeProvider.thermoNewValue).toString(),
        'customerId': mainProvider.user.CustomerID,
        'server': mainProvider.server
      }, context);
      thermostat$.add(homeProvider.thermostat);
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color:
              mainProvider.darkTheme ? cpDarkContainerColor : cpGreyLightColor,
          borderRadius: BorderRadiusDirectional.circular(16),
        ),
        child: StreamBuilder<Map<String, Thing>>(
            stream: thermostat$,
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return const SizedBox();
              }

              final thermostat = snapshot.data!;

              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Dusun Thermostat',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: mainProvider.darkTheme
                                ? cpWhiteColor
                                : cpGreyDarkColor100,
                          ),
                        ),
                        const Text('')
                      ],
                    ),
                  ),
                  const Divider(
                    height: 0,
                    thickness: 1,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 75,
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 40),
                        alignment: Alignment.center,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              transform:
                                  Matrix4.translationValues(0.0, -20.0, 0.0),
                              width: 130,
                              height: 130,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: mainProvider.darkTheme
                                    ? cpDarkContainerColor
                                    : cpGreyLightColor,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    offset: const Offset(-7, -7),
                                    blurRadius: 8,
                                    spreadRadius: 3,
                                    color: mainProvider.darkTheme
                                        ? cpGreyDarkColor
                                        : Colors.white,
                                  ),
                                  BoxShadow(
                                    offset: const Offset(7, 7),
                                    blurRadius: 8,
                                    spreadRadius: -3,
                                    color: Colors.grey.shade400,
                                  ),
                                ],
                              ),
                              child: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white38,
                                  ),
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: mainProvider.darkTheme
                                        ? [
                                            Colors.grey,
                                            const Color(0xFFD0D3D9),
                                          ]
                                        : [
                                            const Color(0xFFFFFFFF),
                                            const Color(0xFFD0D3D9),
                                          ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: const Offset(7, 7),
                                      blurRadius: 17,
                                      spreadRadius: -2,
                                      color: Colors.grey.shade400,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      // thermostat['CurrentSetpoint'].toString(),
                                      celciusToFahr(
                                          thermostat['CurrentSetpoint']!
                                              .ItemState),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 23,
                                        fontFamily: "Sfprodisplay",
                                        color: cpGreyDarkColor,
                                      ),
                                    ),
                                    const Text(
                                      'Temp',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 10,
                                          color: cpGreyDarkColor100),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              transform:
                                  Matrix4.translationValues(0.0, -20.0, 0.0),
                              width: 112,
                              height: 112,
                              child: CustomPaint(
                                painter: ThermostatValuePainter(
                                  circleWidth: 8,
                                  completedPercentage: celciusToFahrInt(
                                      thermostat['CurrentSetpoint']!.ItemState),
                                  defaultCircleColor: Colors.transparent,
                                  percentageCompletedCircleColor:
                                      cpPrimaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      thermoInfo(thermostat)
                    ],
                  ),

                  const SizedBox(
                    height: 5,
                  ),

                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FloatingActionButton(
                          mini: true,
                          heroTag: 'thermostatminus',
                          elevation: 3,
                          backgroundColor: cpGreyLightColor,
                          onPressed: () {
                            changeThermostatValue(
                              thermostat,
                              -1,
                            );
                          },
                          child: const Icon(
                            Icons.remove,
                            color: cpGreyDarkColor100,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        const SizedBox(width: 50),
                        FloatingActionButton(
                          mini: true,
                          heroTag: 'thermostatplus',
                          elevation: 3,
                          backgroundColor: cpGreyLightColor,
                          onPressed: () {
                            changeThermostatValue(thermostat, 1);
                          },
                          child: const Icon(
                            Icons.add,
                            color: cpGreyDarkColor100,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 3,
                  ),
                  const Divider(
                    thickness: 1,
                    color: cpDivOnLightColor,
                  ),

                  //Auto Switch/On Switch
                  thermostat['Fan State'] == null
                      ? const SizedBox(
                          height: 5,
                        )
                      : SizedBox(
                          child: SwitchWidget(
                            text: 'Auto/On',
                            status: thermostat['Fan State']!.ItemState == 'On',
                            callback: () async {
                              final state =
                                  thermostat['Fan State']!.ItemState == 'On'
                                      ? 'Auto'
                                      : 'On';
                              homeProvider.thermostat['Fan State'] =
                                  homeProvider.thermostat['Fan State']!
                                      .copyWith(ItemState: state);
                              homeProvider.setDevice({
                                'hubUuid': iot.ControllerUUID,
                                'bldgId': iot.ControllerBuildingID,
                                'itemName': thermostat['Fan State']!.ItemName,
                                'newValue': state,
                                'customerId': mainProvider.user.CustomerID,
                                'server': mainProvider.server
                              }, context);
                            },
                          ),
                        ),
                  const Divider(
                    thickness: 1,
                    color: cpDivOnLightColor,
                  ),
                  thermostat['System Mode'] == null
                      ? const SizedBox(height: 10)
                      : Container(
                          constraints: const BoxConstraints(maxWidth: 400),
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: StreamBuilder<int>(
                              stream: systemMode$,
                              builder: (context, snapshot) {
                                final data = snapshot.data;
                                if (snapshot.data == null) {
                                  return const SizedBox();
                                }
                                return Row(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: SystemModeWidget(
                                        text: 'heat',
                                        SvgImage: 'heat_icon',
                                        BoxColor: colorWidget(
                                            thermostat['System Mode']!
                                                        .ItemState
                                                        .toString()
                                                        .toLowerCase() ==
                                                    'heat' &&
                                                (data == 0)),
                                        isActive: false,
                                        callback: () {
                                          homeProvider.updateSystemMode(0);
                                          homeProvider.setDevice({
                                            'hubUuid': iot.ControllerUUID,
                                            'bldgId': iot.ControllerBuildingID,
                                            'itemName':
                                                thermostat['System Mode']!
                                                    .ItemName,
                                            'newValue': 'heat',
                                            'customerId':
                                                mainProvider.user.CustomerID,
                                            'server': mainProvider.server
                                          }, context);
                                          systemMode$.add(0);
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Expanded(
                                      child: SystemModeWidget(
                                        text: 'cool',
                                        SvgImage: 'cool_icon',
                                        BoxColor: colorWidget(
                                            thermostat['System Mode']!
                                                    .ItemState
                                                    .toString()
                                                    .toLowerCase() ==
                                                'cool'),
                                        isActive: false,
                                        callback: () {
                                          homeProvider.updateSystemMode(1);
                                          homeProvider.setDevice({
                                            'hubUuid': iot.ControllerUUID,
                                            'bldgId': iot.ControllerBuildingID,
                                            'itemName':
                                                thermostat['System Mode']!
                                                    .ItemName,
                                            'newValue': 'cool',
                                            'customerId':
                                                mainProvider.user.CustomerID,
                                            'server': mainProvider.server
                                          }, context);
                                          systemMode$.add(1);
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Expanded(
                                      child: SystemModeWidget(
                                        text: 'auto',
                                        SvgImage: 'auto_icon',
                                        BoxColor: colorWidget(
                                            thermostat['System Mode']!
                                                    .ItemState
                                                    .toString()
                                                    .toLowerCase() ==
                                                'auto'),
                                        isActive: true,
                                        callback: () {
                                          homeProvider.updateSystemMode(2);
                                          homeProvider.setDevice({
                                            'hubUuid': iot.ControllerUUID,
                                            'bldgId': iot.ControllerBuildingID,
                                            'itemName':
                                                thermostat['System Mode']!
                                                    .ItemName,
                                            'newValue': 'auto',
                                            'customerId':
                                                mainProvider.user.CustomerID,
                                            'server': mainProvider.server
                                          }, context);
                                          systemMode$.add(2);
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Expanded(
                                      child: SystemModeWidget(
                                        text: 'off',
                                        // SvgImage: 'auto_icon',
                                        BoxColor: colorWidget(
                                            thermostat['System Mode']!
                                                    .ItemState
                                                    .toString()
                                                    .toLowerCase() ==
                                                'off'),
                                        isActive: false,
                                        callback: () {
                                          // homeProvider
                                          //         .thermostat['System Mode'] =
                                          //     thermostat['System Mode']!
                                          //         .ItemState
                                          //         .copyWith(ItemState: 'off');

                                          homeProvider.updateSystemMode(3);
                                          homeProvider.setDevice({
                                            'hubUuid': iot.ControllerUUID,
                                            'bldgId': iot.ControllerBuildingID,
                                            'itemName':
                                                thermostat['System Mode']!
                                                    .ItemName,
                                            'newValue': 'off',
                                            'customerId':
                                                mainProvider.user.CustomerID,
                                            'server': mainProvider.server
                                          }, context);
                                          systemMode$.add(3);
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              }),
                        ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              );
            }),
      ),
    );
  }

  Widget thermoInfo(Map<String, Thing> thermostat) {
    final isVisibleSystemState = thermostat['System State'] != null;
    final isVisibleRoomTemp = thermostat['Room Temp'] != null;
    return Container(
      padding: const EdgeInsets.only(right: 10, top: 10),
      constraints: const BoxConstraints(maxWidth: 70, minWidth: 70),
      // alignment: Alignment.topRight,
      // width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          isVisibleSystemState
              ? Column(
                  children: [
                    SvgPicture.asset('assets/images/home/fan_icon.svg'),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      thermostat['System State']!.ItemState,
                      style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          color: cpGreyLightColor400),
                    ),
                  ],
                )
              : const SizedBox(height: 5),
          const SizedBox(height: 20),
          isVisibleRoomTemp
              ? Column(
                  children: [
                    SvgPicture.asset('assets/images/home/thermostat_icon.svg'),
                    const SizedBox(height: 5),
                    Text(
                      celciusToFahr(thermostat['Room Temp']!.ItemState),
                      style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          color: cpGreyLightColor400),
                    ),
                  ],
                )
              : const SizedBox(height: 5),
        ],
      ),
    );
  }

  Color colorWidget(bool condition) {
    return condition ? cpPrimaryColor : cpGreyLightColor100;
  }
}

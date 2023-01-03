import 'package:cp/model/thermostat/thermostat.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../enum.dart';
import '../../../provider/main_provider.dart';
import '../../../provider/manager/building_provider.dart';
import '../../../shared_widgets/shared_text_field.dart';
import '../../../utils/utils/theme/global_colors.dart';
import '../../iot/home/home_widgets/string_transformer.dart';

class ThermostatsPage extends StatefulWidget {
  const ThermostatsPage({Key? key}) : super(key: key);

  @override
  State<ThermostatsPage> createState() => _ThermostatsPageState();
}

class _ThermostatsPageState extends State<ThermostatsPage> {
  final searchCtrler = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final mainProvider = Provider.of<MainProvider>(context, listen: false);
      Provider.of<BuildingProvider>(context, listen: false).getThermostats({
        'buildingId': mainProvider.user.CustomerID,
        'server': mainProvider.server,
        'loggedUser': mainProvider.user.UserID
      }, context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final buildingProvider =
        Provider.of<BuildingProvider>(context, listen: false);
    final mainProvider = Provider.of<MainProvider>(context, listen: false);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(left: 20, bottom: 20, top: 10),
            child: Text('Building Thermostats',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 0.0, right: 15, left: 15),
            child: textFieldShared2(context,
                ctrler: searchCtrler,
                isFloatingLabel: false,
                prefixIcon: const Icon(Icons.search),
                labelText: 'Search by Unit...',
                fillColor: Colors.white, onChanged: (text) {
              buildingProvider.filterThermostats(text);
            }),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  StreamBuilder<DataState>(
                      stream: buildingProvider.thermostats$,
                      builder: (context, snapshot) {
                        if (snapshot.data == null ||
                            snapshot.data == DataState.loading) {
                          return const SizedBox(
                            height: 300,
                            child: Center(
                                child: CircularProgressIndicator.adaptive()),
                          );
                        }
                        if (snapshot.data == DataState.empty) {
                          return const SizedBox(
                            height: 300,
                            child: Center(
                                child: Text('Thermostat does not exist')),
                          );
                        }
                        final data = buildingProvider.thermostats;
                        var i = -1;
                        return Container(
                          margin: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Provider.of<MainProvider>(context).darkTheme
                                ? cpDarkContainerColor
                                : cpGreyLightColor,
                          ),
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: buildingProvider.thermostats.length + 1,
                            itemBuilder: (context, ctx) {
                              if (ctx == buildingProvider.thermostats.length) {
                                return const SizedBox(height: 50);
                              }
                              final thermo = buildingProvider.thermostats[ctx];
                              i = i + 1;
                              return ListTile(
                                title: Wrap(
                                  alignment: WrapAlignment.spaceBetween,
                                  direction: Axis.horizontal,
                                  spacing: 100,
                                  runSpacing: 10,
                                  // mainAxisAlignment:
                                  // MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text('Unit: '),
                                        const SizedBox(width: 17),
                                        Text(thermo.UnitName),
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text('Mode:'),
                                        const SizedBox(width: 10),
                                        Text(thermo.Mode),
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text('Room:'),
                                        const SizedBox(width: 10),
                                        Text(celciusToFahr(thermo.RoomTemp)),
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text('Setpoint:'),
                                        const SizedBox(width: 10),
                                        Text(celciusToFahr(thermo.Setpoint)),
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text('Status:'),
                                        const SizedBox(width: 10),
                                        dropDownServerWidget(thermo,
                                            buildingProvider, mainProvider, i),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(),
                          ),
                        );
                      }),
                ],
              ),
            ),
          ),
          const SizedBox(height: 40)
        ],
      ),
    );
  }

  Widget dropDownServerWidget(Thermostat thermo, BuildingProvider provider,
      MainProvider mainProvider, int idx2) {
    return PopupMenuButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Text(thermo.AptStatus),
            ],
          ),
          const Icon(
            Icons.arrow_drop_down,
            color: Colors.grey,
          ),
        ],
      ),
      itemBuilder: (context) {
        return List.generate(3, (index) {
          return PopupMenuItem(
            onTap: () => setState(() {
              provider.changeStatus({
                'server': mainProvider.server,
                'buildingId': mainProvider.user.CustomerID,
                'loggedIn': mainProvider.user.UserID
              }, aptStatus[index], idx2, context);
            }),
            value: index,
            child: Text(
              aptStatus.elementAt(index),
            ),
          );
        });
      },
    );
  }
}

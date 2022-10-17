import 'package:cp/shared_widgets/shared_text_field.dart';
import 'package:cp/utils/utils/theme/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../enum.dart';
import '../../../provider/main_provider.dart';
import '../../../provider/manager/building_provider.dart';
import '../../../shared_widgets/toasts.dart';

class GlobalSetpointPage extends StatefulWidget {
  const GlobalSetpointPage({Key? key}) : super(key: key);

  @override
  State<GlobalSetpointPage> createState() => _GlobalSetpointPageState();
}

class _GlobalSetpointPageState extends State<GlobalSetpointPage> {
  final lowerCtrler = TextEditingController();
  final upperCtrler = TextEditingController();
  final setPointCtrler = TextEditingController();

  int convertedValue(double val) {
    return int.parse((val * 1.8).round().toString()) + 32;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final buildingProvider =
          Provider.of<BuildingProvider>(context, listen: false);

      await buildingProvider.getGlobalSetpoint(context);
      lowerCtrler.text =
          convertedValue(buildingProvider.lowerSetpoint).toString();
      upperCtrler.text = convertedValue(buildingProvider.upperPoint).toString();
      setPointCtrler.text =
          convertedValue(buildingProvider.setPoint).toString();
    });
    super.initState();
  }

  bool emptyCheck() {
    return lowerCtrler.text.trim().isEmpty ||
        upperCtrler.text.trim().isEmpty ||
        setPointCtrler.text.trim().isEmpty;
  }

  bool tempRangeCheck() {
    return int.parse(lowerCtrler.text) < 51 ||
        int.parse(upperCtrler.text) < 51 ||
        int.parse(setPointCtrler.text) < 51 ||
        int.parse(lowerCtrler.text) > 90 ||
        int.parse(upperCtrler.text) > 90 ||
        int.parse(setPointCtrler.text) > 90;
  }

  @override
  Widget build(BuildContext context) {
    final buildingProvider =
        Provider.of<BuildingProvider>(context, listen: false);
    final isDarkMode =
        Provider.of<MainProvider>(context, listen: false).isDarkMode;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: cpPrimaryColor,
          onPressed: () {
            if (emptyCheck()) {
              showToast('Please fill up all values');
              return;
            }

            if (tempRangeCheck()) {
              showToast('The accepted temperature is 50(°F) to 90(°F)');
              return;
            }

            buildingProvider.lowerSetpoint = buildingProvider.lowerSetpoint +
                ((double.parse(lowerCtrler.text) -
                        convertedValue(buildingProvider.lowerSetpoint)) *
                    0.555556);
            buildingProvider.upperPoint = buildingProvider.upperPoint +
                ((double.parse(upperCtrler.text) -
                        convertedValue(buildingProvider.upperPoint)) *
                    0.555556);
            buildingProvider.setPoint = buildingProvider.setPoint +
                ((double.parse(setPointCtrler.text) -
                        convertedValue(buildingProvider.setPoint)) *
                    0.555556);
            buildingProvider.setGlobalSetpoint(context);
          },
          child: const Icon(Icons.update)),
      body: SingleChildScrollView(
        child: StreamBuilder<DataState>(
            stream: buildingProvider.setpoint$,
            builder: (context, snapshot) {
              if (snapshot.data == null) {
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
                    child: Text('Thermostat Global Setpoints',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                  IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 12),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Occupied',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    Expanded(
                                        child: textFieldShared2(
                                      context,
                                      labelText: 'Lower Limit (°F)',
                                      textColor: isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                      readOnly: false,
                                      textInputAction: TextInputType.number,
                                      ctrler: lowerCtrler,
                                    )),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        child: textFieldShared2(context,
                                            labelText: 'Upper Limit (°F)',
                                            textColor: isDarkMode
                                                ? Colors.white
                                                : Colors.black,
                                            readOnly: false,
                                            textInputAction:
                                                TextInputType.number,
                                            ctrler: upperCtrler)),
                                  ],
                                )
                              ]),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IntrinsicHeight(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 12),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Vacant',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 20),
                                textFieldShared2(context,
                                    labelText: 'Set Point (°F)',
                                    textColor: isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                    ctrler: setPointCtrler,
                                    readOnly: false,
                                    textInputAction: TextInputType.number,
                                    onChanged: (newVal) {}),
                              ]),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}

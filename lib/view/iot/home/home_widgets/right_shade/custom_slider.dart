import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/subjects.dart';
import '../../../../../provider/iot/home_provider.dart';
import '../../../../../provider/main_provider.dart';
import '../../../../../utils/utils/on_type_functions/debouncer.dart';
import '../../../../../utils/utils/theme/global_colors.dart';

class CustomSlider extends StatefulWidget {
  final int index;
  const CustomSlider({Key? key, required this.index}) : super(key: key);
  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  final value$ = BehaviorSubject<int>.seeded(0);
  final focusNode = FocusNode();
  int indexTop = 0;
  final double _min = 0;
  final double _max = 100;
  // final divisions = 4;
  final _setDeviceDebouncer =
      Debouncer(delay: const Duration(milliseconds: 2000));

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    final thing = homeProvider.currentRoom[widget.index].values.first[0];
    RegExp regex = RegExp(r'([.]*)(?!.*\d)');
    var value = thing.ItemState.toString().replaceAll(regex, '');
    if (value.length > 3) {
      value = '0';
    }
    if (int.parse(value) > 100) {
      value = '100';
    }
    value$.add(int.parse(value));

    return SliderTheme(
      data: const SliderThemeData(
        activeTrackColor: cpPrimaryColorActive,
        inactiveTrackColor: cpPrimaryColorInActive,
        thumbColor: cpPrimaryColor,
        overlayColor: Color.fromRGBO(255, 233, 216, 0.6),
        valueIndicatorColor: cpGreyDarkColor,
        activeTickMarkColor: Colors.transparent,
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 45,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              StreamBuilder<int>(
                  stream: value$,
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return const SizedBox();
                    }
                    return CupertinoSlider(
                      value: value$.value.toDouble(),
                      thumbColor: cpPrimaryColorActive,
                      activeColor: cpPrimaryColorActive,
                      min: _min,
                      max: _max,
                      onChanged: (value) {
                        final newState =
                            thing.copyWith(ItemState: value.toInt().toString());
                        homeProvider.currentRoom[widget.index]
                            .update(thing.ThingUUID, (value) => [newState]);
                        value$.add(value.toInt());

                        final currentDevice = homeProvider
                            .currentRoom[widget.index].values.first[0];
                        final itemName = currentDevice.ItemName;
                        final mainProvider =
                            Provider.of<MainProvider>(context, listen: false);
                        final iot = mainProvider.iot;
                        _setDeviceDebouncer.run(() => {
                              homeProvider.setDevice({
                                'hubUuid': iot.ControllerUUID,
                                'bldgId': iot.ControllerBuildingID,
                                'itemName': itemName,
                                'newValue': {
                                  'device.windowopening':
                                      int.parse(newState.ItemState).round()
                                },
                                'customerId': mainProvider.user.CustomerID,
                                'server': mainProvider.server
                              }, context)
                            });
                      },
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

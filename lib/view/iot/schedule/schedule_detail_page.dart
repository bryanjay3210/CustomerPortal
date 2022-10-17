import 'package:cp/view/shared_widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import '../../../constants.dart';
import '../../../enum.dart';
import '../../../model/schedule/schedule.dart';
import '../../../provider/main_provider.dart';
import '../../../provider/iot/schedule_provider.dart';
import '../../../shared_widgets/shared_dialog.dart';
import '../../../utils/utils/theme/global_colors.dart';
import '../../shared_widgets/button.dart';
import 'package:intl/intl.dart';

class ScheduleDetailPage extends StatefulWidget {
  const ScheduleDetailPage({Key? key}) : super(key: key);

  @override
  State<ScheduleDetailPage> createState() => _ScheduleDetailPageState();
}

class _ScheduleDetailPageState extends State<ScheduleDetailPage> {
  final arraySelected$ = BehaviorSubject<List<String>>.seeded([]);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final mainProvider = Provider.of<MainProvider>(context, listen: false);
      final iot = mainProvider.iot;
      final user = mainProvider.user;
      final scheduleProvider =
          Provider.of<ScheduleProvider>(context, listen: false);
      scheduleProvider.getSchedules({
        'server': mainProvider.server,
        'customerId': user.CustomerID,
        'unitId': iot.ControllerBuildingUnitID,
        'sceneId': scheduleProvider.selectedScene.SceneID
      }, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    var _scheduleId = '0';
    final iot = mainProvider.iot;
    final user = mainProvider.user;
    final scheduleProvider =
        Provider.of<ScheduleProvider>(context, listen: false);
    final server = mainProvider.server;
    DateTime timeSelected = DateTime.now();

    Future<void> addOrEditDialog(
        VoidCallback callback, Schedule? sched, String _scheduleId) async {
      if (sched != null) {
        arraySelected$.add(sched.DayList.toString().split(','));
      } else {
        arraySelected$.add([]);
      }

      return showDialogShared(
          context,
          Container(
            height: 500,
            width: 330,
            decoration: BoxDecoration(
              color: mainProvider.darkTheme
                  ? cpDarkContainerColor
                  : cpGreyLightColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Add New Schedule',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                          color: mainProvider.darkTheme
                              ? cpWhiteColor
                              : cpGreyDarkColor,
                        ),
                      ),
                    ),
                    const Divider(
                      height: 0,
                      thickness: 1,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 25.0, top: 20),
                      child: Text('Select Time:',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    TimePickerSpinner(
                      isShowSeconds: false,
                      itemHeight: 40,
                      spacing: 5,
                      isForce2Digits: true,
                      alignment: Alignment.center,
                      normalTextStyle:
                          const TextStyle(color: Colors.grey, fontSize: 13),
                      highlightedTextStyle: TextStyle(
                          color: mainProvider.darkTheme
                              ? cpWhiteColor
                              : Colors.grey,
                          fontSize: 30),
                      time: timeSelected,
                      is24HourMode: false,
                      onTimeChange: (time) {
                        timeSelected = time;
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 25.0, top: 20),
                      child: Text('Select Days:',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: StreamBuilder<List<String>>(
                          stream: arraySelected$,
                          builder: (context, snapshot) {
                            if (snapshot.data == null) {
                              return const SizedBox();
                            }
                            return bubbleDaysAdd(
                                dayList, arraySelected$, () {});
                          }),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                )),
                Container(
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  child: StretchableButton(
                    text:
                        (_scheduleId == '0' ? 'Add Schedule' : 'Edit Schedule'),
                    onPressed: () async {
                      if (arraySelected$.value.isEmpty) {
                        Fluttertoast.showToast(
                            msg: "Please select a day",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black54,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        return;
                      }

                      callback();
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ));
    }

    add() async {
      await scheduleProvider.setSchedule({
        'server': server,
        'subCommand1': 'Add',
        'customerId': user.CustomerID,
        'unitId': iot.ControllerBuildingUnitID,
        'sceneId': scheduleProvider.selectedScene.SceneID,
        'dayList': arraySelected$.value.join(','),
        'time': DateFormat('HH:mm').format(timeSelected),
        'scheduleId': _scheduleId
      }, context);
    }

    remove(Schedule e) async {
      final id = e.ScheduleID;
      await scheduleProvider.setSchedule({
        'server': server,
        'subCommand1': 'Remove',
        'customerId': user.CustomerID,
        'unitId': iot.ControllerBuildingUnitID,
        'sceneId': e.SceneID,
        'dayList': e.DayList,
        'time': e.Time,
        'scheduleId': id
      }, context);
    }

    return Scaffold(
        appBar: popUpPageAppBar(scheduleProvider.selectedScene.SceneName),
        floatingActionButton: FloatingActionButton(
            backgroundColor: cpPrimaryColorActive,
            child: const Icon(Icons.add),
            onPressed: () async {
              _scheduleId = '0';

              addOrEditDialog(() {
                add();
              }, null, _scheduleId);
            }),
        body: StreamBuilder<DataState>(
            stream: scheduleProvider.schedules$,
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return const SizedBox();
              }
              if (snapshot.data == DataState.loading) {
                return Container(
                    alignment: Alignment.center,
                    height: mqHeight(context),
                    child: const CircularProgressIndicator.adaptive());
              }

              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Provider.of<MainProvider>(context).darkTheme
                            ? cpDarkContainerColor
                            : cpGreyLightColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              'Schedules',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 18,
                                color:
                                    Provider.of<MainProvider>(context).darkTheme
                                        ? cpWhiteColor
                                        : cpGreyDarkColor,
                              ),
                            ),
                          ),
                          const Divider(
                            height: 0,
                            thickness: 1,
                          ),
                          StreamBuilder<DataState>(
                              stream: scheduleProvider.schedules$,
                              builder: (context, snapshot) {
                                if (snapshot.data == null ||
                                    snapshot.data != DataState.success) {
                                  return const Padding(
                                      padding: EdgeInsets.all(20),
                                      child:
                                          CircularProgressIndicator.adaptive());
                                }
                                return Column(
                                  children: [
                                    ...scheduleProvider.allSchedules
                                        .map(
                                          (e) => Column(
                                            children: [
                                              ListTile(
                                                contentPadding:
                                                    const EdgeInsets.all(10),
                                                title: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(width: 4),
                                                    Text(
                                                      convertTime(e.Time),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18),
                                                    )
                                                  ],
                                                ),
                                                subtitle: bubbleDays(
                                                    e.DayList.toString()
                                                        .split(',')),
                                                trailing: GestureDetector(
                                                    onTap: () async {
                                                      final res =
                                                          await showConfirmDialog(
                                                              context,
                                                              'Are you sure you want to delete this schedule?');
                                                      if (res) {
                                                        remove(e);
                                                      }
                                                    },
                                                    child: SvgPicture.asset(
                                                        'assets/images/home/scene/delete_icon.svg')),
                                                onTap: () async {
                                                  final times =
                                                      e.Time.toString()
                                                          .split(':');
                                                  timeSelected = DateTime(
                                                      2022,
                                                      01,
                                                      01,
                                                      int.parse(times[0]),
                                                      int.parse(times[1]));
                                                  _scheduleId = e.ScheduleID;
                                                  addOrEditDialog(() async {
                                                    remove(e).whenComplete(
                                                        () => add());
                                                  }, e, _scheduleId);
                                                },
                                              ),
                                              const Divider(
                                                height: 0,
                                                thickness: 1,
                                              ),
                                            ],
                                          ),
                                        )
                                        .toList()
                                  ],
                                );
                              }),
                        ],
                      ),
                    ),
                    const SizedBox(height: 60)
                  ],
                ),
              );
            }));
  }

  String convertTime(String time) {
    return DateFormat().add_jm().format(DateFormat("hh:mm").parse('$time:00'));
  }

  Widget bubbleDaysAdd(List<String> list, BehaviorSubject<List<String>> data,
      GestureTapCallback onTap) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.start,
        alignment: WrapAlignment.start,
        spacing: 10.0,
        runSpacing: 20.0,
        children: [
          ...list.map((e) {
            final current = data.value;
            final isSelected = current.contains(e);

            return e.isEmpty
                ? const SizedBox()
                : GestureDetector(
                    onTap: () {
                      if (data.value.contains(e)) {
                        data.add([
                          ...data.value.where((element) => element != e)
                        ]..sort(((a, b) => a.compareTo(b))));
                      } else {
                        data.add([...data.value, e]
                          ..sort(((a, b) => a.compareTo(b))));
                      }
                    },
                    child: Chip(
                      shadowColor: cpGreyLightColor400,
                      side: const BorderSide(width: 0.2),
                      backgroundColor: isSelected
                          ? cpPrimaryColorActive
                          : mainProvider.darkTheme
                              ? const Color(0xff494949)
                              : cpGreyLightColor,
                      label: Text(convertNumToDay(e)),
                    ),
                  );
          }).toList()
        ],
      ),
    );
  }

  Widget bubbleDays(List<String> list) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.start,
      alignment: WrapAlignment.start,
      spacing: 10.0,
      runSpacing: 10.0,
      children: [
        ...list
            .map(
              (e) => e.isEmpty
                  ? const SizedBox()
                  : Chip(
                      label: Text(convertNumToDay(e)),
                    ),
            )
            .toList()
      ],
    );
  }

  String convertNumToDay(String day) {
    if (day == '1') {
      return 'Mon';
    } else if (day == '2') {
      return 'Tue';
    } else if (day == '3') {
      return 'Wed';
    } else if (day == '4') {
      return 'Thu';
    } else if (day == '5') {
      return 'Fri';
    } else if (day == '6') {
      return 'Sat';
    } else {
      return 'Sun';
    }
  }
}

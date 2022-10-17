import 'package:cp/provider/main_provider.dart';
import 'package:cp/provider/iot/schedule_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../enum.dart';
import '../../../provider/iot/home_provider.dart';
import '../../../utils/utils/theme/global_colors.dart';
import '../../shared_widgets/common_widgets.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  // getSchedules
  @override
  Widget build(BuildContext context) {
    final scheduleProvider =
        Provider.of<ScheduleProvider>(context, listen: false);
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    return Scaffold(
      appBar: popUpPageAppBar('Schedule Scenes'),
      body: SizedBox(
        height: mqHeight(context),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              children: [
                Container(
                  height: 200,
                  color: cpGreyDarkColor,
                ),
                const SizedBox(),
              ],
            ),
            Positioned(
              height: mqHeight(context),
              top: 0,
              left: 5,
              right: 5,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          StreamBuilder<DataState>(
                              stream: homeProvider.scenes$,
                              builder: (context, snapshot) {
                                if (snapshot.data == null ||
                                    snapshot.data != DataState.success) {
                                  return const Padding(
                                      padding: EdgeInsets.all(20),
                                      child:
                                          CircularProgressIndicator.adaptive());
                                }
                                final data = homeProvider.scenes;
                                return Container(
                                  height: data.length * 60,
                                  margin: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Provider.of<MainProvider>(context)
                                            .darkTheme
                                        ? cpDarkContainerColor
                                        : cpGreyLightColor,
                                  ),
                                  child: Column(
                                    children: [
                                      ...data.map((e) {
                                        return Column(
                                          children: [
                                            ListTile(
                                              title: Text(
                                                e.SceneName,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 18,
                                                  color:
                                                      Provider.of<MainProvider>(
                                                                  context)
                                                              .darkTheme
                                                          ? cpWhiteColor
                                                          : cpGreyDarkColor100,
                                                ),
                                              ),
                                              trailing: const Icon(Icons
                                                  .arrow_forward_ios_outlined),
                                              onTap: () {
                                                scheduleProvider.selectedScene =
                                                    e;
                                                Navigator.pushNamed(
                                                    context, 'schedule_detail');
                                              },
                                            ),
                                            const Divider(
                                              height: 0,
                                              thickness: 1,
                                            ),
                                          ],
                                        );
                                      }).toList(),
                                    ],
                                  ),
                                );
                              }),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 100)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

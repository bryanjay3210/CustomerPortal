import 'package:cp/view/manager/building/global_setpoint_page.dart';
import 'package:cp/view/manager/building/thermostats_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../utils/utils/theme/global_colors.dart';
import 'door_lock/door_lock_page.dart';

class BuildingPage extends StatefulWidget {
  const BuildingPage({Key? key}) : super(key: key);

  @override
  State<BuildingPage> createState() => _BuildingPageState();
}

class _BuildingPageState extends State<BuildingPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  static const List<Tab> _tabs = [
    Tab(
      icon: Icon(Icons.thermostat),
      text: 'Thermostats',
    ),
    Tab(icon: Icon(Icons.public_sharp), text: 'Global Set Point'),
    // Tab(icon: Icon(Icons.door_sliding_sharp), text: 'Door Lock')
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // _tabController.animateTo(0);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: cpGreyDarkColor),
        foregroundColor: cpWhiteColor,
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Building IOT',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        backgroundColor: cpGreyDarkColor,
        bottom: TabBar(controller: _tabController, tabs: _tabs),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          ThermostatsPage(),
          GlobalSetpointPage(),
          // DoorLockPage()
        ],
      ),
    );
  }
}

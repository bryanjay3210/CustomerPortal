import 'package:cp/shared_widgets/shared_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../constants.dart';
import '../../../../../provider/iot/door_lock/door_lock_provider.dart';

class DoorLockDetailsPage extends StatefulWidget {
  const DoorLockDetailsPage({Key? key}) : super(key: key);

  @override
  _DoorLockDetailsPageState createState() => _DoorLockDetailsPageState();
}

class _DoorLockDetailsPageState extends State<DoorLockDetailsPage> {
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final loginProv = Provider.of<DoorLockProvider>(context, listen: false)
          .assignDLock({}, context, () {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: appBar1(context, 'Door Lock'),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      margin: const EdgeInsets.all(10),
                      child: Container(
                        width: mqWidth(context),
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:slide_action/slide_action.dart';
import '../../../../shared_widgets/toasts.dart';
import '../../../../utils/utils/theme/global_colors.dart';

class DoorLockSharedWidgets extends StatefulWidget {
  const DoorLockSharedWidgets({Key? key}) : super(key: key);

  @override
  _DoorLockSharedWidgetsState createState() => _DoorLockSharedWidgetsState();
}

class _DoorLockSharedWidgetsState extends State<DoorLockSharedWidgets> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                child: SimpleExample(
              stretchThumb: true,
              resetDuration: const Duration(milliseconds: 500),
              isLock: true,
              callback: () async {
                await Future.delayed(const Duration(seconds: 1));
                showToast('Door Unlocked');
              },
            )),
            const SizedBox(width: 20),
            FloatingActionButton(
              backgroundColor: cpPrimaryColor,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              onPressed: () {
                showToast('Door Locked');
              },
              child: const Icon(Icons.lock),
            ),
          ],
        ),
      ],
    );
  }
}

class SimpleExample extends StatelessWidget {
  const SimpleExample({
    this.rightToLeft = false,
    this.callback,
    this.stretchThumb = false,
    this.resetCurve = Curves.easeOut,
    this.resetDuration = const Duration(milliseconds: 400),
    this.thumbWidth,
    this.trackHeight = 64,
    this.isLock = false,
    Key? key,
  }) : super(key: key);

  final bool rightToLeft;
  final FutureOr<void> Function()? callback;
  final bool stretchThumb;
  final Curve resetCurve;
  final Duration resetDuration;
  final double? thumbWidth;
  final double trackHeight;
  final bool isLock;

  @override
  Widget build(BuildContext context) {
    return SlideAction(
      trackHeight: trackHeight,
      snapAnimationCurve: resetCurve,
      snapAnimationDuration: resetDuration,
      stretchThumb: stretchThumb,
      thumbWidth: thumbWidth,
      rightToLeft: rightToLeft,
      trackBuilder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
              ),
            ],
          ),
          child: const Center(
            child: Text(
              "Swipe To Unlock",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
      thumbBuilder: (context, state) {
        return AnimatedContainer(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(100),
          ),
          duration: const Duration(milliseconds: 500),
          child: state.isPerformingAction
              ? const Icon(Icons.lock_open_sharp)
              : Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: stretchThumb ? 64 : double.infinity,
                    child: Center(
                      child: Icon(
                        rightToLeft ? Icons.chevron_left : Icons.chevron_right,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
        );
      },
      action: callback,
    );
  }
}

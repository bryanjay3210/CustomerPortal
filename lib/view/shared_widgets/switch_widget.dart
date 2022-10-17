import 'package:cp/provider/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/subjects.dart';
import '../../utils/utils/theme/global_colors.dart';

class SwitchWidget extends StatefulWidget {
  final String text;
  final Icon? icon;
  final bool status;
  final GestureTapCallback callback;

  const SwitchWidget({
    Key? key,
    required this.text,
    required this.status,
    required this.callback,
    this.icon,
  }) : super(key: key);

  @override
  _SwitchWidgetState createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
  final cpState = BehaviorSubject.seeded(true);
  @override
  Widget build(BuildContext context) {
    cpState.add(widget.status);
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color:
              mainProvider.darkTheme ? cpDarkContainerColor : cpGreyLightColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          (widget.icon != null)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    widget.icon!,
                    const SizedBox(width: 5),
                    Text(
                      widget.text,
                      style: TextStyle(
                        color: mainProvider.darkTheme
                            ? cpWhiteColor
                            : cpGreyDarkColor,
                        fontSize: 18,
                      ),
                    ),
                  ],
                )
              : Text(
                  widget.text,
                  style: TextStyle(
                    color:
                        mainProvider.darkTheme ? cpWhiteColor : cpGreyDarkColor,
                    fontSize: 18,
                  ),
                ),
          Transform.scale(
            scale: .7,
            child: InkWell(
              child: StreamBuilder<bool>(
                  stream: cpState,
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return const SizedBox();
                    }
                    return
                        // Platform.isAndroid
                        //     ? Switch(
                        //         onChanged: (value) {
                        //           cpState.add(value);
                        //           if (widget.callback != null) {
                        //             widget.callback();
                        //           }
                        //         },
                        //         value: snapshot.data!,
                        //         thumbColor:
                        //             MaterialStateProperty.all(cpGreyLightColor),
                        //         trackColor:
                        //             MaterialStateProperty.all(cpGreyDarkColor),
                        //         activeColor: cpPrimaryColor,
                        //       )
                        //     :
                        CupertinoSwitch(
                      thumbColor: cpGreyLightColor,
                      trackColor: cpGreyDarkColor,
                      activeColor: cpPrimaryColor,
                      value: snapshot.data!,
                      onChanged: (bool value) {
                        cpState.add(value);
                        if (widget.callback != null) {
                          widget.callback();
                        }
                      },
                    );
                  }),
              onTap: () {},
            ),
          ),
        ]),
      ),
    );
  }
}

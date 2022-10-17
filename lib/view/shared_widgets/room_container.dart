import 'package:cp/provider/main_provider.dart';
import 'package:cp/utils/utils/time/time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../utils/utils/theme/global_colors.dart';

class RoomContainer extends StatefulWidget {
  final String svgImage;
  final String title;
  final GestureTapCallback tap;

  const RoomContainer({
    Key? key,
    required this.svgImage,
    required this.title,
    required this.tap,
  }) : super(key: key);

  @override
  _RoomContainerState createState() => _RoomContainerState();
}

class _RoomContainerState extends State<RoomContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        right: 10,
        left: 10,
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ButtonTheme(
            child: ElevatedButton(
              onPressed: () async {
                if (widget.tap != null) {
                  await delayed(100);
                  widget.tap();
                }
              },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(0.0),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [cpPrimaryColor, cpYellowDarkColor],
                  ),
                ),
                child: Container(
                  alignment: Alignment.center,
                  width: 82,
                  height: 82,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SvgPicture.asset(
                        'assets/images/home/${widget.svgImage}.svg',
                        width: 40,
                        color: cpWhiteColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.title,
            style: TextStyle(
              color: context.read<MainProvider>().darkTheme ? cpWhiteColor : cpGreyDarkColor,
            ),
          ),
        ],
      ),
    );
  }
}

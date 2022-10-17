import 'package:cp/utils/utils/image/svg_icon.dart';
import 'package:flutter/material.dart';
import '../../../../constants.dart';
import '../../../../utils/utils/theme/global_colors.dart';
import '../../../../utils/utils/time/time.dart';

class SceneWidget extends StatefulWidget {
  final String svgIcon;
  final String title;
  final Color iconColor;
  final GestureTapCallback? tap;

  const SceneWidget(
      {Key? key,
      required this.svgIcon,
      required this.title,
      required this.iconColor,
      this.tap})
      : super(key: key);

  @override
  _SceneWidgetState createState() => _SceneWidgetState();
}

class _SceneWidgetState extends State<SceneWidget> {
  @override
  Widget build(BuildContext context) {
    String icon(String scene) {
      if (scene == 'Away') {
        return sceneIcon.elementAt(1).values.elementAt(1);
      } else if (scene == 'Home') {
        return sceneIcon.elementAt(2).values.elementAt(1);
      } else if (scene == 'Asleep') {
        return sceneIcon.elementAt(0).values.elementAt(1);
      } else if (scene == 'Add More') {
        return sceneIcon.elementAt(4).values.elementAt(1);
      } else {
        return sceneIcon.elementAt(3).values.elementAt(1);
      }
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
      alignment: Alignment.center,
      constraints: const BoxConstraints(maxWidth: 57),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 45,
            child: ButtonTheme(
              // minWidth: 65,
              padding: const EdgeInsets.all(0.0),
              child: ElevatedButton(
                onPressed: () async {
                  if (widget.tap != null) {
                    await delayed(100);
                    if (widget.tap != null) {
                      widget.tap!();
                    }
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
                      color: widget.iconColor),
                  child: Container(
                    alignment: Alignment.center,
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        svgIcon(
                          icon(widget.title),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 12,
                    color: cpGreyLightColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

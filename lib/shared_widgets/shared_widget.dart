import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/utils/image/svg_icon.dart';
import '../utils/utils/theme/global_colors.dart';

Widget badgeWidget(Widget widget, {int? number}) {
  return Stack(
    fit: StackFit.passthrough,
    children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 3, 8, 0),
        child: widget,
      ),
      if (number != null)
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                number.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
            decoration: const BoxDecoration(
              color: Colors.deepOrange,
              shape: BoxShape.circle,
            ),
          ),
        ),
    ],
  );
}

Widget badge(String iconLocation, String title, bool selected, bool isDarkMode,
    {double? size}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      // height: 80,
      // width: 40,
      child: Column(
        children: [
          svgIcon('images/home/$iconLocation',
              height: size ?? 18,
              color: selected
                  ? cpPrimaryColorActive
                  : (isDarkMode ? cpWhiteColor : cpGreyDarkColor)),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 12,
                color: selected
                    ? cpPrimaryColorActive
                    : (isDarkMode ? cpWhiteColor : cpGreyDarkColor)),
          ),
        ],
      ),
    ),
  );
}

// Widget badge(String name, {String? number}) {
//   return SizedBox(
//     height: 40,
//     width: 40,
//     child: Stack(
//       fit: StackFit.passthrough,
//       children: [
//         // ImageIcon(AssetImage(name), size: 18),
//         svgIcon('images/home/$name', height: 18),
//         if (number != null)
//           Positioned(
//             left: 25,
//             child: Container(
//               child: Padding(
//                 padding: const EdgeInsets.all(5.0),
//                 child: Text(
//                   number,
//                   style: const TextStyle(color: Colors.white, fontSize: 8),
//                 ),
//               ),
//               decoration: const BoxDecoration(
//                 color: Colors.deepOrange,
//                 shape: BoxShape.circle,
//               ),
//             ),
//           ),
//       ],
//     ),
//   );
// }

AppBar appBar1(BuildContext context, String title, {List<Widget>? actions}) {
  return AppBar(
    // toolbarHeight: isWeb(context) ? 35 : null,
    automaticallyImplyLeading: false,
    title: Text(title),
    // backgroundColor: color1,
    elevation: 0,
    actions: [
      if (actions != null) ...actions,
      IconButton(
        icon: const Icon(
          Icons.close,
          color: Colors.white,
          size: 30,
        ),
        onPressed: () {
          Navigator.of(context, rootNavigator: true).pop();
        },
      ),
    ],
  );
}

class DashDivider extends StatelessWidget {
  final double height;
  final Color color;

  const DashDivider({
    Key? key,
    this.height = 1,
    this.color = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 4.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}

Widget linearProgressIndicatorShared(BuildContext context) {
  return SizedBox(
    // width: isWeb(context) ? mqWidth(context) / 3 : mqWidth(context) / .3,
    child: LinearProgressIndicator(
      backgroundColor: Colors.grey.shade100,
      // color: color1,
    ),
  );
}

class ProgressDialog extends StatelessWidget {
  final String? message;
  const ProgressDialog({Key? key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.black,
        child: Container(
            margin: const EdgeInsets.all(15.0),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(6.0)),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(children: [
                const SizedBox(width: 6.0),
                Platform.isIOS
                    ? const CupertinoActivityIndicator()
                    : const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                      ),
                const SizedBox(width: 26.0),
                message != null
                    ? Text(message!,
                        style: const TextStyle(
                            color: Colors.black, fontSize: 10.0))
                    : const SizedBox(),
              ]),
            )));
  }
}

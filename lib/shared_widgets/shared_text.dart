import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:intely_health/utils/theme/global_colors.dart';

Widget appNameStyle(String name, double? size, {Color? color}) {
  return RichText(
    text: TextSpan(
      style: TextStyle(color: Colors.blue, fontSize: size),
      children: <TextSpan>[
        TextSpan(
            text: 'i',
            style: TextStyle(
              color: color ?? Colors.white,
              fontSize: size,
            )),
        TextSpan(
            text: 'ntely',
            style: TextStyle(color: color ?? Colors.white, fontSize: size)),
        TextSpan(
            text: name,
            style: TextStyle(color: Colors.purple[300], fontSize: size)),
      ],
    ),
  );
}

RichText richText2Shared(String first, String second,
    {GestureTapCallback? onTap}) {
  return RichText(
      text: TextSpan(
          text: '$first ',
          style: const TextStyle(color: Colors.black),
          children: [
        TextSpan(
          text: second,
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              if (onTap != null) onTap();
            },
          // style: TextStyle(color: colorBlue)
        )
      ]));
}

Text smallTextShared(String str, {Color? color}) {
  return Text(str,
      style: TextStyle(fontSize: 13, color: color ?? Colors.black));
}

Widget appTitle() {
  return Row(
    children: [
      const Image(
        image: AssetImage('assets/images/others/applogo2.png'),
        fit: BoxFit.cover,
        height: 50,
        width: 30,
      ),
      appNameStyle('Health', 20, color: Colors.blue),
    ],
  );
}

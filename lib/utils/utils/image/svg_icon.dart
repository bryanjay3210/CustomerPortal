import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget svgIcon(String assetLocation, {double? height, Color? color}) {
  return Align(
    child: SvgPicture.asset(
      'assets/$assetLocation.svg',
      color: color,
      fit: BoxFit.cover,
      allowDrawingOutsideViewBox: true,
      height: height,
    ),
  );
}

Widget svgCircleIcon(String assetName, {double? height, Color? color}) {
  return Container(
    padding: const EdgeInsets.all(4),
    decoration: BoxDecoration(
      color: color,
      shape: BoxShape.circle,
    ),
    child: SvgPicture.asset(
      'assets/images/$assetName.svg',
      fit: BoxFit.contain,
      height: height,
    ),
  );
}

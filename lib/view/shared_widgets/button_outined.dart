import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/utils/theme/global_colors.dart';

class ButtonOutlined extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const ButtonOutlined({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return ButtonTheme(
        minWidth: double.infinity,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(
              color: cpGreyLightColor200,
              width: 2.0,
            ),
          ),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              constraints: const BoxConstraints(minHeight: 50.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: const TextStyle(
                      color: cpGreyDarkColor,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SvgPicture.asset('assets/images/home/logout_icon.svg',
                      width: 15),
                ],
              ),
            ),
          ),
          onPressed: onPressed,
        ),
      );
    });
  }
}

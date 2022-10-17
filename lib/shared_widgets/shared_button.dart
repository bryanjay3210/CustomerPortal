import 'package:flutter/material.dart';

import '../utils/utils/theme/global_colors.dart';

// const double defaultBorderRadius = 3.0;

class StretchableButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  const StretchableButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  _StretchableButtonState createState() => _StretchableButtonState();
}

class _StretchableButtonState extends State<StretchableButton> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return ButtonTheme(
        // padding: const EdgeInsets.symmetric(vertical: 20),
        minWidth: double.infinity,
        child: ElevatedButton(
          style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(0.0),
              elevation: 0,
              backgroundColor: cpDivLightColor),
          child: Ink(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [cpPrimaryColor, cpYellowDarkColor]),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              constraints: const BoxConstraints(minHeight: 50.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                widget.text,
                style: const TextStyle(
                  color: cpGreyDarkColor,
                ),
              ),
            ),
          ),
          onPressed: widget.onPressed,
        ),
      );
    });
  }
}

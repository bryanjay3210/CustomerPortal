import 'package:flutter/material.dart';

import '../../utils/utils/theme/global_colors.dart';

class StretchableButtonSecondary extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  const StretchableButtonSecondary({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  _StretchableButtonSecondaryState createState() =>
      _StretchableButtonSecondaryState();
}

class _StretchableButtonSecondaryState
    extends State<StretchableButtonSecondary> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return ButtonTheme(
        minWidth: double.infinity,
        child: ElevatedButton(
          style: TextButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.all(0.0),
            elevation: 0,
            backgroundColor: cpDivLightColor,
          ),
          child: Ink(
            decoration: BoxDecoration(
              color: cpGreyLightColor100,
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

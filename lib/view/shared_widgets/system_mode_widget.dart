import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SystemModeWidget extends StatefulWidget {
  final String? SvgImage;
  final String text;
  final Color BoxColor;
  final bool isActive;
  final VoidCallback callback;

  const SystemModeWidget({
    Key? key,
    this.SvgImage,
    required this.text,
    required this.BoxColor,
    required this.isActive,
    required this.callback,
  }) : super(key: key);

  @override
  _SystemModeWidgetState createState() => _SystemModeWidgetState();
}

class _SystemModeWidgetState extends State<SystemModeWidget> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          fixedSize: const Size.fromHeight(20),
          primary: widget.isActive ? widget.BoxColor : widget.BoxColor,
          padding: const EdgeInsets.all(5),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      onPressed: () async {
        if (widget.callback != null) {
          widget.callback();
        }
      },
      child: widget.SvgImage == null
          ? text()
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/home/${widget.SvgImage}.svg',
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  widget.text,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
    );
  }

  Widget text() {
    return Text(
      widget.text,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 13,
      ),
    );
  }
}

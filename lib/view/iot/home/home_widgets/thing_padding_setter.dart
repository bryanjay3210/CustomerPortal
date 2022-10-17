import 'package:flutter/widgets.dart';

class ThingPaddingSetter extends StatefulWidget {
  final Widget child;
  final bool hasPadding;
  const ThingPaddingSetter(
      {Key? key, required this.child, required this.hasPadding})
      : super(key: key);

  @override
  State<ThingPaddingSetter> createState() => _ThingPaddingSetterState();
}

class _ThingPaddingSetterState extends State<ThingPaddingSetter> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: !widget.hasPadding ? 10 : 0),
      child: widget.child,
    );
  }
}

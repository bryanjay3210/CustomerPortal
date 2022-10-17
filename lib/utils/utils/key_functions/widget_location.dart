import 'package:flutter/widgets.dart';

Offset getGlobalPos(GlobalKey key) {
  if (key.currentContext == null) {
    return Offset.zero;
  }
  RenderBox box = key.currentContext!.findRenderObject() as RenderBox;
  Offset position = box.localToGlobal(Offset.zero); //this is global position
  return position;
}

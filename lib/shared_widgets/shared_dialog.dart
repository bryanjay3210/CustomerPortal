import 'package:cp/provider/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/utils/theme/global_colors.dart';

showDialogShared(BuildContext context, Widget page,
    {EdgeInsets? padding}) async {
  // await delayed(100);
  return showDialog(
      context: context,
      barrierDismissible: true,
      // barrierColor: Colors.transparent,

      builder: (_) => Dialog(
            elevation: 20,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            // insetAnimationDuration: const Duration(milliseconds: 0),
            insetPadding: padding,
            child: page,
          ));
}

Future<void> getDialogResult(BuildContext? context,
    TextEditingController ctrler, Widget widget, String title) async {
  final result = await showDialog(context: context!, builder: (_) => widget);
  if (result == null) {
    return;
  }
  ctrler.text = result;
}

Future<bool> showConfirmDialog(
  BuildContext context,
  String question,
) async {
  var res = false;
  await showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirmation'),
        content: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // Text('This is a demo alert dialog.'),
              Text(question),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel',
                style: TextStyle(
                    color: Provider.of<MainProvider>(context).darkTheme
                        ? cpWhiteColor
                        : cpGreyDarkColor100)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text(
              'Yes',
              style: TextStyle(
                  color: Provider.of<MainProvider>(context).darkTheme
                      ? cpWhiteColor
                      : cpGreyDarkColor100),
            ),
            style: TextButton.styleFrom(backgroundColor: cpPrimaryColor),
            onPressed: () {
              res = true;
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
  return res;
}

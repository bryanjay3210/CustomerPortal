import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../utils/utils/theme/global_colors.dart';

Widget textFieldShared(BuildContext? context,
    {required String title,
    Widget? prefixIcon,
    Widget? suffixIcon,
    bool readOnly = true,
    bool? hasUnderlineBorder = false,
    GestureTapCallback? onTap,
    TextEditingController? ctrler,
    BoxConstraints? constraints,
    bool? isTextArea,
    Function(String)? onChanged,
    bool? isDarkMode}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 15),
    child: TextField(
        maxLength: isTextArea == true ? null : null,
        maxLines: isTextArea == true ? null : 1,
        keyboardType:
            isTextArea == true ? TextInputType.multiline : TextInputType.text,
        readOnly: readOnly,
        controller: ctrler,
        onChanged: onChanged,
        textAlignVertical: TextAlignVertical.center,
        onTap: () {
          if (onTap != null) {
            onTap();
          }
        },
        decoration: InputDecoration(
            constraints: constraints,
            // ignore: prefer_const_constructors
            // contentPadding: EdgeInsets.symmetric(vertical: kIsWeb ? -7 : 0),
            // hintStyle: TextStyle(color: color1),
            // isCollapsed: true,
            // isDense: true,
            floatingLabelBehavior: isTextArea == true
                ? FloatingLabelBehavior.never
                : FloatingLabelBehavior.auto,
            focusedBorder: hasUnderlineBorder == true
                ? UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    // borderSide: BorderSide(color: color1),
                  )
                : InputBorder.none,
            labelText: title,
            floatingLabelStyle: isDarkMode == null
                ? null
                : TextStyle(
                    color: isDarkMode == false ? Colors.black : Colors.white,
                  ),
            border: hasUnderlineBorder == true
                ? UnderlineInputBorder(
                    // borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                    color: isDarkMode == true ? Colors.grey : Colors.black,
                  ))
                : InputBorder.none,
            prefixIcon: prefixIcon == null
                ? null
                : Padding(
                    padding: (kIsWeb)
                        ? const EdgeInsets.only(
                            right: 5, left: 5, top: 5, bottom: 15)
                        : const EdgeInsets.all(13),
                    child: prefixIcon,
                  ),
            suffixIcon: suffixIcon)),
  );
}

Widget textFieldShared2(BuildContext context,
    {String? labelText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    TextEditingController? ctrler,
    bool? readOnly = false,
    GestureTapCallback? onTap,
    bool? isFloatingLabel = true,
    BoxConstraints? constraints,
    bool? isObscureText = false,
    bool? hasBottompadding = true,
    Color? fillColor,
    Color? textColor,
    TextInputType? textInputAction,
    Function(String)? onChanged}) {
  return Padding(
    padding: EdgeInsets.only(bottom: hasBottompadding == true ? 10.0 : 0.0),
    child: TextFormField(
      onChanged: onChanged,
      textAlignVertical: TextAlignVertical.center,
      readOnly: readOnly == true,
      obscureText: isObscureText == true,
      controller: ctrler,
      style: TextStyle(color: textColor ?? cpGreyLightColor400),
      // cursorColor: color1,
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      keyboardType: textInputAction ?? TextInputType.text,
      decoration: InputDecoration(
          constraints: constraints,
          isDense: true,
          isCollapsed: true,
          contentPadding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)),
          floatingLabelBehavior: isFloatingLabel == true
              ? FloatingLabelBehavior.always
              : FloatingLabelBehavior.never,
          floatingLabelStyle: const TextStyle(
            color: cpGreyLightColor400,
          ),
          labelText: labelText,
          prefixIcon: prefixIcon,
          suffixIcon: Padding(
            padding: const EdgeInsets.all(0.0),
            child: suffixIcon,
          ),
          labelStyle: const TextStyle(color: cpGreyLightColor400),
          fillColor: fillColor,
          filled: fillColor != null,
          focusedBorder: const OutlineInputBorder(
              //     borderSide: BorderSide(
              //   color: color1,
              // )
              )),
    ),
  );
}

Widget textFieldSelection(BuildContext context,
    {String? title,
    String? current,
    GestureTapCallback? onTap,
    bool? hasPrefixIcon}) {
  return Padding(
    padding: const EdgeInsets.all(0),
    child: TextFormField(
      initialValue: title,
      style: TextStyle(color: Colors.grey.shade700),
      textAlignVertical: TextAlignVertical.bottom,
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      decoration: InputDecoration(
          border: InputBorder.none,
          isCollapsed: true,
          isDense: true,
          contentPadding: EdgeInsets.fromLTRB(10, kIsWeb ? 20 : 10, 0, 5),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          floatingLabelStyle: const TextStyle(
            color: Colors.black,
          ),
          prefixIcon: hasPrefixIcon == null
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    current == title
                        ? Icons.radio_button_checked
                        : Icons.circle_outlined,
                    // color: color1,
                  ),
                )
              : null,
          labelStyle: const TextStyle(
            color: Colors.black,
          )),
      readOnly: true,
    ),
  );
}

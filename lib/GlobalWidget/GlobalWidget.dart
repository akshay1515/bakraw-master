import 'package:bakraw/utils/GroceryColors.dart';
import 'package:bakraw/utils/GroceryConstant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

BoxDecoration boxDecoration(
    {double radius = 2,
    Color color = Colors.transparent,
    Color bgColor,
    var showShadow = false}) {
  return BoxDecoration(
    color: bgColor,
    boxShadow: showShadow
        ? BoxShadow(color: Colors.black54)
        : [BoxShadow(color: Colors.transparent)],
    border: Border.all(color: color),
    borderRadius: BorderRadius.all(Radius.circular(radius)),
  );
}

Widget text(
  String text, {
  var fontSize = textSizeLargeMedium,
  var textColor,
  var fontFamily,
  var isCentered = false,
  var maxLine = 1,
  var latterSpacing = 0.5,
  bool textAllCaps = false,
  var isLongText = false,
  bool lineThrough = false,
}) {
  return Text(
    textAllCaps ? text.toUpperCase() : text,
    textAlign: isCentered ? TextAlign.center : TextAlign.start,
    maxLines: isLongText ? null : maxLine,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      fontFamily: fontFamily ?? null,
      fontSize: fontSize,
      color: textColor == null ? grocery_Color_black : textColor,
      height: 1.5,
      letterSpacing: latterSpacing,
      decoration:
          lineThrough ? TextDecoration.lineThrough : TextDecoration.none,
    ),
  );
}

void changeStatusColor(Color color) async {
  try {
    await FlutterStatusbarcolor.setStatusBarColor(color, animate: true);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(
        useWhiteForeground(color));
  } on Exception catch (e) {
    print(e);
  }
}

Function(BuildContext, String) placeholderWidgetFn() =>
    (_, s) => placeholderWidget();

Widget placeholderWidget() =>
    Image.asset('images/LikeButton/image/grey.jpg', fit: BoxFit.cover);

InputDecoration formFieldDecoration(String hint_text) {
  return InputDecoration(
    labelText: hint_text,
    focusColor: grocery_colorPrimary,
    counterText: "",
    labelStyle: TextStyle(fontFamily: fontRegular, fontSize: textSizeMedium),
    contentPadding: new EdgeInsets.only(bottom: 2.0),
  );
}

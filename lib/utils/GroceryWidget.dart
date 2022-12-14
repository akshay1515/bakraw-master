import 'package:bakraw/GlobalWidget/GlobalWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/GroceryColors.dart';
import '../utils/GroceryConstant.dart';

Widget button(
  BuildContext context,
  String text, {
  Color textColor = grocery_color_white,
  Color backgroundColor = grocery_colorPrimary,
  double height = 40,
  double width = 150,
}) {
  return Padding(
    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: MaterialButton(
        onPressed: () {
          //
        },
        height: height,
        minWidth: width,
        padding: const EdgeInsets.all(0.0),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Text(text,
                style: TextStyle(fontSize: 18), textAlign: TextAlign.center)),
        textColor: textColor,
        color: backgroundColor,
      ),
    ),
  );
}

class groceryButton extends StatefulWidget {
  static String tag = '/dpButton';
  var textContent;
  VoidCallback onPressed;
  var isStroked = false;
  var height = 50.0;
  var radius = 5.0;
  var bgColors = grocery_colorPrimary;
  var color = grocery_colorPrimary;

  groceryButton(
      {@required this.textContent,
      @required this.onPressed,
      this.isStroked = false,
      this.height = 50.0,
      this.radius = 5.0,
      this.color,
      this.bgColors});

  @override
  groceryButtonState createState() => groceryButtonState();
}

class groceryButtonState extends State<groceryButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        padding: EdgeInsets.fromLTRB(16, 6, 16, 6),
        alignment: Alignment.center,
        child: text(widget.textContent,
            textColor:
                widget.isStroked ? grocery_colorPrimary : grocery_color_white,
            fontSize: textSizeLargeMedium,
            isCentered: true,
            fontFamily: fontSemiBold,
            textAllCaps: true),
        decoration: widget.isStroked
            ? boxDecoration(
                bgColor: Colors.transparent, color: grocery_colorPrimary)
            : boxDecoration(bgColor: widget.bgColors, radius: widget.radius),
      ),
    );
  }
}

class productdecButton extends StatefulWidget {
  static String tag = '/dpButton';
  var textContent;
  VoidCallback onPressed;
  var isStroked = false;
  var height = 50.0;
  var radius = 5.0;
  var bgColors = grocery_colorPrimary;
  var color = grocery_colorPrimary;

  productdecButton(
      {@required this.textContent,
      @required this.onPressed,
      this.isStroked = false,
      this.height = 50.0,
      this.radius = 5.0,
      this.color,
      this.bgColors});

  @override
  productdecButtonState createState() => productdecButtonState();
}

class productdecButtonState extends State<productdecButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        padding: EdgeInsets.fromLTRB(16, 6, 16, 6),
        alignment: Alignment.center,
        child: text(widget.textContent,
            textColor:
                widget.isStroked ? grocery_colorPrimary : grocery_color_white,
            fontSize: textSizeMedium,
            isCentered: true,
            fontFamily: fontSemiBold,
            textAllCaps: true),
        decoration: widget.isStroked
            ? boxDecoration(
                bgColor: Colors.transparent, color: grocery_colorPrimary)
            : boxDecoration(bgColor: widget.bgColors, radius: widget.radius),
      ),
    );
  }
}

class groceryButton1 extends StatefulWidget {
  static String tag = '/dpButton';
  var textContent;
  VoidCallback onPressed;
  var isStroked = false;
  var height = 50.0;

  groceryButton1(
      {@required this.textContent,
      @required this.onPressed,
      this.isStroked = false,
      this.height = 50.0});

  @override
  groceryButton1State createState() => groceryButton1State();
}

class groceryButton1State extends State<groceryButton1> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        padding: EdgeInsets.fromLTRB(16, 6, 16, 6),
        alignment: Alignment.center,
        child: text(widget.textContent,
            textColor: widget.isStroked
                ? grocery_textGreenColor
                : grocery_textGreenColor,
            fontSize: textSizeLargeMedium,
            isCentered: true,
            fontFamily: fontSemiBold,
            textAllCaps: false),
        decoration: widget.isStroked
            ? boxDecoration(
                bgColor: grocery_color_white, color: grocery_color_white)
            : boxDecoration(bgColor: grocery_color_white, radius: 5.0),
      ),
    );
  }
}

class EditText extends StatefulWidget {
  var isPassword;
  var isSecure;
  var fontSize;
  var textColor;
  var fontFamily;
  var text;
  var maxLine;
  var keyboardType;
  var maxcharacter;
  TextEditingController mController;

  VoidCallback onPressed;

  EditText(
      {var this.fontSize = textSizeMedium,
      var this.textColor = grocery_textColorSecondary,
      var this.fontFamily = fontRegular,
      var this.isPassword = true,
      var this.isSecure = false,
      var this.text = "",
      var this.mController,
      var this.maxcharacter,
      var this.keyboardType,
      var this.maxLine = 1});

  @override
  State<StatefulWidget> createState() {
    return EditTextState();
  }
}

class EditTextState extends State<EditText> {
  @override
  Widget build(BuildContext context) {
    if (!widget.isSecure) {
      return TextFormField(
        controller: widget.mController,
        obscureText: widget.isPassword,
        cursorColor: grocery_textGreenColor,
        keyboardType: widget.keyboardType,
        maxLength: widget.maxcharacter,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(0, 8, 4, 8),
          hintText: widget.text,
//          labelText: widget.text,
          enabledBorder: UnderlineInputBorder(
            borderSide: const BorderSide(color: grocery_view_color, width: 0.0),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: const BorderSide(color: grocery_view_color, width: 0.0),
          ),
        ),
        maxLines: widget.maxLine,
        style: TextStyle(
            fontSize: widget.fontSize,
            color: grocery_textColorPrimary,
            fontFamily: widget.fontFamily),
      );
    } else {
      return TextField(
        controller: widget.mController,
        obscureText: widget.isPassword,
        cursorColor: grocery_colorPrimary,
        decoration: InputDecoration(
          suffixIcon: new GestureDetector(
            onTap: () {
              setState(() {
                widget.isPassword = !widget.isPassword;
              });
            },
            child: new Icon(
                widget.isPassword ? Icons.visibility : Icons.visibility_off),
          ),
          contentPadding: EdgeInsets.fromLTRB(16, 8, 4, 8),
          hintText: widget.text,
          labelText: widget.text,
          enabledBorder: UnderlineInputBorder(
            borderSide: const BorderSide(color: grocery_view_color, width: 0.0),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: const BorderSide(color: grocery_view_color, width: 0.0),
          ),
        ),
        style: TextStyle(
            fontSize: widget.fontSize,
            color: grocery_textColorPrimary,
            fontFamily: widget.fontFamily),
      );
    }
  }
}

Widget title(
    String title, Color headerColor, Color textColor, BuildContext context) {
  return Stack(
    alignment: Alignment.topCenter,
    children: <Widget>[
      Container(color: headerColor),
      Center(
        child: Padding(
          padding: const EdgeInsets.only(
              left: spacing_standard, right: spacing_standard),
          child: Row(
            children: <Widget>[
              IconButton(
                icon: Padding(
                  padding: const EdgeInsets.only(top: spacing_standard_new),
                  child: Icon(Icons.arrow_back, size: 30, color: textColor),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: spacing_standard, top: 26),
                child: text(title,
                    textColor: textColor,
                    fontSize: textSizeNormal,
                    fontFamily: fontBold,
                    isCentered: true),
              )
            ],
          ),
        ),
      )
    ],
  );
}

Widget title1(
    String title, Color color1, Color textColor, BuildContext context) {
  return Stack(
    alignment: Alignment.topCenter,
    children: <Widget>[
      Container(color: color1),
      Center(
          child: Padding(
        padding: const EdgeInsets.only(
          left: spacing_standard,
          right: spacing_standard,
        ),
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Padding(
                padding: const EdgeInsets.only(top: spacing_standard_new),
                child: Icon(Icons.close, size: 30, color: textColor),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: spacing_standard, top: 26),
              child: text(title,
                  textColor: textColor,
                  fontSize: textSizeNormal,
                  fontFamily: fontBold,
                  isCentered: true),
            )
          ],
        ),
      ))
    ],
  );
}

class PinEntryTextField extends StatefulWidget {
  final String lastPin;
  final int fields;
  final onSubmit;
  final fieldWidth;
  final fontSize;
  final isTextObscure;
  final showFieldAsBox;

  PinEntryTextField(
      {this.lastPin,
      this.fields: 4,
      this.onSubmit,
      this.fieldWidth: 40.0,
      this.fontSize: 16.0,
      this.isTextObscure: false,
      this.showFieldAsBox: false})
      : assert(fields > 0);

  @override
  State createState() {
    return PinEntryTextFieldState();
  }
}

class PinEntryTextFieldState extends State<PinEntryTextField> {
  List<String> _pin;
  List<FocusNode> _focusNodes;
  List<TextEditingController> _textControllers;

  Widget textfields = Container();

  @override
  void initState() {
    super.initState();
    _pin = List<String>(widget.fields);
    _focusNodes = List<FocusNode>(widget.fields);
    _textControllers = List<TextEditingController>(widget.fields);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        if (widget.lastPin != null) {
          for (var i = 0; i < widget.lastPin.length; i++) {
            _pin[i] = widget.lastPin[i];
          }
        }
        textfields = generateTextFields(context);
      });
    });
  }

  @override
  void dispose() {
    _textControllers.forEach((TextEditingController t) => t.dispose());
    super.dispose();
  }

  Widget generateTextFields(BuildContext context) {
    List<Widget> textFields = List.generate(widget.fields, (int i) {
      return buildTextField(i, context);
    });

    if (_pin.first != null) {
      FocusScope.of(context).requestFocus(_focusNodes[0]);
    }

    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        verticalDirection: VerticalDirection.down,
        children: textFields);
  }

  void clearTextFields() {
    _textControllers.forEach(
        (TextEditingController tEditController) => tEditController.clear());
    _pin.clear();
  }

  Widget buildTextField(int i, BuildContext context) {
    if (_focusNodes[i] == null) {
      _focusNodes[i] = FocusNode();
    }
    if (_textControllers[i] == null) {
      _textControllers[i] = TextEditingController();
      if (widget.lastPin != null) {
        _textControllers[i].text = widget.lastPin[i];
      }
    }

    _focusNodes[i].addListener(() {
      if (_focusNodes[i].hasFocus) {}
    });

    final String lastDigit = _textControllers[i].text;

    return Container(
      width: widget.fieldWidth,
      margin: EdgeInsets.only(right: 20.0),
      child: Padding(
        padding: const EdgeInsets.only(
            left: spacing_control, right: spacing_control),
        child: TextField(
          controller: _textControllers[i],
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          maxLength: 1,
          style: TextStyle(
              color: Colors.black,
              fontFamily: fontMedium,
              fontSize: widget.fontSize),
          focusNode: _focusNodes[i],
          obscureText: widget.isTextObscure,
          decoration: InputDecoration(
              counterText: "",
              border: widget.showFieldAsBox
                  ? OutlineInputBorder(borderSide: BorderSide(width: 2.0))
                  : null),
          onChanged: (String str) {
            setState(() {
              _pin[i] = str;
            });
            if (i + 1 != widget.fields) {
              _focusNodes[i].unfocus();
              if (lastDigit != null && _pin[i] == '') {
                FocusScope.of(context).requestFocus(_focusNodes[i - 1]);
              } else {
                FocusScope.of(context).requestFocus(_focusNodes[i + 1]);
              }
            } else {
              _focusNodes[i].unfocus();
              if (lastDigit != null && _pin[i] == '') {
                FocusScope.of(context).requestFocus(_focusNodes[i - 1]);
              }
            }
            if (_pin.every((String digit) => digit != null && digit != '')) {
              widget.onSubmit(_pin.join());
            }
          },
          onSubmitted: (String str) {
            if (_pin.every((String digit) => digit != null && digit != '')) {
              widget.onSubmit(_pin.join());
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return textfields;
  }
}

class TopBar extends StatefulWidget {
  var leftIcon;
  var titleName;
  var rightIcon;
  VoidCallback onPressed;

  TopBar(var this.leftIcon, var this.titleName, this.onPressed);

  @override
  State<StatefulWidget> createState() {
    return TopBarState();
  }
}

class TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: grocery_colorPrimary,
        padding: EdgeInsets.only(right: spacing_standard_new),
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(widget.leftIcon),
                  color: grocery_color_white,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Center(
                    child: text(widget.titleName,
                        fontFamily: fontBold,
                        textColor: grocery_color_white,
                        fontSize: textSizeLargeMedium),
                  ),
                )
              ],
            ),
            GestureDetector(
              onTap: widget.onPressed,
              child: Icon(
                widget.rightIcon,
                color: grocery_color_white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    return null;
  }
}

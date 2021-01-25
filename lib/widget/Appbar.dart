import 'dart:ui';

import 'package:bakraw/utils/GroceryColors.dart';
import 'package:bakraw/utils/GroceryConstant.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget {
  final Widget body;
  final String title;
  final Widget bottonbar;
  final Widget navigationDrawer;
  List<Widget> actions = <Widget>[];
  final Widget leading;
  final Widget Tabbar;

  CustomAppBar(
      {this.body,
      this.title,
      this.bottonbar,
      this.navigationDrawer,
      this.actions,
      this.leading,
      this.Tabbar});

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grocery_app_background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              widget.navigationDrawer,
              Image.asset('images/Bakraw.png',height: 25,width: 25,fit: BoxFit.contain,)
            ],
          ),
        ),
        bottom: widget.Tabbar,
        backgroundColor: grocery_colorPrimary,
        actions: widget.actions,
        leading: widget.leading,
      ),
      drawer: widget.navigationDrawer,
      body: widget.body,
    );
  }
}

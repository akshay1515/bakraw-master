import 'package:bakraw/utils/GroceryColors.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Terms extends StatefulWidget {
  static String tag = '/TermsandCondition';
  @override
  _TermsState createState() => _TermsState();
}

class _TermsState extends State<Terms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: grocery_color_white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: Text(
          'Terms and Conditions',
          style: TextStyle(color: grocery_color_white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: WebView(
          initialUrl:
              'https://shop.himalayangoatmeat.com/apis/get-page-content.php?page=terms-and-conditions',
        ),
      ),
    );
  }

  @override
  void initState() {
    WebView.platform = SurfaceAndroidWebView();
  }
}

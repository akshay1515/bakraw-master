import 'package:bakraw/utils/GroceryColors.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Privacy extends StatefulWidget {
  @override
  _PrivacyState createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
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
          'GoatMeat',
          style: TextStyle(color: grocery_color_white),
        ),
      ),
      body: WebView(
        initialUrl:
            'https://shop.himalayangoatmeat.com/apis/get-page-content.php?page=privacy-policy',
      ),
    );
  }

  @override
  void initState() {
    WebView.platform = SurfaceAndroidWebView();
  }
}

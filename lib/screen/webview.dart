import 'package:bakraw/utils/GroceryColors.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ContentDisplay extends StatefulWidget {
  static String tag = '/ContactUs';
  @override
  _ContentDisplayState createState() => _ContentDisplayState();
}

class _ContentDisplayState extends State<ContentDisplay> {
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
          'Contact Us',
          style: TextStyle(color: grocery_color_white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: WebView(
          initialUrl:
              'https://shop.himalayangoatmeat.com/apis/get-page-content.php?page=contact-us',
        ),
      ),
    );
  }

  @override
  void initState() {
    WebView.platform = SurfaceAndroidWebView();
  }
}

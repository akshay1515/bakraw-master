import 'package:bakraw/utils/GroceryColors.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AboutUs extends StatefulWidget {
  static String tag = '/Aboutus';
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
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
          'About Us',
          style: TextStyle(color: grocery_color_white),
        ),
      ),
      body: WebView(
        initialUrl:
            'https://shop.himalayangoatmeat.com/apis/get-page-content.php?page=about-us',
      ),
    );
  }

  @override
  void initState() {
    WebView.platform = SurfaceAndroidWebView();
  }
}

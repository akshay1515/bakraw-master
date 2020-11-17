import 'package:bakraw/GlobalWidget/GlobalWidget.dart';
import 'package:bakraw/provider/previousorderprovider.dart';
import 'package:bakraw/screen/productdetail.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:bakraw/utils/GroceryConstant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreviousOrder extends StatefulWidget {
  @override
  _PreviousOrderState createState() => _PreviousOrderState();
}

class _PreviousOrderState extends State<PreviousOrder> {
  String userid = '', email = '', apikey = '';
  var isLoading = true;

  Future<String> getUserInfo() async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    if (prefs != null) {
      setState(() {
        email = prefs.getString('email');
        apikey = prefs.getString('apikey');
        userid = prefs.getString('id');
      });
    }
    return email;
  }

  @override
  Widget build(BuildContext context) {
    final flash = Provider.of<PreviousOrderProvider>(context);
    final flashsale = flash.items;
    return flashsale.length > 0
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: spacing_standard_new,
                    left: spacing_standard_new,
                    right: spacing_standard_new,
                    bottom: spacing_standard),
                child: Text(
                  'Previously Ordered',
                  style: TextStyle(
                      fontFamily: fontMedium,
                      fontSize: textSizeLargeMedium,
                      color: Colors.grey.shade700),
                ),
              ),
              Container(
                height: 200,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: ListView.builder(
                    itemCount: flashsale[0].data.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (ctx, index) {
                      return FlashsaleItem(
                        id: flashsale[0].data[index].productId,
                        image: flashsale[0].data[index].images[0],
                        weight: flashsale[0].data[index].inStock,
                        price: flashsale[0].data[index].price,
                        name: flashsale[0].data[index].name,
                      );
                    },
                  ),
                ),
              ),
            ],
          )
        : Container();
  }

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  @override
  void didChangeDependencies() {
    if (isLoading) {
      (Provider.of<PreviousOrderProvider>(context, listen: false)
          .getFlashSaleProduct(apikey, userid, email));
    }
  }
}

class FlashsaleItem extends StatelessWidget {
  final String image;
  final String name;
  final String price;
  final String weight;
  final String id;

  FlashsaleItem({this.image, this.name, this.price, this.weight, this.id});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(GroceryProductDescription.tag,
            arguments: {'prodid': id, 'names': name});
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.38,
        height: MediaQuery.of(context).size.height * 0.25,
        decoration: boxDecoration(
            showShadow: true, radius: 10.0, bgColor: grocery_color_white),
        margin: EdgeInsets.only(left: 16, bottom: 16),
        padding: EdgeInsets.all(spacing_middle),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 4),
            Align(
              alignment: Alignment.center,
              child: CachedNetworkImage(
                placeholder: placeholderWidgetFn(),
                imageUrl: image,
                fit: BoxFit.fill,
                height: width * 0.25,
                width: width * 0.27,
              ),
            ),
            SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.only(left: 4, right: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Center(
                    child: text(name,
                        fontFamily: fontMedium,
                        fontSize: 12.0,
                        textColor: grocery_textColorPrimary),
                  ),
                  text('₹ ${double.parse(price).toStringAsFixed(2)}'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

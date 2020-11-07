import 'package:bakraw/GlobalWidget/GlobalWidget.dart';
import 'package:bakraw/provider/relatedproductprovider.dart';
import 'package:bakraw/screen/productdetail.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:bakraw/utils/GroceryConstant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RelatedProduct extends StatefulWidget {
  @override
  _RelatedProductState createState() => _RelatedProductState();
}

class _RelatedProductState extends State<RelatedProduct> {
  var isLoading = true;
  var flash;
  var flashsale;

  @override
  Widget build(BuildContext context) {
    flash = Provider.of<RelatedProductProvier>(context, listen: false);
    flashsale = flash.items;

    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            height: MediaQuery.of(context).size.height * 0.33,
            child: ListView.builder(
              itemCount: flashsale[0].data.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, index) {
                return FlashsaleItem(
                  id: flashsale[0].data[index].productId,
                  image: flashsale[0].data[0].images[0],
                  name: flashsale[0].data[0].name,
                  price: flashsale[0].data[0].price,
                  weight: flashsale[0].data[0].qty,
                );
              },
            ),
          );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (isLoading) {
      (Provider.of<RelatedProductProvier>(context, listen: false)
              .getRelatedProducts(flashsale))
          .then((value) {
        setState(() {
          isLoading = false;
        });
      });
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
        height: MediaQuery.of(context).size.height * 0.30,
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

import 'package:bakraw/GlobalWidget/GlobalWidget.dart';
import 'package:bakraw/provider/flashsaleprovider.dart';
import 'package:bakraw/screen/productdetail.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:bakraw/utils/GroceryConstant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class FlashSale extends StatefulWidget {
  @override
  _FlashSaleState createState() => _FlashSaleState();
}

class _FlashSaleState extends State<FlashSale> {
  var isLoading = true;
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final flash = Provider.of<FlashSaleProvider>(context,listen: false);
    final flashsale = flash.items;
    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            height: 215,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: flashsale[0].data[0].products.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, index) {
                return FlashsaleItem(
                  id: flashsale[0].data[0].products[index].productId,
                  image: flashsale[0].data[0].products[index].images[0],
                  name: flashsale[0].data[0].products[index].name,
                  price: flashsale[0].data[0].products[index].price,
                  weight: flashsale[0].data[0].products[index].qty,
                );
              },
            ),
          );
  }

  @override
  void didChangeDependencies() {
    if (isLoading) {
      (Provider.of<FlashSaleProvider>(context, listen: false)
              .getFlashSaleProduct())
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
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(GroceryProductDescription.tag,
            arguments: {'prodid': id, 'names': name});
      },
      child: Banner(
        location: BannerLocation.topEnd,
        message: 'Sale',
        color: Colors.red.shade900,
        child: Container(
          width: 175,
          height: 270,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black45,blurRadius: 5,spreadRadius: 2),
            ],
            borderRadius: BorderRadius.vertical(top: Radius.circular(5))
          ),
          margin: EdgeInsets.only(left: 16, bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
                child: CachedNetworkImage(
                  placeholder: placeholderWidgetFn(),
                  imageUrl: image,
                  fit: BoxFit.cover,
                  height: 125,
                  width: double.infinity,
                ),
              ),
              SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SmoothStarRating(
                      color: Colors.amber.shade500,
                      allowHalfRating: true,
                      isReadOnly: true,
                      starCount: 5,
                      rating: 5,
                      size: 17,
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 1),
                        child: Text('(${6})',style: TextStyle(fontSize: 10),) ,
                    )
                  ],
                ),
              ),
              SizedBox(height: 4),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(name),
              ),
              SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.only(left:8,right: 8),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(
                      color: Colors.grey.shade300,
                      width: 1
                    ))
                  ),
                ),
              ),
              SizedBox(height: 4),
              Container(
                margin: EdgeInsets.only(top: 4),
                child: Row(
                  children: [
                    Container(
                      width: 7,
                      height: 14,
                      decoration: BoxDecoration(
                        color: Colors.green.shade700,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(25),
                          topRight: Radius.circular(25),
                        )
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        '₹ ${double.parse(price).toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Colors.green.shade700,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

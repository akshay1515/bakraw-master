import 'package:bakraw/GlobalWidget/GlobalWidget.dart';
import 'package:bakraw/model/PreviousOrderModel.dart';
import 'package:bakraw/provider/bestsellerprovider.dart';
import 'package:bakraw/screen/newui/newproductdetail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class BestSelling extends StatefulWidget {
  @override
  _BestSellingState createState() => _BestSellingState();
}

class _BestSellingState extends State<BestSelling> {
  String userid = '', email = '', apikey = '';
  Future<PreviousOrderProduct> myfuture;

  void getfuture(BuildContext context) async {
    myfuture = Provider.of<BestSellerProvider>(context, listen: false)
        .getBestSellingProducts();
  }

  @override
  void initState() {
    super.initState();
    getfuture(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: myfuture,
      builder: (context, AsyncSnapshot<PreviousOrderProduct> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          if (snapshot.data.data.length > 0) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 221,
                  child: ListView.builder(
                    itemCount: snapshot.data.data.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (ctx, index) {
                      return BestSellingItem(
                        id: snapshot.data.data[index].productId,
                        image: snapshot.data.data[index].images[0],
                        weight: snapshot.data.data[index].inStock,
                        price: snapshot.data.data[index].price,
                        name: snapshot.data.data[index].name,
                        isSaleavaliable:
                            snapshot.data.data[index].isProductIsInSale,
                        productsaledetails:
                            snapshot.data.data[index].isProductIsInSale
                                ? snapshot.data.data[index].productSaleDetails
                                : null,
                        productRating: snapshot.data.data[index].productRating,
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return Center(child: Container());
          }
        } else {
          return Container(
            color: Colors.green.shade50,
            height: 220,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

class BestSellingItem extends StatelessWidget {
  final String image;
  final String name;
  final String price;
  final String weight;
  final String id;
  final bool isSaleavaliable;
  final ProductSaleDetails productsaledetails;
  final ProductRating productRating;

  BestSellingItem(
      {this.image,
      this.name,
      this.price,
      this.weight,
      this.id,
      this.isSaleavaliable,
      this.productsaledetails,
      this.productRating});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(NewProductDetails.tag,
              arguments: {'prodid': id, 'names': name});
        },
        child: isSaleavaliable
            ? Banner(
                location: BannerLocation.topEnd,
                message: 'Sale',
                color: Colors.red.shade900,
                child: Container(
                  width: 175,
                  height: 270,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black45,
                            blurRadius: 5,
                            spreadRadius: 2),
                      ],
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(5))),
                  margin: EdgeInsets.only(left: 16, bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(5)),
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
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SmoothStarRating(
                              color: Colors.amber.shade500,
                              allowHalfRating: true,
                              isReadOnly: true,
                              starCount: 5,
                              rating: double.parse(
                                  productRating.avgRating.toString()),
                              size: 17,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 1),
                              child: Text(
                                '(${productRating.totalReviewsCount})',
                                style: TextStyle(fontSize: 10),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 4),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.grey.shade300, width: 1))),
                        ),
                      ),
                      SizedBox(height: 4),
                      Container(
                        margin: EdgeInsets.only(top: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              width: 7,
                              height: 14,
                              decoration: BoxDecoration(
                                  color: Colors.green.shade700,
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(25),
                                    topRight: Radius.circular(25),
                                  )),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                '₹ ${double.parse(productsaledetails.productSalePrice).toStringAsFixed(2)}',
                                style: TextStyle(
                                  color: Colors.green.shade700,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 5),
                              child: Text(
                                '₹ ${double.parse(price).toStringAsFixed(2)}',
                                style: TextStyle(
                                    fontSize: 8,
                                    color: Colors.red.shade700,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.lineThrough),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            : Container(
                width: 175,
                height: 270,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black45, blurRadius: 5),
                    ],
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(5))),
                margin: EdgeInsets.only(left: 16, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(5)),
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
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SmoothStarRating(
                            color: Colors.amber.shade500,
                            allowHalfRating: true,
                            isReadOnly: true,
                            starCount: 5,
                            rating: double.parse(
                                productRating.avgRating.toString()),
                            size: 17,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 1),
                            child: Text(
                              '(${productRating.totalReviewsCount})',
                              style: TextStyle(fontSize: 10),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 4),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.grey.shade300, width: 1))),
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
                                )),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              '₹ ${double.parse(price).toStringAsFixed(2)}',
                              style: TextStyle(
                                  color: Colors.green.shade700,
                                  fontWeight: FontWeight.bold),
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

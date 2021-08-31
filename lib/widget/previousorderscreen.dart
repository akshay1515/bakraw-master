import 'package:bakraw/GlobalWidget/GlobalWidget.dart';
import 'package:bakraw/model/PreviousOrderModel.dart';
import 'package:bakraw/provider/previousorderprovider.dart';
import 'package:bakraw/screen/newui/newproductdetail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class PreviousOrder extends StatefulWidget {
  @override
  _PreviousOrderState createState() => _PreviousOrderState();
}

class _PreviousOrderState extends State<PreviousOrder> {
  String userid = '', email = '', apikey = '';
  var isLoading = true;
  Future<PreviousOrderProduct> myfuture;

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
    return userid;
  }

  void getfuture() async {
    myfuture = Provider.of<PreviousOrderProvider>(context, listen: false)
        .getFlashSaleProduct(
            'UpRnu2a66HOzCg6y6HijyQHExsrjG8s0G', '425', 'akshay2@gmail.com');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: FutureBuilder(
          future: myfuture,
          builder: (context, AsyncSnapshot<PreviousOrderProduct> snapshot) {
            return snapshot.hasData
                ? snapshot.data.data.length > 0
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 215,
                            child: ListView.builder(
                              itemCount: snapshot.data.data.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (ctx, index) {
                                return FlashsaleItem(
                                  id: snapshot.data.data[index].productId,
                                  image: snapshot.data.data[index].images[0],
                                  weight: snapshot.data.data[index].inStock,
                                  price: snapshot.data.data[index].price,
                                  name: snapshot.data.data[index].name,
                                  isSaleavaliable: snapshot
                                      .data.data[index].isProductIsInSale,
                                  productRating:
                                      snapshot.data.data[index].productRating,
                                );
                              },
                            ),
                          ),
                        ],
                      )
                    : Container()
                : Container(
                    height: 215,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
          }),
    );
  }

  @override
  void initState() {
    super.initState();
    getUserInfo().then((value) {
      getfuture();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isLoading) {
      setState(() {
        isLoading = false;
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
  final bool isSaleavaliable;
  final ProductRating productRating;

  FlashsaleItem(
      {this.image,
      this.name,
      this.price,
      this.weight,
      this.id,
      this.isSaleavaliable,
      this.productRating});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                margin:
                    EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
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
                            rating: double.parse(productRating.avgRating),
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
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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
            )
          : Container(
              width: 175,
              height: 270,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.black45, blurRadius: 5),
                  ],
                  borderRadius: BorderRadius.vertical(top: Radius.circular(5))),
              margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
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
                          rating: 5,
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
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
    );
  }
}

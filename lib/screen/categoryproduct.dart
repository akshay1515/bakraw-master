import 'package:bakraw/GlobalWidget/GlobalWidget.dart';
import 'package:bakraw/model/categoryproductmodel.dart';
import 'package:bakraw/provider/categoryproductprovider.dart';
import 'package:bakraw/provider/categoryprovider.dart';
import 'package:bakraw/screen/productdetail.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:bakraw/utils/GroceryConstant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class GrocerySubCategoryList extends StatefulWidget {
  static String tag = '/GrocerySubCategoryList';

  @override
  GrocerySubCategoryListState createState() => GrocerySubCategoryListState();
}

class GrocerySubCategoryListState extends State<GrocerySubCategoryList> {
  Future<CategoryProduct> myfuture;

  @override
  void initState() {
    super.initState();
    getfuture();
  }

  void getfuture() async {
    myfuture = Provider.of<CategoryProductProvider>(context, listen: false)
        .getProductBycategory(
            Provider.of<CategoryProvider>(context, listen: false).categoryid);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return FutureBuilder(
        future: myfuture,
        builder: (context, AsyncSnapshot<CategoryProduct> snapshot) {
          return snapshot.hasData
              ? snapshot.data.data.length > 0
                  ? Container(
                      height: MediaQuery.of(context).size.height - 350,
                      padding: EdgeInsets.only(bottom: 50),
                      color: Colors.green.shade50,
                      child: Container(
                          margin: EdgeInsets.only(
                            left: spacing_middle,
                            right: spacing_middle,
                          ),
                          child: GridView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 2,
                                    mainAxisSpacing: 2,
                                    childAspectRatio: 0.85),
                            itemCount: snapshot.data.data.length,
                            itemBuilder: (_, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      GroceryProductDescription.tag,
                                      arguments: {
                                        'prodid':
                                            snapshot.data.data[index].productId,
                                        'names': snapshot.data.data[index].name
                                      });
                                },
                                child: snapshot
                                        .data.data[index].isProductIsInSale
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
                                                  BorderRadius.vertical(
                                                      top: Radius.circular(5))),
                                          margin: EdgeInsets.only(bottom: 16),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                        top:
                                                            Radius.circular(5)),
                                                child: CachedNetworkImage(
                                                  placeholder:
                                                      placeholderWidgetFn(),
                                                  imageUrl: snapshot.data
                                                      .data[index].images[0],
                                                  fit: BoxFit.cover,
                                                  height: 125,
                                                  width: double.infinity,
                                                ),
                                              ),
                                              SizedBox(height: 4),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    SmoothStarRating(
                                                      color:
                                                          Colors.amber.shade500,
                                                      allowHalfRating: true,
                                                      isReadOnly: true,
                                                      starCount: 5,
                                                      rating: double.parse('${snapshot.data.data[index].productRating.avgRating}'),
                                                      size: 17,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 1),
                                                      child: Text(
                                                        '(${snapshot.data.data[index].productRating.totalReviewsCount})',
                                                        style: TextStyle(
                                                            fontSize: 10),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 4),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8),
                                                child: Text(
                                                  snapshot
                                                      .data.data[index].name,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              SizedBox(height: 4),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8, right: 8),
                                                child: Container(
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                      border: Border(
                                                          bottom: BorderSide(
                                                              color: Colors.grey
                                                                  .shade300,
                                                              width: 1))),
                                                ),
                                              ),
                                              SizedBox(height: 4),
                                              Container(
                                                margin: EdgeInsets.only(top: 4),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                      width: 7,
                                                      height: 14,
                                                      decoration: BoxDecoration(
                                                          color: Colors
                                                              .green.shade700,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            bottomRight:
                                                                Radius.circular(
                                                                    25),
                                                            topRight:
                                                                Radius.circular(
                                                                    25),
                                                          )),
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          left: 10),
                                                      child: Text(
                                                        '₹ ${double.parse(snapshot.data.data[index].productSaleDetails.productSalePrice).toStringAsFixed(2)}',
                                                        style: TextStyle(
                                                          color: Colors
                                                              .green.shade700,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          left: 5),
                                                      child: Text(
                                                        '₹ ${double.parse(snapshot.data.data[index].price).toStringAsFixed(2)}',
                                                        style: TextStyle(
                                                            fontSize: 8,
                                                            color: Colors
                                                                .red.shade700,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough),
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
                                              BoxShadow(
                                                  color: Colors.black45,
                                                  blurRadius: 5),
                                            ],
                                            borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(5))),
                                        margin: EdgeInsets.only(
                                            left: 16, bottom: 16),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                      top: Radius.circular(5)),
                                              child: CachedNetworkImage(
                                                placeholder:
                                                    placeholderWidgetFn(),
                                                imageUrl: snapshot
                                                    .data.data[index].images[0],
                                                fit: BoxFit.cover,
                                                height: 125,
                                                width: double.infinity,
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  SmoothStarRating(
                                                    color:
                                                        Colors.amber.shade500,
                                                    allowHalfRating: true,
                                                    isReadOnly: true,
                                                    starCount: 5,
                                                    rating: double.parse(snapshot.data.data[index].productRating.avgRating),
                                                    size: 17,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 1),
                                                    child: Text(
                                                      '(${6})',
                                                      style: TextStyle(
                                                          fontSize: 10),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8),
                                              child: Text(
                                                  snapshot
                                                      .data.data[index].name,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ),
                                            SizedBox(height: 4),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8, right: 8),
                                              child: Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            color: Colors
                                                                .grey.shade300,
                                                            width: 1))),
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
                                                        color: Colors
                                                            .green.shade700,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          bottomRight:
                                                              Radius.circular(
                                                                  25),
                                                          topRight:
                                                              Radius.circular(
                                                                  25),
                                                        )),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        left: 10),
                                                    child: Text(
                                                      '₹ ${double.parse(snapshot.data.data[index].price).toStringAsFixed(2)}',
                                                      style: TextStyle(
                                                          color: Colors
                                                              .green.shade700,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                              );
                            },
                          )),
                    )
                  : Container(
                      color: Colors.green.shade50,
                      height: MediaQuery.of(context).size.height - 350,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.inbox_rounded,
                            color: grocery_colorPrimary,
                            size: 150,
                          ),
                          Text(
                            'No product yet in this category',
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    )
              : Container(
                  height: MediaQuery.of(context).size.height - 350,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.green.shade50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      Text(
                        'Loading products',
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                );
        });
  }
}

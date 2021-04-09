import 'package:bakraw/GlobalWidget/GlobalWidget.dart';
import 'package:bakraw/model/productmodel.dart';
import 'package:bakraw/provider/markfavouriteprovider.dart';
import 'package:bakraw/provider/productdetailprovider.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:bakraw/utils/GroceryConstant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../../databasehelper.dart';
import '../useraddresslist.dart';

class NewProductDetails extends StatefulWidget {
  static String tag = '/ProductDescription';

  @override
  _NewProductDetailsState createState() => _NewProductDetailsState();
}

class _NewProductDetailsState extends State<NewProductDetails> {
  String email = '';
  String apikey = '';
  String userid = '';
  String selectedvalue;
  int count = 1;
  var prodid;
  bool isFavourite = false;
  Future<ProductModel> myfuture;
  bool init = false;

  bool isLoading = true;
  int itemcount = 1;
  var sOptionPrice;
  var option;

  /* @override
  void dispose() {
    this.dispose();
  }*/

  void getMyFuture() async {
    myfuture = Provider.of<ProductProvider>(context, listen: false)
        .getProductDetails(prodid['prodid']);
  }

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

  selecedOption(var val) {
    option = val;
    sOptionPrice = val[0].price;
  }

  @override
  void initState() {
    getUserInfo().then((value) {
      setState(() {
        init = true;
      });
    });
    super.initState();
  }

  void favouriteMark() {
    Provider.of<ProductProvider>(context, listen: false)
        .isFavourite(userid, apikey, prodid['prodid'])
        .then((value) {
      if (value.data.firstWhere(
              (element) => element.productId == (prodid['prodid'])) !=
          null) {
        setState(() {
          isFavourite = true;
        });
      }
    });
  }

  Widget setProductFavourite() {
    if ((userid != null) && isFavourite) {
      return Icon(Icons.favorite_outlined, color: Colors.redAccent.shade400);
    } else if ((userid != null) && !isFavourite) {
      return Icon(Icons.favorite_outline, color: grocery_icon_color); /**/
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    prodid = ModalRoute.of(context).settings.arguments as Map;
    getMyFuture();
    if (init) {
      favouriteMark();

      setState(() {
        init = false;
      });
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: grocery_colorPrimary,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(
          prodid['names'],
          style: TextStyle(
              color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
            icon: setProductFavourite(),
            onPressed: () {
              Provider.of<MarkFavourite>(context, listen: false)
                  .markFavourites(userid, prodid['prodid'], apikey)
                  .then((value) {
                setState(() {
                  isFavourite = !isFavourite;
                });
              });
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: myfuture,
        builder: (context, AsyncSnapshot<ProductModel> snapshot) {
          return snapshot.hasData
              ? Stack(children: [
                  SingleChildScrollView(
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(25),
                              bottomLeft: Radius.circular(25)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    top: 230, left: 20, right: 20),
                                transform:
                                    Matrix4.translationValues(0.0, -10, 0.0),
                                height: 250,
                                width: MediaQuery.of(context).size.width,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(25),
                                          bottomLeft: Radius.circular(25))),
                                  elevation: 5,
                                  color: Color.fromRGBO(226, 244, 244, 1),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 13),
                                        child: Text(
                                          snapshot.data.data.name.toUpperCase(),
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.normal,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 3),
                                        child: SmoothStarRating(
                                          color: Colors.amber.shade500,
                                          size: 17,
                                          starCount: 5,
                                          isReadOnly: true,
                                          rating: double.parse(snapshot.data
                                              .data.productRating.avgRating),
                                          allowHalfRating: true,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 10, top: 10, right: 10),
                                        width: 100,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              height: 20,
                                              width: 10,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomRight:
                                                              Radius.circular(
                                                                  50),
                                                          topRight:
                                                              Radius.circular(
                                                                  50)),
                                                  color: Colors.green.shade500),
                                            ),
                                            Text(
                                              '₹${option == null ? double.parse(snapshot.data.data.price).toStringAsFixed(2) : (double.parse(snapshot.data.data.price) + double.parse(option[0].price)).toStringAsFixed(2)}',
                                              style: TextStyle(
                                                  color: Colors.green.shade500,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 17),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 20, top: 10, right: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10),
                                              child: Text(
                                                'Pack Size',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 17),
                                              ),
                                            ),
                                            Container(
                                              height: 40,
                                              child: DecoratedBox(
                                                decoration: ShapeDecoration(
                                                    color:
                                                        Colors.green.shade700,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30))),
                                                child:
                                                    DropdownButtonHideUnderline(
                                                        child: ButtonTheme(
                                                  alignedDropdown: true,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    child:
                                                        DropdownButton<String>(
                                                      dropdownColor:
                                                          Colors.green.shade700,
                                                      value: selectedvalue,
                                                      icon: Icon(
                                                        Icons
                                                            .arrow_drop_down_rounded,
                                                        color: Colors.white,
                                                        size: 30,
                                                      ),
                                                      items: snapshot
                                                          .data
                                                          .data
                                                          .productOptions[0]
                                                          .options
                                                          .map((item) {
                                                        return DropdownMenuItem(
                                                          child: Text(
                                                            item.label,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          value: item
                                                              .optionValueId,
                                                        );
                                                      }).toList(),
                                                      iconSize: 20,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                      hint: Text(
                                                        'Select',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      onChanged: (value) {
                                                        option = snapshot
                                                            .data
                                                            .data
                                                            .productOptions[0]
                                                            .options
                                                            .where((element) {
                                                          return element
                                                              .optionValueId
                                                              .contains(value);
                                                        }).toList();
                                                        setState(() {
                                                          selecedOption(option);
                                                          selectedvalue = value;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                )),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  itemcount > 1
                                                      ? itemcount--
                                                      : Fluttertoast.showToast(
                                                          msg:
                                                              'Minimum 1 Quantity of item is required',
                                                          toastLength: Toast
                                                              .LENGTH_SHORT);
                                                });
                                              },
                                              child: Container(
                                                height: 30,
                                                width: 30,
                                                decoration: BoxDecoration(
                                                    color:
                                                        Colors.green.shade700,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            17)),
                                                child: Center(
                                                  child: Icon(Icons.remove,
                                                      size: 20,
                                                      color:
                                                          grocery_color_white),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                                width: spacing_standard_new),
                                            text(itemcount.toString(),
                                                fontFamily: fontMedium,
                                                fontSize: textSizeNormal,
                                                isCentered: true),
                                            SizedBox(
                                                width: spacing_standard_new),
                                            GestureDetector(
                                              onTap: () {
                                                /* model.isProductIsInSale == true &&
                                            model.productSaleDetails
                                                .isProductOutOfStock ==
                                                true
                                            ? Fluttertoast.showToast(
                                            msg:
                                            'Sorry We Are Out Of Stock',
                                            toastLength: Toast.LENGTH_SHORT)
                                            :*/
                                                setState(() {
                                                  itemcount++;
                                                });
                                              },
                                              child: Container(
                                                height: 30,
                                                width: 30,
                                                decoration: BoxDecoration(
                                                    color:
                                                        Colors.green.shade700,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            17)),
                                                child: Center(
                                                  child: Icon(Icons.add,
                                                      size: 20,
                                                      color:
                                                          grocery_color_white),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, -8.0, 0.0),
                                margin: EdgeInsets.only(top: 30, bottom: 2),
                                child: Text(
                                  'Description'.toUpperCase(),
                                  style: TextStyle(
                                      color: Colors.green.shade500,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17),
                                ),
                              ),
                              Container(
                                  child: Container(
                                transform:
                                    Matrix4.translationValues(0.0, -10, 0.0),
                                decoration: BoxDecoration(
                                    border: Border(
                                  bottom: BorderSide(
                                    color: Colors.green.shade500,
                                    style: BorderStyle.solid,
                                    width: 3,
                                  ),
                                )),
                                width: 150,
                              )),
                              Container(
                                  margin: EdgeInsets.only(top: 15),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.green.shade500,
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(50),
                                            bottomRight: Radius.circular(50))),
                                    width: 20,
                                    height: 10,
                                    transform: Matrix4.translationValues(
                                        0.0, -25, 0.0),
                                  )),
                              Container(
                                  transform:
                                      Matrix4.translationValues(0.0, -18, 0.0),
                                  margin: EdgeInsets.only(
                                      left: 8, right: 8, bottom: 50),
                                  child: Html(
                                      data: snapshot.data.data.description)),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: CarouselSlider(
                                options: CarouselOptions(
                                    enableInfiniteScroll: true,
                                    initialPage: 0,
                                    autoPlay: true,
                                    height: 250,
                                    viewportFraction: 1,
                                    autoPlayInterval: Duration(seconds: 2)),
                                items: snapshot.data.data.images.map((e) {
                                  return Builder(builder: (BuildContext ctx) {
                                    return Stack(
                                      children: [
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: CachedNetworkImage(
                                            imageUrl: e.path,
                                            width: double.infinity,
                                            height: 250,
                                            fit: BoxFit.cover,
                                            placeholder: placeholderWidgetFn(),
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          color: Colors.black54,
                                          margin: EdgeInsets.only(top: 200),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                            top: 212,
                                            bottom: 17,
                                          ),
                                          alignment: Alignment.center,
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemCount: snapshot
                                                  .data.data.images.length,
                                              itemBuilder: (_, index) {
                                                return Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 5),
                                                  width: snapshot
                                                              .data.data.images
                                                              .indexOf(e) ==
                                                          index
                                                      ? 24
                                                      : 12,
                                                  decoration: BoxDecoration(
                                                      color: snapshot.data.data
                                                                  .images
                                                                  .indexOf(e) ==
                                                              index
                                                          ? grocery_colorPrimary_light
                                                          : Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50)),
                                                );
                                              }),
                                        )
                                      ],
                                    );
                                  });
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      left: 0,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 75,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(226, 244, 244, 1),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                                onPressed: () async {
                                  if (option != null) {
                                    int i = await DatabaseHelper.instance
                                        .addtoCart({
                                      DatabaseHelper.productid:
                                          snapshot.data.data.productId,
                                      DatabaseHelper.optionid: snapshot
                                          .data.data.productOptions[0].optionId,
                                      DatabaseHelper.optionname: snapshot
                                          .data.data.productOptions[0].name,
                                      DatabaseHelper.optionvalueid:
                                          option[0].optionValueId,
                                      DatabaseHelper.optionlable:
                                          option[0].label,
                                      DatabaseHelper.productpriceincreased:
                                          option[0].increaseProductPriceBy,
                                      DatabaseHelper.quantity:
                                          itemcount.toString(),
                                      DatabaseHelper.price: (double.parse(
                                                  snapshot.data.data.price) +
                                              double.parse(option[0].price))
                                          .toStringAsFixed(2)
                                    });
                                    i > 0 ? count = 1 : count = count;
                                    Fluttertoast.showToast(
                                        msg: i > 0
                                            ? "Product Added to Cart"
                                            : 'Product Already Exist In Cart');
                                    setState(() {
                                      itemcount = 1;
                                    });
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: 'Please Select Pack Size');
                                  }
                                },
                                child: Container(
                                  height: 50,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      color: option != null
                                          ? Colors.green.shade700
                                          : Colors.grey.shade500,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Center(
                                    child: Text(
                                      'Add To Cart'.toUpperCase(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                )),
                            TextButton(
                                onPressed: () async {
                                  if (option != null) {
                                    int i = await DatabaseHelper.instance
                                        .addtoCart({
                                      DatabaseHelper.productid:
                                          snapshot.data.data.productId,
                                      DatabaseHelper.optionid: snapshot
                                          .data.data.productOptions[0].optionId,
                                      DatabaseHelper.optionname: snapshot
                                          .data.data.productOptions[0].name,
                                      DatabaseHelper.optionvalueid:
                                          option[0].optionValueId,
                                      DatabaseHelper.optionlable:
                                          option[0].label,
                                      DatabaseHelper.productpriceincreased:
                                          option[0].increaseProductPriceBy,
                                      DatabaseHelper.quantity:
                                          itemcount.toString(),
                                      DatabaseHelper.price: (double.parse(
                                                  snapshot.data.data.price) +
                                              double.parse(option[0].price))
                                          .toStringAsFixed(2)
                                    });
                                    i > 0 ? count = 1 : count = count;
                                    Fluttertoast.showToast(
                                        msg: i > 0
                                            ? "Product Added to Cart"
                                            : 'Product Already Exist In Cart');
                                    setState(() {
                                      itemcount = 1;
                                    });
                                    Navigator.of(context).pushNamed(
                                        UserAddressManager.tag,
                                        arguments: {'isnav': true});
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: 'Please Select Pack Size');
                                  }
                                },
                                child: Container(
                                  height: 50,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      color: option != null
                                          ? Colors.green.shade700
                                          : Colors.grey.shade500,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Center(
                                    child: Text(
                                      'Checkout'.toUpperCase(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ))
                ])
              : Container(
                  color: Colors.white,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
        },
      ),
    );
  }
}

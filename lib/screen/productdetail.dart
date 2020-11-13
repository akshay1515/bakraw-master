import 'package:bakraw/GlobalWidget/GlobalWidget.dart';
import 'package:bakraw/databasehelper.dart';
import 'package:bakraw/model/productmodel.dart';
import 'package:bakraw/provider/markfavouriteprovider.dart';
import 'package:bakraw/provider/productdetailprovider.dart';
import 'package:bakraw/utils/GeoceryStrings.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:bakraw/utils/GroceryConstant.dart';
import 'package:bakraw/utils/GroceryWidget.dart';
import 'package:bakraw/widget/relatedproductitems.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:html/parser.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class GroceryProductDescription extends StatefulWidget {
  static String tag = '/ProductDescription';

  @override
  GroceryProductDescriptionState createState() =>
      GroceryProductDescriptionState();
}

class GroceryProductDescriptionState extends State<GroceryProductDescription> {
  String email = '';
  String apikey = '';
  String userid = '';
  Options optionvalue;
  int count = 1;
  var prodid;
  bool isFavourite = false;

  @override
  void dispose() {
    this.dispose();
    init = true;
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
    return email;
  }

  void favouriteMark() {
    String sample = '';
    Provider.of<ProductProvider>(context, listen: false)
        .isFavourite(userid, apikey, prodid['prodid'])
        .then((value) {
      sample = value.data
          .firstWhere((element) => element.productId == (prodid['prodid']))
          .productId;

      if (sample == prodid['prodid']) {
        setState(() {
          isFavourite = true;
        });
      }
    });
  }

  Widget setProductFavourite() {
    if (!email.isEmptyOrNull && isFavourite) {
      return Icon(Icons.favorite_outlined, color: grocery_color_red);
    } else if (!email.isEmptyOrNull && !isFavourite) {
      return Icon(Icons.favorite_outline, color: grocery_icon_color); /**/
    } else {
      return Container();
    }
  }

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  Data model;
  Options optionlist;
  bool init = true;
  int optioncount = 0;
  List<Options> target = [];
  List<ProductOptions> productoptions = [];
  List<Data> list = [];
  bool isLoading = true;
  int itemcount = 1;
  var specialprice;
  var selectedValue;
  var sOptionPrice;
  var sOptionLable;
  Options option;

  @override
  Widget build(BuildContext context) {
    prodid = ModalRoute.of(context).settings.arguments as Map;
    favouriteMark();
    if (init == true) {
      Provider.of<ProductProvider>(context, listen: false)
          .getProductDetails(prodid['prodid'])
          .then((value) {
        model = Data(
            name: value.data.name,
            images: value.data.images,
            price: value.data.price,
            productId: value.data.productId,
            productOptions: value.data.productOptions,
            sellingPrice: value.data.sellingPrice,
            inStock: value.data.inStock,
            isProductIsInSale: value.data.isProductIsInSale,
            productSaleDetails: value.data.productSaleDetails,
            description: value.data.description);
        model.productOptions.forEach((element) {
          productoptions.add(ProductOptions(
              name: element.name,
              isGlobal: element.isGlobal,
              isRequired: element.isRequired,
              optionId: element.optionId,
              options: element.options));
          element.options.forEach((element) {
            target.add(Options(
                name: element.name,
                increaseProductPriceBy: element.increaseProductPriceBy,
                price: element.price,
                optionValueId: element.optionValueId,
                label: element.label,
                priceType: element.priceType));
          });
        });
        setState(() {
          isLoading = false;
        });
      });
      init = false;
    }

    SelectedRadio(Options val) {
      setState(() {
        option = val;
        selectedValue = val.optionValueId;
        sOptionPrice = val.price;
      });
    }

    String parseHtmlString(String htmlString) {
      final document = parse(htmlString);
      final String parsedString =
          parse(document.body.text).documentElement.text;

      return parsedString;
    }

    String PriceReturn() {
      double defaultprice = 0;
      double price = 0;
      defaultprice = model.isProductIsInSale == false
          ? double.parse(model.price)
          : double.parse(model.productSaleDetails.price);
      if (option == null) {
        setState(() {
          price = defaultprice;
        });
      } else {
        setState(() {
          price = (defaultprice + double.parse(sOptionPrice));
        });
      }
      return price.toString();
    }

    String CancelledPrice() {
      double cancelleddefaultprice = 0;
      double cancelledprice = 0;
      cancelleddefaultprice = double.parse(model.price);
      if (option == null) {
        setState(() {
          cancelledprice = cancelleddefaultprice;
        });
      } else {
        setState(() {
          cancelledprice = (cancelleddefaultprice + double.parse(sOptionPrice));
        });
      }
      return cancelledprice.toString();
    }

    changeStatusColor(grocery_app_background);
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: grocery_app_background,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 60,
                      width: width,
                      margin: EdgeInsets.only(right: spacing_standard_new),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.arrow_back,
                                    color: grocery_icon_color),
                                onPressed: () {
                                  finish(context);
                                },
                              ),
                              text(prodid['names'],
                                  textColor: grocery_textColorPrimary,
                                  fontSize: textSizeLargeMedium,
                                  fontFamily: fontBold),
                            ],
                          ),
                          IconButton(
                              icon: setProductFavourite(),
                              onPressed: () {
                                setState(() {
                                  isLoading = true;
                                });
                                if (isLoading) {
                                  Provider.of<MarkFavourite>(context,
                                          listen: false)
                                      .markFavourites(
                                          userid, prodid['prodid'], apikey)
                                      .then((value) {
                                    setState(() {
                                      isFavourite = !isFavourite;
                                    });
                                    setState(() {
                                      isLoading = false;
                                    });
                                  });
                                }
                              })
                        ],
                      ),
                    ),
                    Stack(
                      children: <Widget>[
                        Container(
                          width: width,
                          padding:
                              EdgeInsets.only(bottom: spacing_standard_new),
                          margin: EdgeInsets.only(
                            top: width * 0.2,
                            left: spacing_standard_new,
                            right: spacing_standard_new,
                          ),
                          decoration: boxDecoration(
                              showShadow: true,
                              radius: 10.0,
                              bgColor: grocery_color_white),
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: width * 0.17),
                              text(model.name,
                                  fontFamily: fontMedium,
                                  fontSize: textSizeLargeMedium),
                              SizedBox(height: spacing_large),
                              text('₹ ${double.parse(CancelledPrice()).toStringAsFixed(2)}',
                                      fontFamily: fontMedium,
                                      lineThrough: true,
                                      fontSize: textSizeLargeMedium)
                                  .visible(model.isProductIsInSale == true
                                      ? true
                                      : false),
                              text(
                                  '₹ ${double.parse(PriceReturn()).toStringAsFixed(2)}',
                                  fontFamily: fontMedium,
                                  fontSize: textSizeLargeMedium),
                              SizedBox(height: spacing_large),
                              Container(
                                child: text('Pack Size',
                                    isCentered: false,
                                    fontFamily: fontMedium,
                                    fontSize: textSizeLargeMedium),
                              ),
                              SizedBox(height: spacing_standard),
                              Container(
                                decoration: BoxDecoration(),
                                height: MediaQuery.of(context).size.width / 6,
                                width: MediaQuery.of(context).size.width,
                                child: Container(
                                    height:
                                        MediaQuery.of(context).size.height / 10,
                                    child: /*RadioListBuilder(optionlist: target)*/
                                        ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: target.length,
                                      itemBuilder: (context, index) {
                                        return SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.3,
                                          child: RadioListTile(
                                              toggleable: false,
                                              controlAffinity:
                                                  ListTileControlAffinity
                                                      .platform,
                                              dense: true,
                                              title: Text(
                                                target[index].label,
                                                style: TextStyle(
                                                    fontFamily: fontMedium,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            23),
                                              ),
                                              value:
                                                  target[index].optionValueId,
                                              groupValue: selectedValue,
                                              activeColor: grocery_color_red,
                                              onChanged: (val) {
                                                setState(() {
                                                  SelectedRadio(Options(
                                                      priceType: target[index]
                                                          .priceType,
                                                      label:
                                                          target[index].label,
                                                      price:
                                                          target[index].price,
                                                      optionValueId: val,
                                                      increaseProductPriceBy:
                                                          target[index]
                                                              .increaseProductPriceBy,
                                                      name:
                                                          target[index].name));
                                                });
                                              }),
                                        );
                                      },
                                    )),
                              ),
                              SizedBox(height: spacing_standard_new),
                              Container(
                                child: Text(parseHtmlString(model.description)),
                              ),
                              SizedBox(height: spacing_standard_new),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(Icons.remove_circle_outline,
                                        size: 35, color: grocery_icon_color),
                                    onPressed: () {
                                      setState(() {
                                        model.isProductIsInSale == true &&
                                                model.productSaleDetails
                                                        .isProductOutOfStock ==
                                                    true
                                            ? Fluttertoast.showToast(
                                                msg:
                                                    'Sorry We Are Out Of Stock',
                                                toastLength: Toast.LENGTH_SHORT)
                                            : itemcount > 1
                                                ? itemcount--
                                                : Fluttertoast.showToast(
                                                    msg:
                                                        'Minimum 1 Quantity of item is required',
                                                    toastLength:
                                                        Toast.LENGTH_SHORT);
                                      });
                                    },
                                  ),
                                  SizedBox(width: spacing_standard_new),
                                  text(itemcount.toString(),
                                      fontFamily: fontMedium,
                                      fontSize: textSizeLarge,
                                      isCentered: true),
                                  SizedBox(width: spacing_standard_new),
                                  IconButton(
                                      icon: Icon(Icons.add_circle_outline,
                                          size: 35, color: grocery_icon_color),
                                      onPressed: () {
                                        model.isProductIsInSale == true &&
                                                model.productSaleDetails
                                                        .isProductOutOfStock ==
                                                    true
                                            ? Fluttertoast.showToast(
                                                msg:
                                                    'Sorry We Are Out Of Stock',
                                                toastLength: Toast.LENGTH_SHORT)
                                            : setState(() {
                                                itemcount++;
                                              });
                                      }),
                                ],
                              ),
                              SizedBox(height: spacing_standard_new),
                              FittedBox(
                                  child: groceryButton(
                                      bgColors: model.isProductIsInSale ==
                                                  true &&
                                              model.productSaleDetails
                                                      .isProductOutOfStock ==
                                                  true
                                          ? Colors.grey.shade300
                                          : grocery_colorPrimary,
                                      onPressed: () async {
                                        if (option == null) {
                                          Fluttertoast.showToast(
                                              msg: 'Please select pack Size');
                                        } else {
                                          if (model.isProductIsInSale ==
                                              false) {
                                            int i = await DatabaseHelper
                                                .instance
                                                .addtoCart({
                                              DatabaseHelper.productid:
                                                  model.productId,
                                              DatabaseHelper.optionid:
                                                  productoptions[0].optionId,
                                              DatabaseHelper.optionname:
                                                  productoptions[0].name,
                                              DatabaseHelper.optionvalueid:
                                                  option.optionValueId,
                                              DatabaseHelper.optionlable:
                                                  option.label,
                                              DatabaseHelper
                                                      .productpriceincreased:
                                                  option.increaseProductPriceBy,
                                              DatabaseHelper.quantity:
                                                  itemcount.toString(),
                                              DatabaseHelper.price:
                                                  PriceReturn()
                                            });
                                            i > 0 ? count = 1 : count = count;
                                            Fluttertoast.showToast(
                                                msg: i > 0
                                                    ? "Product Added to Cart"
                                                    : 'Product Already Exist In Cart');
                                            setState(() {
                                              itemcount = 1;
                                            });
                                          } else if (model.isProductIsInSale ==
                                                  true &&
                                              model.productSaleDetails
                                                      .isProductOutOfStock ==
                                                  false) {
                                            int i = await DatabaseHelper
                                                .instance
                                                .addtoCart({
                                              DatabaseHelper.productid:
                                                  model.productId,
                                              DatabaseHelper.optionid:
                                                  productoptions[0].optionId,
                                              DatabaseHelper.optionname:
                                                  productoptions[0].name,
                                              DatabaseHelper.optionvalueid:
                                                  option.optionValueId,
                                              DatabaseHelper.optionlable:
                                                  option.label,
                                              DatabaseHelper
                                                      .productpriceincreased:
                                                  option.increaseProductPriceBy,
                                              DatabaseHelper.quantity:
                                                  itemcount.toString(),
                                              DatabaseHelper.price:
                                                  PriceReturn()
                                            });
                                            i > 0 ? count = 1 : count = count;
                                            Fluttertoast.showToast(
                                                msg: i > 0
                                                    ? "Product Added to Cart"
                                                    : 'Product Already Exist In Cart');
                                            setState(() {
                                              itemcount = 1;
                                            });
                                          } else {}
                                        }
                                      },
                                      textContent: model.isProductIsInSale ==
                                                  true &&
                                              model.productSaleDetails
                                                      .isProductOutOfStock ==
                                                  true
                                          ? 'Sold Out'
                                          : grocery_lbl_add_to_cart)),
                              SizedBox(height: spacing_standard_new),
                            ],
                          ),
                        ),
                        Align(
                            alignment: Alignment.topCenter,
                            child: model.isProductIsInSale == true
                                ? Banner(
                                    location: BannerLocation.topStart,
                                    message: 'Sale',
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: boxDecoration(
                                          showShadow: true,
                                          radius: 10.0,
                                          bgColor: grocery_color_white),
                                      height: width * 0.35,
                                      width: width * 0.6,
                                      child: CarouselSlider(
                                          options: CarouselOptions(
                                            viewportFraction: 0.95,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                3.5,
                                            initialPage: 0,
                                            enableInfiniteScroll: true,
                                            autoPlay: true,
                                            autoPlayInterval:
                                                Duration(seconds: 3),
                                          ),
                                          items: model.images.map((e) {
                                            return Builder(builder:
                                                (BuildContext context) {
                                              return Container(
                                                width: double.infinity,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            100,
                                                    vertical: 5),
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    4,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  child: CachedNetworkImage(
                                                    imageUrl: e.path,
                                                    width: double.infinity,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            4,
                                                    fit: BoxFit.fill,
                                                    placeholder:
                                                        placeholderWidgetFn(),
                                                  ),
                                                ),
                                              );
                                            });
                                          }).toList()),
                                    ))
                                : Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: boxDecoration(
                                        showShadow: true,
                                        radius: 10.0,
                                        bgColor: grocery_color_white),
                                    height: width * 0.35,
                                    width: width * 0.6,
                                    child: CarouselSlider(
                                        options: CarouselOptions(
                                          viewportFraction: 1,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              3.5,
                                          initialPage: 0,
                                          enableInfiniteScroll: true,
                                          autoPlay: true,
                                          autoPlayInterval:
                                              Duration(seconds: 3),
                                        ),
                                        items: model.images.map((e) {
                                          return Builder(
                                              builder: (BuildContext context) {
                                            return Container(
                                              width: double.infinity,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          100,
                                                  vertical: 5),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  4,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                child: CachedNetworkImage(
                                                  imageUrl: e.path,
                                                  width: double.infinity,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      4,
                                                  fit: BoxFit.fill,
                                                  placeholder:
                                                      placeholderWidgetFn(),
                                                ),
                                              ),
                                            );
                                          });
                                        }).toList()),
                                  )),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RelatedProduct(
                      ProductId: prodid['prodid'],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

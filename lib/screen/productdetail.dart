import 'package:bakraw/GlobalWidget/GlobalWidget.dart';
import 'package:bakraw/databasehelper.dart';
import 'package:bakraw/model/productmodel.dart';
import 'package:bakraw/provider/productdetailprovider.dart';
import 'package:bakraw/utils/GeoceryStrings.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:bakraw/utils/GroceryConstant.dart';
import 'package:bakraw/utils/GroceryWidget.dart';
import 'package:bakraw/widget/relatedproductitems.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:html/parser.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class GroceryProductDescription extends StatefulWidget {
  static String tag = '/ProductDescription';

  const GroceryProductDescription({Key key}) : super(key: key);

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
          .firstWhere((element) =>
              element.productId.contains(prodid['prodid']).validate())
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
    getUserInfo();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    changeStatusColor(grocery_colorPrimary);
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
  double price;
  double defaultprice = 0;

  @override
  Widget build(BuildContext context) {
    prodid = ModalRoute.of(context).settings.arguments as Map;
    favouriteMark();
    //print(prodid['prodid']);
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
        //SelectedRadio('name');
      });
      init = false;
    }

    String parseHtmlString(String htmlString) {
      final document = parse(htmlString);
      final String parsedString =
          parse(document.body.text).documentElement.text;

      return parsedString;
    }

    Markfavourite() {
      setState(() {
        isFavourite = !isFavourite;
      });
    }
    /*String increasecount(int count) {
      setState(() {
        return model.productOptions[0].options[optioncount].name;
      });
    }*/

    String PriceReturn() {
      if (Provider.of<ProductProvider>(context).items == null) {
        setState(() {
          defaultprice = double.parse(model.price);
          price = defaultprice;
        });
      } else {
        setState(() {
          price = (defaultprice +
              double.parse(Provider.of<ProductProvider>(context).items.price));
        });
      }
      return price.toString();
    }

    changeStatusColor(grocery_app_background);
    double expandHeight = MediaQuery.of(context).size.width * 1.1;
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () {
        init = true;
        Navigator.of(context).pop();
      },
      child: Scaffold(
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
                                  Markfavourite();
                                  print('object $isFavourite');
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
                                    child: RadioListBuilder(optionlist: target),
                                  ),
                                ),
                                SizedBox(height: spacing_standard_new),
                                Container(
                                  child:
                                      Text(parseHtmlString(model.description)),
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
                                          itemcount > 1
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
                                            size: 35,
                                            color: grocery_icon_color),
                                        onPressed: () {
                                          setState(() {
                                            itemcount++;
                                          });
                                        }),
                                  ],
                                ),
                                SizedBox(height: spacing_standard_new),
                                FittedBox(
                                    child: groceryButton(
                                        onPressed: () async {
                                          Options option =
                                              Provider.of<ProductProvider>(
                                                      context,
                                                      listen: false)
                                                  .items;
                                          if (option == null) {
                                            Fluttertoast.showToast(
                                                msg: 'Please select pack Size');
                                          } else {
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
                                              DatabaseHelper.price: price
                                            });
                                            i > 0 ? count = 1 : count = count;
                                            Fluttertoast.showToast(
                                                msg: i > 0
                                                    ? "Product Added to Cart"
                                                    : 'Product Already Exist In Cart');
                                            setState(() {
                                              itemcount = 1;
                                            });
                                          }
                                        },
                                        textContent: grocery_lbl_add_to_cart)),
                                SizedBox(height: spacing_standard_new),
                                GestureDetector(
                                  onTap: () {},
                                  child: text(grocery_lbl_buy_now,
                                      textColor: grocery_colorPrimary,
                                      textAllCaps: true),
                                )
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: boxDecoration(
                                  showShadow: true,
                                  radius: 10.0,
                                  bgColor: grocery_color_white),
                              height: width * 0.35,
                              width: width * 0.6,
                              child: CachedNetworkImage(
                                placeholder: placeholderWidgetFn(),
                                imageUrl: model.images[0].path,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Related Products',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      RelatedProduct(),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class RadioListBuilder extends StatefulWidget {
  List<Options> optionlist;

  RadioListBuilder({Key key, this.optionlist}) : super(key: key);

  @override
  _RadioListBuilderState createState() => _RadioListBuilderState();
}

class _RadioListBuilderState extends State<RadioListBuilder> {
  var samp;
  SelectedRadio(Options val) {
    setState(() {
      selectedValue = val.optionValueId;
      Provider.of<ProductProvider>(context, listen: false)
          .UpdateOptionValue(val);
    });
  }

  var selectedValue;
  var sOptionPrice;
  var sOptionLable;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: widget.optionlist.length,
      itemBuilder: (context, index) {
        return SizedBox(
          width: MediaQuery.of(context).size.width / 2.3,
          child: RadioListTile(
              toggleable: false,
              controlAffinity: ListTileControlAffinity.platform,
              dense: true,
              title: Text(
                widget.optionlist[index].label,
                style: TextStyle(
                    fontFamily: fontMedium,
                    fontSize: MediaQuery.of(context).size.width / 23),
              ),
              value: widget.optionlist[index].optionValueId,
              groupValue: selectedValue,
              onChanged: (val) {
                SelectedRadio(Options(
                    label: widget.optionlist[index].label,
                    name: widget.optionlist[index].name,
                    price: widget.optionlist[index].price,
                    increaseProductPriceBy:
                        widget.optionlist[index].increaseProductPriceBy,
                    optionValueId: widget.optionlist[index].optionValueId));
              }),
        );
      },
    );
  }
}

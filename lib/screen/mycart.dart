import 'package:bakraw/GlobalWidget/GlobalWidget.dart';
import 'package:bakraw/model/productmodel.dart' as Data;
import 'package:bakraw/databasehelper.dart';
import 'package:bakraw/model/carttoproductmodel.dart';
import 'package:bakraw/model/internalcart.dart';
//import 'package:bakraw/model/productmodel.dart';
import 'package:bakraw/provider/productdetailprovider.dart';
import 'package:bakraw/screen/dashboard.dart';
import 'package:bakraw/screen/dashboaruderprofile.dart';
import 'package:bakraw/screen/useraddresslist.dart';
import 'package:bakraw/utils/GeoceryStrings.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:bakraw/utils/GroceryConstant.dart';
import 'package:bakraw/utils/GroceryWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class Mycart extends StatefulWidget {
  static const tag = '/mycart';

  @override
  _MycartState createState() => _MycartState();
}

class _MycartState extends State<Mycart> {
  bool isLoading = true;
  List<CartsModel> rowlist;
  double subtotal = 00.00;
  bool isinit = true;
  int count = 0;
  String email = '';
  String apikey = '';
  String userid = '';
  Map<String,CartProductModel> cartProducts;
  @override
  void initState() {
    super.initState();
    getUserInfo();
    fetchcartItems();
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

  double Subtotal() {
     for (int i = 0; i < cartProducts.length; i++) {
      double total = double.parse(cartProducts[i].cartModel.price);
      int qty = int.parse(cartProducts[i].cartModel.quantity);
      subtotal += total * qty;
    }
    return subtotal;
  }

  Future fetchcartItems() async {
    subtotal = 0.0;
    cartProducts = Map<String,CartProductModel>();
    count = await DatabaseHelper.instance.getCount();
    rowlist = await DatabaseHelper.instance.getcartItems();

    if (isinit) {
      for (CartsModel element in rowlist) {
        Data.ProductModel model =
            await Provider.of<ProductProvider>(context, listen: false)
                .getProductDetails(element.productid);
        List<Data.Data> target = [];
        target.add(Data.Data(images: model.data.images, name: model.data.name));
        cartProducts.putIfAbsent(element.productid,()=>new CartProductModel(element, target));
      }
    }
    setState(() {
      isinit = false;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    changeStatusColor(grocery_colorPrimary);
    var width = MediaQuery.of(context).size.width;
    updateVal(String quantity,String productId){

      setState(() {
        CartsModel model=cartProducts[productId].cartModel;
        model.quantity=quantity;
      });
    }
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(spacing_standard_new),
                    width: width,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: grocery_ShadowColor,
                            blurRadius: 10,
                            spreadRadius: 3)
                      ],
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(spacing_middle),
                          bottomLeft: Radius.circular(spacing_middle)),
                      color: grocery_color_white,
                    ),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            text(
                                '${grocery_lbl_subtotal}${' '}${'(${count} items)'}'),
                            text('₹ ${Subtotal().toString()}',
                                fontFamily: fontMedium),
                          ],
                        ),
                        SizedBox(height: spacing_control),
                        SizedBox(height: spacing_standard_new),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            text("Continue",
                                    textColor: grocery_colorPrimary,
                                    textAllCaps: true,
                                    fontFamily: fontMedium)
                                .onTap(
                              () {
                                Navigator.of(context)
                                    .pushReplacementNamed(Dashboard.Tag);
                              },
                            ),
                            SizedBox(width: spacing_standard_new),
                            FittedBox(
                              child: groceryButton(
                                bgColors: grocery_colorPrimary,
                                textContent: grocery_lbl_checkout,
                                onPressed: (() {
                                  !email.isEmptyOrNull
                                      ? subtotal <= 0
                                          ? Fluttertoast.showToast(
                                              msg: 'Your cart is Empty',
                                              toastLength: Toast.LENGTH_SHORT)
                                          : Navigator.of(context).pushNamed(
                                              UserAddressManager.tag,
                                              arguments: {'isnav': true})
                                      : DefaultUserProfile(
                                          istab: false,
                                        ).launch(context);
                                }),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: spacing_standard_new),
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: cartProducts.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Cart(
                          cartProducts[index].cartModel.id,
                          cartProducts[index].cartModel.productid,
                          cartProducts[index].cartModel.optionvalueId,
                          cartProducts[index].cartModel.optionid,
                          cartProducts[index].cartModel.optionname,
                          cartProducts[index].cartModel.optionlable,
                          cartProducts[index].cartModel.productpriceincreased,
                          cartProducts[index].cartModel.price,
                          cartProducts[index].cartModel.quantity,
                          cartProducts[index].target[0],
                          (quantity,productId){
                            updateVal(quantity,productId);
                          }
                      );
                    },
                  ),
                ],
              ),
            ),
    );


  }
}

class Cart extends StatefulWidget {
  int id;
  String productid;
  String optionvalueid;
  String optionid;
  String optionname;
  String optionlable;
  String productpriceincreased;
  String price;
  String quantity;
  Data.Data mld;
  Function callback;

  Cart(
    this.id,
    this.productid,
    this.optionvalueid,
    this.optionid,
    this.optionname,
    this.optionlable,
    this.productpriceincreased,
    this.price,
    this.quantity,
    this.mld,
      this.callback
  );

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    Widget mRemoveItem() {
      showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: IntrinsicHeight(
                child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(spacing_large),
                      topRight: Radius.circular(spacing_large)),
                  color: grocery_color_white),
              height: MediaQuery.of(context).size.height / 2.8,
              padding: EdgeInsets.all(spacing_standard_new),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                            right: spacing_standard_new, top: spacing_middle),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: grocery_color_red),
                        padding: EdgeInsets.all(width * 0.02),
                        child: Icon(Icons.delete, color: grocery_color_white),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            text(grocery_lbl_remove_an_item,
                                fontFamily: fontMedium,
                                fontSize: textSizeNormal),
                            text(grocery_lbl_remove_confirmation,
                                textColor: grocery_textColorSecondary,
                                isLongText: true),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: spacing_large),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: text("$grocery_lbl_no",
                              textColor: grocery_textColorSecondary,
                              textAllCaps: true,
                              fontFamily: fontMedium),
                        ),
                      ),
                      SizedBox(width: spacing_standard_new),
                      Container(
                        width: width * 0.35,
                        child: groceryButton(
                          textContent: grocery_lbl_remove,
                          onPressed: (() async {
                            int i =
                                await DatabaseHelper.instance.deleteCartItem({
                              DatabaseHelper.productid: widget.productid,
                              DatabaseHelper.optionvalueid: widget.optionvalueid
                            });
                            i > 0
                                ? Fluttertoast.showToast(
                                    msg: 'Item Deleted Successfully',
                                    toastLength: Toast.LENGTH_SHORT)
                                : Fluttertoast.showToast(
                                    msg: 'Something Went Wrong',
                                    toastLength: Toast.LENGTH_SHORT);
                            Navigator.pop(context);
                          }),
                          bgColors: grocery_color_red,
                        ),
                      )
                    ],
                  )
                ],
              ),
            )),
          );
        },
      );
    }

    return Container(
      decoration: boxDecoration(
          showShadow: true, bgColor: grocery_color_white.withOpacity(0.9)),
      padding: EdgeInsets.fromLTRB(
          spacing_middle, 0, spacing_middle, spacing_middle),
      margin: EdgeInsets.only(
          left: spacing_standard_new,
          right: spacing_standard_new,
          bottom: spacing_standard_new),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: CachedNetworkImage(
                    placeholder: placeholderWidgetFn(),
                    imageUrl: widget.mld.images[0].path,
                    fit: BoxFit.fill,
                    height: width * 0.25,
                    width: width * 0.40,
                  ),
                ),
                SizedBox(height: spacing_control),
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                          left: spacing_standard, right: spacing_standard),
                      decoration: boxDecoration(
                          radius: spacing_control,
                          bgColor: grocery_light_gray_color),
                      margin: EdgeInsets.only(right: spacing_middle),
                      child: text(widget.optionlable,
                          fontSize: textSizeSmall, isCentered: true),
                    ),
                    text('₹ ${double.parse(widget.price).toStringAsFixed(2)}',
                        fontSize: textSizeLargeMedium),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    text(
                        '₹ ${(double.parse(widget.price) * int.parse(widget.quantity)).toStringAsFixed(2)}',
                        fontSize: textSizeLargeMedium,
                        fontFamily: fontMedium),
                    IconButton(
                      onPressed: () {
                        mRemoveItem();
                      },
                      icon:
                          Icon(Icons.delete_outline, color: grocery_icon_color),
                    )
                  ],
                ),
                Container(
                    transform: Matrix4.translationValues(0.0, -10.0, 0.0),
                    child: text(widget.mld.name,
                        textColor: grocery_textColorSecondary)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                        icon: Icon(Icons.remove_circle_outline,
                            size: 28, color: grocery_icon_color),
                        onPressed: () async {
                          int temp = int.parse(widget.quantity);
                          int i;
                          if (temp > 1) {
                            temp--;
                            i = await DatabaseHelper.instance.updateCartitem({
                              DatabaseHelper.productid: widget.productid,
                              DatabaseHelper.optionvalueid:
                                  widget.optionvalueid,
                              DatabaseHelper.optionlable: widget.optionlable,
                              DatabaseHelper.price: widget.price,
                              DatabaseHelper.optionid: widget.optionid,
                              DatabaseHelper.optionname: widget.optionname,
                              DatabaseHelper.productpriceincreased:
                                  widget.productpriceincreased,
                              DatabaseHelper.quantity: temp.toString()
                            });
                            if (i > 0) {
                              setState(() {
                                widget.quantity = temp.toString();
                              });
                              widget.callback(widget.quantity,widget.productid);
                            }
                          } else {}
                        }),
                    text(widget.quantity,
                        fontFamily: fontMedium, fontSize: textSizeNormal),
                    IconButton(
                        icon: Icon(Icons.add_circle_outline,
                            size: 28, color: grocery_icon_color),
                        onPressed: () async {
                          int temp = int.parse(widget.quantity);
                          int i;
                          if (temp >= 1) {
                            temp++;
                            i = await DatabaseHelper.instance.updateCartitem({
                              DatabaseHelper.productid: widget.productid,
                              DatabaseHelper.optionvalueid:
                                  widget.optionvalueid,
                              DatabaseHelper.optionlable: widget.optionlable,
                              DatabaseHelper.optionid: widget.optionid,
                              DatabaseHelper.optionname: widget.optionname,
                              DatabaseHelper.productpriceincreased:
                                  widget.productpriceincreased,
                              DatabaseHelper.price: widget.price,
                              DatabaseHelper.quantity: temp.toString()
                            });
                            if (i > 0) {
                              setState(() {
                                widget.quantity = temp.toString();
                              });
                            }
                          } else {}
                        }),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

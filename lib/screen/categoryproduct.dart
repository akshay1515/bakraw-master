import 'package:bakraw/GlobalWidget/GlobalWidget.dart';
import 'package:bakraw/model/categoryproductmodel.dart';
import 'package:bakraw/provider/categoryproductprovider.dart';
import 'package:bakraw/screen/productdetail.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:bakraw/utils/GroceryConstant.dart';
import 'package:bakraw/utils/GroceryWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GrocerySubCategoryList extends StatefulWidget {
  static String tag = '/GrocerySubCategoryList';

  @override
  GrocerySubCategoryListState createState() => GrocerySubCategoryListState();
}

class GrocerySubCategoryListState extends State<GrocerySubCategoryList> {
  List<Datum> mStoreDealList = [];
  var init = true;
  var isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    final catid = ModalRoute.of(context).settings.arguments as Map;
    setState(() {
      if (init == true) {
        Provider.of<CategoryProductProvider>(context, listen: false)
            .getProductBycategory(catid['catid'])
            .then((value) {
          if (value.data != null) {
            value.data.forEach((element) {
              mStoreDealList.add(Datum(
                  productId: element.productId,
                  price: element.price,
                  name: element.name,
                  images: element.images,
                  isProductIsInSale: element.isProductIsInSale,
                  productSaleDetails: element.productSaleDetails));
            });
            setState(() {
              init = false;
              isLoading = false;
            });
          }
        });
      }
    });
    //print(catid['name']);
    return Scaffold(
      backgroundColor: grocery_app_background,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, width * 0.25),
        child: TopBar(Icons.arrow_back, catid['name'], () {}),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: mStoreDealList.isNotEmpty
                  ? Container(
                      child: Container(
                          margin: EdgeInsets.only(
                              left: spacing_middle,
                              right: spacing_middle,
                              top: spacing_middle),
                          child: GridView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 0.70),
                            itemCount: mStoreDealList.length,
                            itemBuilder: (context, index) {
                              //print(mStoreDealList[index].name);
                              return StoreDeal(mStoreDealList[index], index);
                            },
                          )),
                    )
                  : Container(
                      child: Center(
                        child: CachedNetworkImage(
                          imageUrl:
                              'https://cdn.dribbble.com/users/453325/screenshots/5573953/empty_state.png',
                          fit: BoxFit.contain,
                          placeholder: placeholderWidgetFn(),
                          errorWidget: (context, url, error) =>
                              new Icon(Icons.error),
                        ),
                      ),
                    )),
    );
  }
}

class StoreDeal extends StatefulWidget {
  Datum model;

  StoreDeal(Datum model, int pos) {
    this.model = model;
  }

  @override
  _StoreDealState createState() => _StoreDealState();
}

class _StoreDealState extends State<StoreDeal> {
  String userid = '', email = '', apikey = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Provider.of<CategoryProductProvider>(context, listen: false)
              .UpdateOptionValue(widget.model.productId)
              .then((value) {});
          Navigator.of(context).pushNamed(GroceryProductDescription.tag,
              arguments: {
                'prodid': widget.model.productId,
                'names': widget.model.name
              });
          //GroceryProductDescription().launch(context);
        },
        child: widget.model.isProductIsInSale == true
            ? Banner(
                message: 'Sale',
                location: BannerLocation.topStart,
                child: Container(
                  decoration: boxDecoration(
                      showShadow: true,
                      radius: 10.0,
                      bgColor: grocery_color_white),
                  padding: EdgeInsets.all(spacing_middle),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      apikey.isNotEmpty
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(
                                      left: spacing_control,
                                      right: spacing_control),
                                  decoration: boxDecoration(
                                    radius: spacing_control,
                                    bgColor: grocery_color_white,
                                  ),
                                  child: text("1kg",
                                      fontSize: textSizeSmall,
                                      isCentered: true),
                                ),
                              ],
                            )
                          : Container(),
                      SizedBox(
                        height: 2,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          placeholder: placeholderWidgetFn(),
                          imageUrl: widget.model.images[0],
                          fit: BoxFit.fill,
                          height: MediaQuery.of(context).size.width * 0.40,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4, right: 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            text(widget.model.name,
                                fontFamily: fontMedium,
                                textColor: grocery_textColorSecondary),
                            text(
                              widget.model.isProductIsInSale == false
                                  ? '₹ ${double.parse(widget.model.price).toStringAsFixed(2)}'
                                  : '₹ ${double.parse(widget.model.productSaleDetails.productSalePrice).toStringAsFixed(2)}',
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            : Container(
                decoration: boxDecoration(
                    showShadow: true,
                    radius: 10.0,
                    bgColor: grocery_color_white),
                padding: EdgeInsets.all(spacing_middle),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    apikey.isNotEmpty
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(
                                    left: spacing_control,
                                    right: spacing_control),
                                decoration: boxDecoration(
                                  radius: spacing_control,
                                  bgColor: grocery_color_white,
                                ),
                                child: text("1kg",
                                    fontSize: textSizeSmall, isCentered: true),
                              ),
                            ],
                          )
                        : Container(),
                    SizedBox(
                      height: 2,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        placeholder: placeholderWidgetFn(),
                        imageUrl: widget.model.images[0],
                        fit: BoxFit.fill,
                        height: MediaQuery.of(context).size.width * 0.40,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4, right: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          text(widget.model.name,
                              fontFamily: fontMedium,
                              textColor: grocery_textColorSecondary),
                          text(
                            '₹ ${double.parse(widget.model.price).toStringAsFixed(2)}',
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ));
  }
}

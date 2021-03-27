/*
import 'package:bakraw/GlobalWidget/GlobalWidget.dart';
import 'package:bakraw/model/searchmodel.dart';
import 'package:bakraw/provider/searchprovider.dart';
import 'package:bakraw/screen/newui/newproductdetail.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class SearchScreen extends StatefulWidget {
  static String Tag = '/SearchScreen';

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Data> searchList = [];
  SearchModel model;
  Data searchData;
  bool isLoading = false;
  var navigtab = null;
  bool isready = false;
  TextEditingController textcontroller = TextEditingController();

  void performSearch(String text) {
    Provider.of<SearchProvider>(context, listen: false)
        .searchProducts(text)
        .then((value) {
      if (value.data != null) {
        value.data.forEach((element) {
          searchList.add(Data(
            name: element.name,
            price: element.price,
            shortDescription: element.shortDescription,
            productId: element.productId,
            images: element.images,
            specialPrice: element.specialPrice,
            isProductIsInSale: element.isProductIsInSale,
            productSaleDetails: element.productSaleDetails,
            productRating: element.productRating,
          ));
        });
        setState(() {
          isLoading = false;
        });
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isready == false) {
      navigtab = ModalRoute.of(context).settings.arguments as Map;
      textcontroller.text = navigtab['word'];
    }

    if (textcontroller.text != null || textcontroller.text.isNotEmpty) {
      if (isready == false) {
        setState(() {
          isLoading = true;
        });
        navigtab = null;
        performSearch(textcontroller.text);
        isready = true;
      }
    }

    return Scaffold(
        appBar: PreferredSize(
            child: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 5,
                )
              ]),
              width: MediaQuery.of(context).size.width,
              height: 100,
              child: Container(
                  decoration: BoxDecoration(
                    color: grocery_colorPrimary,
                  ),
                  child: Container(
                      margin: EdgeInsets.only(top: 10),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            fit: FlexFit.loose,
                            flex: 2,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              margin: EdgeInsets.only(top: 15),
                              height: 100,
                              alignment: Alignment.center,
                              child: TextFormField(
                                textInputAction: TextInputAction.search,
                                onFieldSubmitted: (text) {
                                  searchList = [];
                                  setState(() {
                                    isLoading = true;
                                  });
                                  performSearch(text);
                                },
                                controller: textcontroller,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 15),
                                    hintText: 'Enter Text To Search',
                                    filled: true,
                                    suffixIcon: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: FlatButton(
                                          color: grocery_colorPrimary,
                                          onPressed: () {
                                            searchList = [];
                                            setState(() {
                                              isLoading = true;
                                            });
                                            performSearch(textcontroller.text);
                                          },
                                          child: Text(
                                            'Search',
                                            style: TextStyle(
                                                color: grocery_color_white),
                                          )),
                                    ),
                                    fillColor: grocery_color_white),
                              ),
                            ),
                          ),
                        ],
                      ))),
            ),
            preferredSize: Size(double.infinity, 100)),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                height: MediaQuery.of(context).size.height - 10,
                child: searchList.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: searchList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: (() {
                              Navigator.of(context)
                                  .pushNamed(NewProductDetails.tag, arguments: {
                                'prodid': searchList[index].productId,
                                'names': searchList[index].name
                              });
                            }),
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 3),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: grocery_light_gray_color,
                                    width: 1,
                                    style: BorderStyle.solid),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    height: 100,
                                    width: 100,
                                    child: CachedNetworkImage(
                                      imageUrl: searchList[index].images[0],
                                      fit: BoxFit.fill,
                                      placeholder: placeholderWidgetFn(),
                                      errorWidget: (context, url, error) =>
                                          new Icon(Icons.error),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, bottom: 5),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            searchList[index].name,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.only(left: 10, top: 3),
                                          child: SmoothStarRating(
                                            color: Colors.amber.shade500,
                                            allowHalfRating: true,
                                            isReadOnly: true,
                                            starCount: 5,
                                            rating: double.parse(
                                                searchList[index]
                                                    .productRating
                                                    .avgRating
                                                    .toString()),
                                            size: 17,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            'Price : ₹ ${double.parse(searchList[index].price).toStringAsFixed(2)}',
                                            style: TextStyle(
                                              fontSize: 15,
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        })
                    : Container(
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.inbox_rounded,
                              size: 150,
                              color: grocery_colorPrimary,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('No Result Found For'),
                                Text(
                                  ' ${textcontroller.text}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                )
                              ],
                            )
                          ],
                        )),
                      ),
              ));
  }
}
*/

import 'package:bakraw/GlobalWidget/GlobalWidget.dart';
import 'package:bakraw/model/searchmodel.dart';
import 'package:bakraw/provider/searchprovider.dart';
import 'package:bakraw/screen/newui/newproductdetail.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:bakraw/widget/horizontallist.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class SearchScreen extends StatefulWidget {
  static String Tag = '/SearchScreen';

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Data> searchList = [];
  SearchModel model;
  Data searchData;
  bool isLoading = false;
  var navigtab = null;
  bool isready = false;
  TextEditingController searchController = TextEditingController();
  List<String> title = [
    'Hygenic',
    'Fresh',
    'Traceable',
    'Farm to Fork',
    'Free Delivery'
  ];
  List<String> imageList = [
    'images/newicons/hygenicwhite.png',
    'images/newicons/freshwhite.png',
    'images/newicons/traceablewhite.png',
    'images/newicons/farmforkwhite.png',
    'images/newicons/freedeliverywhite.png'
  ];

  void performSearch(String text) {
    Provider.of<SearchProvider>(context, listen: false)
        .searchProducts(text)
        .then((value) {
      if (value.data != null) {
        value.data.forEach((element) {
          searchList.add(Data(
            name: element.name,
            price: element.price,
            shortDescription: element.shortDescription,
            productId: element.productId,
            images: element.images,
            specialPrice: element.specialPrice,
            isProductIsInSale: element.isProductIsInSale,
            productSaleDetails: element.productSaleDetails,
            productRating: element.productRating,
          ));
        });
        setState(() {
          isLoading = false;
        });
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isready == false) {
      navigtab = ModalRoute.of(context).settings.arguments as Map;
      searchController.text = navigtab['word'];
    }

    if (searchController.text != null || searchController.text.isNotEmpty) {
      if (isready == false) {
        setState(() {
          isLoading = true;
        });
        navigtab = null;
        performSearch(searchController.text);
        isready = true;
      }
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                      height: 220,
                      width: double.infinity,
                      color: Color.fromRGBO(51, 105, 30, 1)),
                ],
              ),
              Column(
                children: [
                  Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(50)),
                    margin: EdgeInsets.only(top: 50),
                    height: 55,
                  ),
                  Container(
                      decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(
                                  style: BorderStyle.solid,
                                  color: grocery_colorPrimary_light,
                                  width: 3))),
                      margin: EdgeInsets.only(top: 10),
                      padding: EdgeInsets.only(top: 10),
                      child: HorizontalScrollview())
                ],
              ),
              Container(
                child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: title.length,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: title.length),
                    itemBuilder: (context, index) {
                      return Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                child: DottedBorder(
                                  borderType: BorderType.Circle,
                                  color: Colors.white,
                                  strokeWidth: 1,
                                  padding: EdgeInsets.all(3),
                                  child: Center(
                                    child: Container(
                                        child: Image.asset(
                                      imageList[index],
                                      height: 30,
                                      width: 30,
                                      fit: BoxFit.contain,
                                    )),
                                  ),
                                ),
                              ),
                              Text(
                                title[index],
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              )
                            ],
                          ));
                    }),
              ),
              Column(
                children: [
                  Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(50)),
                    margin: EdgeInsets.only(top: 50),
                    height: 55,
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 130),
                      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: searchList.length,
                          itemBuilder: (_, index) {
                            return SearchItem(
                              index: index,
                              searchList: searchList[index],
                            );
                          }))
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 190),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      child: TextFormField(
                        controller: searchController,
                        onFieldSubmitted: (text) {
                          searchList = [];
                          setState(() {
                            isLoading = true;
                          });
                          performSearch(text);
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search your meat",
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.grey.shade700,
                            ),
                            suffixIcon: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: grocery_colorPrimary_light),
                              child: IconButton(
                                  icon: Icon(
                                    Icons.arrow_forward_rounded,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    if (searchController.text.trim() != null ||
                                        searchController.text
                                            .trim()
                                            .isNotEmpty) {
                                      String text =
                                          searchController.text.trim();
                                      searchController.clear();
                                      Navigator.of(context).pushNamed(
                                          SearchScreen.Tag,
                                          arguments: {'word': text});
                                    }
                                  }),
                            )),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SearchItem extends StatelessWidget {
  final int index;
  final Data searchList;

  const SearchItem({Key key, this.searchList, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: GestureDetector(
        onTap: (() {
          Navigator.of(context).pushNamed(NewProductDetails.tag, arguments: {
            'prodid': searchList.productId,
            'names': searchList.name
          });
        }),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
                color: grocery_light_gray_color,
                width: 1,
                style: BorderStyle.solid),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 100,
                width: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                  child: CachedNetworkImage(
                    imageUrl: searchList.images[0],
                    fit: BoxFit.fill,
                    placeholder: placeholderWidgetFn(),
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        searchList.name,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10, top: 3),
                      child: SmoothStarRating(
                        color: Colors.amber.shade500,
                        allowHalfRating: true,
                        isReadOnly: true,
                        starCount: 5,
                        rating: double.parse(
                            searchList.productRating.avgRating.toString()),
                        size: 17,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Price : ₹ ${double.parse(searchList.price).toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
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

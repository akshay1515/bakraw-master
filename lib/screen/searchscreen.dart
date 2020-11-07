import 'package:bakraw/GlobalWidget/GlobalWidget.dart';
import 'package:bakraw/model/searchmodel.dart';
import 'package:bakraw/provider/searchprovider.dart';
import 'package:bakraw/screen/productdetail.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Data> searchList = [];
  SearchModel model;
  Data searchData;
  bool isLoading = false;
  TextEditingController textcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                                onSaved: (text) {
                                  searchList = [];
                                  setState(() {
                                    isLoading = true;
                                  });
                                  Provider.of<SearchProvider>(context,
                                          listen: false)
                                      .searchProducts(text)
                                      .then((value) {
                                    if (value.data != null) {
                                      value.data.forEach((element) {
                                        searchList.add(Data(
                                          name: element.name,
                                          price: element.price,
                                          shortDescription:
                                              element.shortDescription,
                                          productId: element.productId,
                                          images: element.images,
                                          specialPrice: element.specialPrice,
                                        ));
                                      });
                                      setState(() {
                                        isLoading = false;
                                      });
                                    } else {}
                                  });
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
                                            Provider.of<SearchProvider>(context,
                                                    listen: false)
                                                .searchProducts(
                                                    textcontroller.text)
                                                .then((value) {
                                              if (value.data != null) {
                                                value.data.forEach((element) {
                                                  searchList.add(Data(
                                                    name: element.name,
                                                    price: element.price,
                                                    shortDescription: element
                                                        .shortDescription,
                                                    productId:
                                                        element.productId,
                                                    images: element.images,
                                                    specialPrice:
                                                        element.specialPrice,
                                                  ));
                                                });
                                                setState(() {
                                                  isLoading = false;
                                                });
                                              } else {}
                                            });
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
                              Navigator.of(context).pushNamed(
                                  GroceryProductDescription.tag,
                                  arguments: {
                                    'prodid': searchList[index].productId,
                                    'names': searchList[index].name
                                  });
                              Fluttertoast.showToast(
                                  msg: searchList[index].productId,
                                  toastLength: Toast.LENGTH_SHORT);
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: 100,
                                    width: 150,
                                    child: CachedNetworkImage(
                                      imageUrl: searchList[index].images[0],
                                      fit: BoxFit.contain,
                                      placeholder: placeholderWidgetFn(),
                                      errorWidget: (context, url, error) =>
                                          new Icon(Icons.error),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          '${searchList[index].shortDescription}',
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                          textAlign: TextAlign.start,
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
                                      /*Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        'Quantity :${int.parse(productslist[index].qty)}',
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        'Total : ₹ ${double.parse(productslist[index].lineTotal).toStringAsFixed(2)}',
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),*/
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        })
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
                      ),
              ));
  }
}

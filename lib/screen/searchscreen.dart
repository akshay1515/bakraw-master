import 'package:bakraw/GlobalWidget/GlobalWidget.dart';
import 'package:bakraw/model/searchmodel.dart';
import 'package:bakraw/provider/searchprovider.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
                              controller: textcontroller,
                              decoration: InputDecoration(
                                  hintText: 'Enter Text To Search',
                                  filled: true,
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: FlatButton(
                                        color: grocery_colorPrimary,
                                        onPressed: () {
                                          setState(() {
                                            searchList = [];
                                            isLoading = true;
                                          });
                                          Provider.of<SearchProvider>(context,
                                                  listen: false)
                                              .searchProducts(
                                                  textcontroller.text)
                                              .then((value) {
                                            if (value.status == 200) {
                                              value.data.forEach((element) {
                                                searchList.add(Data(
                                                  name: element.name,
                                                  price: element.price,
                                                  shortDescription:
                                                      element.shortDescription,
                                                  productId: element.productId,
                                                  images: element.images,
                                                  specialPrice:
                                                      element.specialPrice,
                                                ));
                                              });
                                              setState(() {
                                                isLoading = false;
                                              });
                                            }
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
          : searchList != null
              ? ListView.builder(
                  itemCount: searchList.length,
                  itemBuilder: (context, index) {
                    return Flexible(
                      fit: FlexFit.tight,
                      child: Container(
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    searchList[index].name,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    '${searchList[index].shortDescription}',
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Flexible(child: Container()),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
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
              : Container(),
    );
  }
}

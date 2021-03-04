import 'package:bakraw/GlobalWidget/GlobalWidget.dart';
import 'package:bakraw/model/searchmodel.dart';
import 'package:bakraw/provider/searchprovider.dart';
import 'package:bakraw/screen/productdetail.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  void performSearch(String text){
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
    if(isready==false) {
      navigtab = ModalRoute
          .of(context)
          .settings
          .arguments as Map;
      textcontroller.text = navigtab['word'];
    }

    if(textcontroller.text != null || textcontroller.text.isNotEmpty){
      if(isready == false) {
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
                                onFieldSubmitted:(text){
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
                              Navigator.of(context).pushNamed(
                                  GroceryProductDescription.tag,
                                  arguments: {
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
                                    padding: const EdgeInsets.only(top: 5,bottom: 5),
                                    child: Column(
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
                                          padding: EdgeInsets.only(left: 10,top: 3),
                                          child:  SmoothStarRating(
                                            color: Colors.amber.shade500,
                                            allowHalfRating: true,
                                            isReadOnly: true,
                                            starCount: 5,
                                            rating: double.parse(
                                                searchList[index].productRating.avgRating.toString()),
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
                              Icon(Icons.inbox_rounded,size: 150,color: grocery_colorPrimary,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('No Result Found For'),
                                  Text(' ${textcontroller.text}',style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black
                                  ),)
                                ],
                              )
                            ],
                          )
                        ),
                      ),
              ));
  }
}

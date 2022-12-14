import 'package:bakraw/GlobalWidget/GlobalWidget.dart';
import 'package:bakraw/model/searchmodel.dart';
import 'package:bakraw/provider/searchprovider.dart';
import 'package:bakraw/screen/newui/newproductdetail.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:bakraw/widget/bakrawproperties.dart';
import 'package:bakraw/widget/horizontallist.dart';
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
  String temp;
  TextEditingController searchController = TextEditingController();

  void performSearch(String text) {
    Provider.of<SearchProvider>(context, listen: false)
        .searchProducts(text)
        .then((value) {
      if (value.status == 200) {
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
        } else {
          searchList.add(Data());
        }
      } else {
        setState(() {
          isLoading = false;
        });
        temp = value.status.toString();
      }
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
          title: Text('Search results'),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                      height: 190,
                      width: double.infinity,
                      color: Color.fromRGBO(51, 105, 30, 1)),
                ],
              ),
              Column(
                children: [
                  Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(50)),
                    margin: EdgeInsets.only(top: 20),
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
              Container(child: BakrawUniqueness()),
              /*Column(
                children: [

                ],
              ),*/
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 160),
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
                  !isLoading
                      ? searchList.length > 0
                          ? Container(
                              /* margin: EdgeInsets.only(top: 130),*/
                              padding:
                                  EdgeInsets.only(top: 5, left: 10, right: 10),
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
                          : temp == null
                              ? Container(
                                  margin: EdgeInsets.only(top: 130),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.inbox_rounded,
                                          color: Colors.green.shade900
                                              .withGreen(85),
                                          size: 100,
                                        ),
                                        Text(
                                            'No Product to display for ${searchController.text}')
                                      ],
                                    ),
                                  ),
                                )
                              : Container(
                                  margin: EdgeInsets.only(top: 130),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.search_rounded,
                                          color: Colors.green.shade900
                                              .withGreen(85),
                                          size: 100,
                                        ),
                                        Text('Enter Text To Search')
                                      ],
                                    ),
                                  ),
                                )
                      : Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
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
      borderRadius: BorderRadius.circular(8),
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
            borderRadius: BorderRadius.circular(8),
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
                      bottomLeft: Radius.circular(8),
                      topLeft: Radius.circular(8)),
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
                        'Price : ??? ${double.parse(searchList.price).toStringAsFixed(2)}',
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

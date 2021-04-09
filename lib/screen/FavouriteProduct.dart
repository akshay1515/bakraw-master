import 'package:bakraw/GlobalWidget/GlobalWidget.dart';
import 'package:bakraw/model/favouritemodel.dart';
import 'package:bakraw/provider/favouriteproductprovider.dart';
import 'package:bakraw/screen/newui/newproductdetail.dart';
import 'package:bakraw/screen/newui/newsignup.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:bakraw/utils/GroceryConstant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class UserFavouriteList extends StatefulWidget {
  @override
  _UserFavouriteListState createState() => _UserFavouriteListState();
}

class _UserFavouriteListState extends State<UserFavouriteList> {
  List<Data> mFavouriteList = [];
  String userid = '', email = '', apikey = '';
  bool favinit = false;
  Future<FavouriteModel> myfuture;

  @override
  void initState() {
    super.initState();
    setUser().then((value) {
      if (userid != null) {
        getfuture();
      }
      setState(() {
        favinit = true;
      });
    });
  }

  void getfuture() {
    myfuture = Provider.of<UserFavouriteProvider>(context, listen: false)
        .getUserFavProduct(userid, apikey);
  }

  Widget usercheck() {
    Future.delayed(Duration(seconds: 0), () {
      Navigator.popAndPushNamed(context, NewLogin.Tag);
    });
    return Container();
  }

  Future<String> setUser() async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    if (prefs != null) {
      email = prefs.getString('email');
      userid = prefs.getString('id');
      apikey = prefs.getString('apikey');
      return userid;
    }
  }

  @override
  Widget build(BuildContext context) {
    return favinit
        ? userid != null
            ? Container(
                margin: EdgeInsets.only(
                    top: spacing_middle,
                    right: spacing_standard_new,
                    bottom: 80),
                child: FutureBuilder(
                  future: myfuture,
                  builder: (context, AsyncSnapshot<FavouriteModel> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.data != null) {
                        return GridView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, childAspectRatio: 0.85),
                          itemCount: snapshot.data.data.length,
                          itemBuilder: (context, index) {
                            return StoreDeal(snapshot.data.data[index], index);
                          },
                        );
                      } else {
                        return Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.inbox,
                                color: grocery_colorPrimary,
                                size: MediaQuery.of(context).size.height / 5,
                              ),
                            ),
                            Text('No Don\'t Have Favourite Item\'s List yet'),
                          ],
                        ));
                      }
                    } else {
                      return Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  },
                ))
            : usercheck()
        : Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}

class StoreDeal extends StatelessWidget {
  Data model;

  StoreDeal(Data model, int pos) {
    this.model = model;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(NewProductDetails.tag,
              arguments: {'prodid': model.productId, 'names': model.name});
        },
        child: Stack(
          children: [
            Container(
              width: 175,
              height: 270,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black45, blurRadius: 5, spreadRadius: 2),
                  ],
                  borderRadius: BorderRadius.vertical(top: Radius.circular(5))),
              margin: EdgeInsets.only(left: 16, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(5)),
                    child: CachedNetworkImage(
                      placeholder: placeholderWidgetFn(),
                      imageUrl: model.images[0],
                      fit: BoxFit.cover,
                      height: 125,
                      width: double.infinity,
                    ),
                  ),
                  SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SmoothStarRating(
                          color: Colors.amber.shade500,
                          allowHalfRating: true,
                          isReadOnly: true,
                          starCount: 5,
                          rating: 5,
                          size: 17,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 1),
                          child: Text(
                            '(${6})',
                            style: TextStyle(fontSize: 10),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 4),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(model.name),
                  ),
                  SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.grey.shade300, width: 1))),
                    ),
                  ),
                  SizedBox(height: 4),
                  Container(
                    margin: EdgeInsets.only(top: 4),
                    child: Row(
                      children: [
                        Container(
                          width: 7,
                          height: 14,
                          decoration: BoxDecoration(
                              color: Colors.green.shade700,
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(25),
                                topRight: Radius.circular(25),
                              )),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            '₹ ${double.parse(model.price).toStringAsFixed(2)}',
                            style: TextStyle(
                                color: Colors.green.shade700,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
                right: 0,
                top: 0,
                child: Container(
                    height: 30,
                    width: 30,
                    child: Image.asset(
                      'images/newicons/favbanner.png',
                      height: 25,
                      width: 25,
                      fit: BoxFit.contain,
                    )))
          ],
        )
        /* : Container(
              width: 175,
              height: 270,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.black45, blurRadius: 5),
                  ],
                  borderRadius: BorderRadius.vertical(top: Radius.circular(5))),
              margin: EdgeInsets.only(left: 16, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(5)),
                    child: CachedNetworkImage(
                      placeholder: placeholderWidgetFn(),
                      imageUrl: model.images[0],
                      fit: BoxFit.cover,
                      height: 125,
                      width: double.infinity,
                    ),
                  ),
                  SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SmoothStarRating(
                          color: Colors.amber.shade500,
                          allowHalfRating: true,
                          isReadOnly: true,
                          starCount: 5,
                          rating: 5,
                          size: 17,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 1),
                          child: Text(
                            '(${6})',
                            style: TextStyle(fontSize: 10),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 4),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(model.name),
                  ),
                  SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.grey.shade300, width: 1))),
                    ),
                  ),
                  SizedBox(height: 4),
                  Container(
                    margin: EdgeInsets.only(top: 4),
                    child: Row(
                      children: [
                        Container(
                          width: 7,
                          height: 14,
                          decoration: BoxDecoration(
                              color: Colors.green.shade700,
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(25),
                                topRight: Radius.circular(25),
                              )),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            '₹ ${double.parse(model.price).toStringAsFixed(2)}',
                            style: TextStyle(
                                color: Colors.green.shade700,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),*/ /*
        );
  }*/
        );
  }
}

import 'package:bakraw/GlobalWidget/GlobalWidget.dart';
import 'package:bakraw/model/favouritemodel.dart';
import 'package:bakraw/provider/favouriteproductprovider.dart';
import 'package:bakraw/screen/newui/newproductdetail.dart';
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
  bool favinit = true;

  @override
  void initState() {
    super.initState();
    setUser().then((value) {
      Provider.of<UserFavouriteProvider>(context, listen: false)
          .getUserFavProduct(userid, apikey)
          .then((value) {
        if (favinit) {
          mFavouriteList =
              Provider.of<UserFavouriteProvider>(context, listen: false).items;
          print(mFavouriteList.length);
        }
      });
    });
  }

  Future setUser() async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    if (prefs != null) {
      setState(() {
        email = prefs.getString('email');
        userid = prefs.getString('id');
        apikey = prefs.getString('apikey');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: spacing_middle, right: spacing_standard_new, bottom: 80),
      child: mFavouriteList.length > 0
          ? GridView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 0.85),
              itemCount: mFavouriteList.length,
              itemBuilder: (context, index) {
                return StoreDeal(mFavouriteList[index], index);
              },
            )
          : Center(
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
            )),
    );

    /*return FutureBuilder(
        future:   Provider.of<UserFavouriteProvider>(context, listen: false)
        .getUserFavProduct('425', 'UpRnu2a66HOzCg6y6HijyQHExsrjG8s0G'),
        builder: (context, AsyncSnapshot<FavouriteModel> snapshot) {
          if(snapshot.hasData){
            print(snapshot.data.data.length);
          }
      return snapshot.hasData
          ?
          */ /*  :userid == null || userid.isEmpty
            ? DefaultUserProfile(
                istab: true,
              )*/ /*
          : Center(
              child: CircularProgressIndicator(),
            );
    });*/
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
        child: Banner(
          location: BannerLocation.topEnd,
          message: 'Sale',
          color: Colors.red.shade900,
          child: Container(
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
                  borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
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

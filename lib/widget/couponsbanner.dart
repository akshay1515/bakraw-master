import 'package:bakraw/GlobalWidget/GlobalWidget.dart';
import 'package:bakraw/model/couponsslidermodel.dart';
import 'package:bakraw/provider/couponsliderProvider.dart';
import 'package:bakraw/utils/GroceryConstant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Couponsslider extends StatefulWidget {
  @override
  _CouponssliderState createState() => _CouponssliderState();
}

class _CouponssliderState extends State<Couponsslider> {
  var isLoading = true;
  int current = 0;
  List<Data> sliderimg = [];
  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(isLoading) {
    Provider.of<couponslideProvider>(context,listen: false).getCategory().then((value) {
      setState(() {
        isLoading = false;
      });
    });
      final slider = Provider
          .of<couponslideProvider>(context, listen: false)
          .items
          .forEach((element) {
            setState(() {
              sliderimg.add(Data(
                  filePath: element.filePath,
                  couponId: element.couponId
              ));
            });

      });
    }

    return !isLoading
        ? Column(
      children: <Widget>[
        Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(
                top: spacing_standard_new,
                left: spacing_standard_new,
                right: spacing_standard_new,
                bottom: spacing_standard),
            child: Container(
                width: MediaQuery.of(context).size.width/2.5,
                height: MediaQuery.of(context).size.height/20,
                child: Image.asset('images/bannerimage/Coupons.png',fit: BoxFit.contain,))
    ),
        CarouselSlider(
            options: CarouselOptions(
              viewportFraction: 0.7,
              height: MediaQuery.of(context).size.height / 4,
              initialPage: 0,
              enableInfiniteScroll: false,
              autoPlay: false,
              autoPlayInterval: Duration(seconds: 3),
            ),
            items: sliderimg.map((e) {
              return Builder(builder: (BuildContext context) {
                return GestureDetector(
                  onTap: () {
                  },
                  child: AspectRatio(
                    aspectRatio: MediaQuery.of(context).orientation ==
                        Orientation.portrait
                        ? 4 / 3
                        : 3 / 4,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: CachedNetworkImage(
                        imageUrl: e.filePath,
                        width: MediaQuery.of(context).size.width/2,
                        height: MediaQuery.of(context).size.height / 6,
                        fit: BoxFit.fill,
                        placeholder: placeholderWidgetFn(),
                      ),
                    ),
                  ),
                );
              });
            }).toList())
      ],
    )
        : Container();
  }
}

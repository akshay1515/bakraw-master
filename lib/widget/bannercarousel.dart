import 'package:bakraw/GlobalWidget/GlobalWidget.dart';
import 'package:bakraw/provider/sliderprovider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BannerSlider extends StatefulWidget {
  @override
  _BannerSliderState createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  var isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int current = 0;
    Provider.of<SliderProvider>(context).getCategory().then((value) {
      isLoading = false;
    });
    List<String> sliderimg = [];

    final slider = Provider.of<SliderProvider>(context, listen: false)
        .items
        .forEach((element) {
      setState(() {
        sliderimg.add(element.image);
      });
    });

    return !isLoading
        ? Column(
            children: <Widget>[
              CarouselSlider(
                  options: CarouselOptions(
                    viewportFraction: 0.95,
                    height: MediaQuery.of(context).size.height / 3.5,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                  ),
                  items: sliderimg.map((e) {
                    return Builder(builder: (BuildContext context) {
                      return Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width / 100,
                            vertical: 5),
                        height: MediaQuery.of(context).size.height / 4,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: CachedNetworkImage(
                            imageUrl: e,
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height / 4,
                            fit: BoxFit.fill,
                            placeholder: placeholderWidgetFn(),
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

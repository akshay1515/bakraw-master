import 'package:bakraw/GlobalWidget/GlobalWidget.dart';
import 'package:bakraw/model/couponsslidermodel.dart';
import 'package:bakraw/provider/couponprovider.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CouponSlider extends StatefulWidget {
  @override
  _CouponSliderState createState() => _CouponSliderState();
}

class _CouponSliderState extends State<CouponSlider> {
  var isLoading = true;

  @override
  void initState() {
    Provider.of<CouponProvider>(context, listen: false)
        .getCoupons()
        .then((value) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Data> sliderimg = [];

    sliderimg = Provider.of<CouponProvider>(context).items.cast<Data>();

    return !isLoading
        ? sliderimg.length > 0
            ? Container(
                color: Colors.green.shade50.withOpacity(1.0),
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(bottom: 80, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, bottom: 4),
                      child: Text(
                        'Coupons',
                        style: TextStyle(
                            color: grocery_colorPrimary,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 200,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: sliderimg.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, index) {
                            return Container(
                              height: 175,
                              width: 175,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 5,
                                        spreadRadius: 2),
                                  ],
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(5),
                                  )),
                              margin: EdgeInsets.only(
                                  left: 10, right: 10, bottom: 40),
                              child: ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(5),
                                ),
                                child: CachedNetworkImage(
                                  placeholder: placeholderWidgetFn(),
                                  imageUrl: sliderimg[index].filePath,
                                  fit: BoxFit.fill,
                                  height: 175,
                                  width: 175,
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              )
            : Container(
                color: Colors.green.shade50.withOpacity(1.0),
                width: MediaQuery.of(context).size.width,
                height: 90)
        : Container();
  }
}

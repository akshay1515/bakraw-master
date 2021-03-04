import 'dart:ui';

import 'package:bakraw/screen/searchscreen.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:bakraw/widget/bannercarousel.dart';
import 'package:bakraw/widget/bestsellingproduct.dart';
import 'package:bakraw/widget/horizontallist.dart';
import 'package:bakraw/widget/previousorderscreen.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class NewHomepage extends StatefulWidget {
  static String Tag = '/newDashboard';

  List<String> title = [
    'Hygenic',
    'Fresh',
    'Traceable',
    'Farm to Fork',
    'Free Delivery'
  ];
  List<String> imageList = [
    'images/newicons/hygeniccolor.png',
    'images/newicons/freshwhite.png',
    'images/newicons/traceablewhite.png',
    'images/newicons/farmforkwhite.png',
    'images/newicons/freedeliverywhite.png'
  ];



  @override
  _NewHomepageState createState() => _NewHomepageState();
}

class _NewHomepageState extends State<NewHomepage> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(
      children: [
        //------------------------HomePage Designs--------------------------------------------
        SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 250,
                    child: BannerSlider(),
                  ),
                  Container(
                      height: 190,
                      width: double.infinity,
                      color: Color.fromRGBO(51, 105, 30, 1)),
                  Container(
                    height: 280,
                    width: double.infinity,
                    color: Colors.green.shade50.withOpacity(1.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            left: 10,
                          ),
                          margin:
                              EdgeInsets.only(top: 10, left: 10, bottom: 10),
                          child: Text(
                            'Bestseller',
                            style: TextStyle(
                                color: grocery_colorPrimary,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(child: BestSelling()),
                      ],
                    ),
                  ),
                  Container(
                    height: 355,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            left: 10,
                          ),
                          margin:
                              EdgeInsets.only(top: 10, left: 10, bottom: 10),
                          child: Text(
                            'All Meat',
                            style: TextStyle(
                                color: grocery_colorPrimary,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(child: PreviousOrder()),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(50)),
                    margin: EdgeInsets.only(top: 220),
                    height: 55,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      child: TextFormField(
                        controller: searchController,
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
                                    if(searchController.text.trim() != null || searchController.text.trim().isNotEmpty) {
                                      String text = searchController.text.trim();
                                      searchController.clear();
                                      Navigator.of(context).pushNamed(
                                          SearchScreen.Tag,arguments: {
                                            'word': text
                                          });
                                    }
                                  }),
                            )),
                      ),
                    ),
                  ),
                  Container(
                    child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: widget.title.length,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate:
                            new SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: widget.title.length),
                        itemBuilder: (context, index) {
                          return index < 1
                              ? Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            color: grocery_colorPrimary_light,
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: Center(
                                          child: Container(
                                              child: Image.asset(
                                            widget.imageList[index],
                                                width: 30,
                                                height: 30,
                                                fit: BoxFit.contain,
                                          )),
                                        ),
                                      ),
                                      Text(
                                        widget.title[index],
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      )
                                    ],
                                  ))
                              : Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height:50,
                                        width:50,

                                        child: DottedBorder(
                                          borderType: BorderType.Circle,
                                          color: Colors.white,
                                          strokeWidth: 1,
                                          padding: EdgeInsets.all(3),
                                          child: Center(
                                            child: Container(
                                                child:Image.asset(
                                                  widget.imageList[index],
                                                  height: 30,
                                                  width:30,
                                                  fit: BoxFit.contain,
                                                )),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        widget.title[index],
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      )
                                    ],
                                  ));
                        }),
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
            ],
          ),
        ),
      ],
    ));
  }
}

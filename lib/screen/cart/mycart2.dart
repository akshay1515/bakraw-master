import 'package:bakraw/GlobalWidget/GlobalWidget.dart';
import 'package:bakraw/inherited/cart/cart_container.dart';
import 'package:bakraw/screen/cart/widgets/cart_products_list.dart';
import 'package:bakraw/screen/cart/widgets/fitted_box_widget.dart';
import 'package:bakraw/screen/cart/widgets/sub_total_widget.dart';
import 'package:bakraw/screen/dashboard.dart';
import 'package:bakraw/screen/newui/newhomepage.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:bakraw/utils/GroceryConstant.dart';
import 'package:bakraw/widget/horizontallist.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../searchscreen.dart';

class Mycart2 extends StatefulWidget {
  static const tag = '/mycart';

  @override
  _MycartState2 createState() => _MycartState2();
}

class _MycartState2 extends State<Mycart2> {

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
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    changeStatusColor(grocery_colorPrimary);
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
        child: Scaffold(
          body: CartContainer(
            child: SingleChildScrollView(
              child: Column(

                children: <Widget>[
                  Stack(children: [
                    Column(
                      children: [
                        Container(
                            height: 210,
                            width: double.infinity,
                            color: Color.fromRGBO(51, 105, 30, 1)),

                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(50)),
                          margin: EdgeInsets.only(top: 40),
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
                    Container(
                      child: GridView.builder(
                          shrinkWrap: true,
                          itemCount: title.length,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                          new SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: title.length),
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
                                              imageList[index],
                                              width: 30,
                                              height: 30,
                                              fit: BoxFit.contain,
                                            )),
                                      ),
                                    ),
                                    Text(
                                      title[index],
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
                                                imageList[index],
                                                height: 30,
                                                width:30,
                                                fit: BoxFit.contain,
                                              )),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      title[index],
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    )
                                  ],
                                ));
                          }),
                    ),
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 180),
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
                      ],
                    ),                   ],),
                  SizedBox(height: spacing_standard_new),
                  CartProductsList(),
                  Container(
                    padding: EdgeInsets.all(spacing_standard_new),
                    margin: EdgeInsets.only(bottom: 80),
                    width: width,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: grocery_ShadowColor,
                            blurRadius: 10,
                            spreadRadius: 3)
                      ],
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(spacing_middle),
                          bottomLeft: Radius.circular(spacing_middle)),
                      color: grocery_color_white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: <Widget>[
                            SubTotalWidget(),
                            SizedBox(height: spacing_control),
                            SizedBox(height: spacing_standard_new),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right:15),
                          child: FittedBoxWidget(),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        onWillPop: (){
          Navigator.of(context).pushReplacementNamed(NewHomepage.Tag,arguments: {'id':0});
        });


  }
}
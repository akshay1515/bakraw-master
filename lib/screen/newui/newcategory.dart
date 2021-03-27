import 'package:bakraw/provider/categoryprovider.dart';
import 'package:bakraw/screen/searchscreen.dart';
import 'package:bakraw/screen/categoryproduct.dart';
import 'package:bakraw/screen/newui/newhomepage.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:bakraw/widget/horizontallist.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewCategory extends StatefulWidget {
  static const TAG = '/newCategory';
  @override
  _NewCategoryState createState() => _NewCategoryState();
}

class _NewCategoryState extends State<NewCategory> {
  List<String> title = [
    'Hygenic',
    'Fresh',
    'Traceable',
    'Farm to Fork',
    'Free Delivery'
  ];
  List<String> imageList = [
    'images/newicons/hygenicwhite.png',
    'images/newicons/freshwhite.png',
    'images/newicons/traceablewhite.png',
    'images/newicons/farmforkwhite.png',
    'images/newicons/freedeliverywhite.png'
  ];
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return WillPopScope(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                    height: 220,
                    width: double.infinity,
                    color: Color.fromRGBO(51, 105, 30, 1)),
              ],
            ),
            Column(
              children: [
                Container(
                  decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(50)),
                  margin: EdgeInsets.only(top: 50),
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
                   return Container(
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
            Container(
              margin: EdgeInsets.only(top: 218),
              color: Colors.green.shade50,
              height: 50,
              width: MediaQuery.of(context).size.width,
            ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 190),
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
                GrocerySubCategoryList()
              ],
            ),
          ],
        ),
        onWillPop: (){
          Provider.of<CategoryProvider>(context,listen: false).ChangeCategory("", 0);
          Navigator.of(context).pushReplacementNamed(NewHomepage.Tag,arguments: {'id':0});
        });
  }
}

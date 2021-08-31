import 'package:bakraw/screen/categoryproduct.dart';
import 'package:bakraw/screen/newui/newhomepage.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:bakraw/widget/bakrawproperties.dart';
import 'package:bakraw/widget/bottomnavigationbar.dart';
import 'package:bakraw/widget/horizontallist.dart';
import 'package:bakraw/widget/searchbar.dart';
import 'package:flutter/material.dart';

class NewCategory extends StatefulWidget {
  static const TAG = '/newCategory';

  @override
  _NewCategoryState createState() => _NewCategoryState();
}

class _NewCategoryState extends State<NewCategory> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final selected = ModalRoute.of(context).settings.arguments as Map;
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).popAndPushNamed(NewHomepage.Tag);
              }),
          title: Text(selected['name']),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      height: 220,
                      width: double.infinity,
                      color: Color.fromRGBO(51, 105, 30, 1)),
                ],
              ),
              Container(height: 100, child: BakrawUniqueness()),
              Container(
                height: MediaQuery.of(context).size.height - 300,
                color: Colors.green.shade50,
                margin: EdgeInsets.only(top: 210),
                child: Container(
                  margin: EdgeInsets.only(top: 25),
                  child: GrocerySubCategoryList(
                    selected: selected['selected'],
                  ),
                ),
              ),
              Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(50)),
                  margin: EdgeInsets.only(),
                  child: Searchbar(topmargin: 175)),
              Column(
                children: [
                  Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(50)),
                    margin: EdgeInsets.only(top: 30),
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
                      child: HorizontalScrollview(
                        selected: selected['selected'],
                      ))
                ],
              ),
              Positioned(
                  bottom: 0,
                  child: BottomNav(
                    currentScreen: 5,
                  ))
            ],
          ),
        ),
      ),
      onWillPop: () {
        Navigator.of(context)
            .pushReplacementNamed(NewHomepage.Tag, arguments: {'id': 0});
        return;
      },
    );
  }
}

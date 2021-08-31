import 'package:bakraw/model/categorymodel.dart';
import 'package:bakraw/provider/categoryprovider.dart';
import 'package:bakraw/screen/newui/newcategory.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HorizontalScrollview extends StatefulWidget {
  bool istrue = true;
  var selected;

  HorizontalScrollview({Key key, this.selected}) : super(key: key);

  @override
  _HorizontalScrollviewState createState() => _HorizontalScrollviewState();
}

class _HorizontalScrollviewState extends State<HorizontalScrollview> {
  var init = true;
  var count = 0;
  Future<CategoryModel> myfuture;
  @override
  void initState() {
    super.initState();
    myfuture =
        Provider.of<CategoryProvider>(context, listen: false).getCategories();
  }

  @override
  Widget build(BuildContext context) {
    final selectedcategory = Provider.of<CategoryProvider>(context).categoryid;

    final category = Provider.of<CategoryProvider>(context, listen: false);
    final categorydata = category.items;

    return FutureBuilder(
        future: myfuture,
        builder: (context, AsyncSnapshot<CategoryModel> snapshot) {
          return Container(
              height: 40,
              margin: EdgeInsets.only(top: 7),
              child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: categorydata.length,
                  scrollDirection: Axis.horizontal,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1, childAspectRatio: 1 / 3.25),
                  itemBuilder: (context, i) {
                    return Category(
                      imageLocation: categorydata[i].images[0].logo,
                      imageCaption: categorydata[i].name,
                      categoryId: categorydata[i].categoryId,
                      selected: widget.selected,
                      index: i,
                    );
                  }));
        });
  }
}

class Category extends StatelessWidget {
  final String imageLocation;
  final String imageCaption;
  final String categoryId;
  final int selected;
  final int index;

  Category({
    this.imageLocation,
    this.imageCaption,
    this.categoryId,
    this.selected,
    this.index,
  });

  String defaultimage =
      'https://cdn1.iconfinder.com/data/icons/food-5-7/128/Vigor_Food-Meat-Slice-Steak-Flesh-Red-Beef-512.png';

  @override
  Widget build(BuildContext context) {
    /*  final selectedcategory = Provider.of<CategoryProvider>(context).categoryid;*/

    return Padding(
      padding: const EdgeInsets.all(2),
      child: InkWell(
        onTap: () {
          Provider.of<CategoryProvider>(context, listen: false)
              .ChangeCategory(categoryId, selected);
          Navigator.of(context).popAndPushNamed(NewCategory.TAG,
              arguments: {'selected': index, 'name': imageCaption});
        },
        child: Container(
          height: selected == index ? 25 : 25,
          margin: EdgeInsets.symmetric(horizontal: 5),
          child: DottedBorder(
            padding: EdgeInsets.zero,
            dashPattern: [7, 5],
            color: Colors.white,
            strokeWidth: 0.5,
            borderType: BorderType.RRect,
            strokeCap: StrokeCap.round,
            radius: Radius.circular(40),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Container(
                decoration: BoxDecoration(
                  color: selected == index ? Colors.white : Colors.transparent,
                ),
                padding: EdgeInsets.zero,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        width: 40,
                        height: 50,
                        padding: EdgeInsets.only(
                            right: 7, top: 7, bottom: 7, left: 0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: selected == index
                                ? Colors.green.shade900
                                : grocery_colorPrimary_light,
                            border: Border.all(
                                color: Colors.transparent,
                                style: BorderStyle.none)),
                        child: Image.network(
                          imageLocation,
                          height: 40,
                          width: 40,
                          fit: BoxFit.contain,
                        )),
                    Container(
                      width: 65,
                      margin: EdgeInsets.only(bottom: 3, left: 5),
                      child: Text(
                        imageCaption,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color:
                              selected == index ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

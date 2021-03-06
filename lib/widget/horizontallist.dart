import 'package:bakraw/provider/categoryprovider.dart';
import 'package:bakraw/screen/newui/newhomepage.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HorizontalScrollview extends StatefulWidget {
  @override
  _HorizontalScrollviewState createState() => _HorizontalScrollviewState();
}

class _HorizontalScrollviewState extends State<HorizontalScrollview> {
  var init = true;

  List<String> categoryIcon = [
    'images/newicons/allmeatcolor.png',
    'images/newicons/meatcolor.png',
    'images/newicons/meatwithbonewhite.png'
  ];

  List<String> selectedIcon = [
    'images/newicons/allmeatwhite.png',
    'images/newicons/meatwhite.png',
    'images/newicons/meatwithbonecolor.png'
  ];

  @override
  Widget build(BuildContext context) {
    Provider.of<CategoryProvider>(context, listen: false).getCategories();
    final selectedcategory = Provider
        .of<CategoryProvider>(context)
        .categoryid;

    final category = Provider.of<CategoryProvider>(context);
    final categorydata = category.items;


    return Container(
      height: 40,
      margin: EdgeInsets.only(top: 7),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categorydata.length,
        itemBuilder: (BuildContext ctx, int i) {
          return Category(
            imageLocation: categorydata[i].categoryId == selectedcategory
                ? selectedIcon[i]
                : categoryIcon[i],
            imageCaption: categorydata[i].name,
            categoryId: categorydata[i].categoryId,
          );
        },
      ),
    );
  }
}
class Category extends StatefulWidget {

  final String imageLocation;
  final String imageCaption;
  final String categoryId;

  Category({
    this.imageLocation,
    this.imageCaption,
    this.categoryId,
  });

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  String defaultimage =
      'https://cdn1.iconfinder.com/data/icons/food-5-7/128/Vigor_Food-Meat-Slice-Steak-Flesh-Red-Beef-512.png';



  @override
  Widget build(BuildContext context) {

    final selectedcategory = Provider.of<CategoryProvider>(context).categoryid;

    return Padding(
      padding: const EdgeInsets.all(2),
      child: InkWell(
        onTap: () {
          Provider.of<CategoryProvider>(context,listen: false).ChangeCategory(widget.categoryId,3);
          Navigator.of(context).pushNamed(NewHomepage.Tag);
        },
        child: Container(
          height: selectedcategory == widget.categoryId?50:40,
          margin: EdgeInsets.symmetric(horizontal: 5),
          child: DottedBorder(
            padding: EdgeInsets.zero,
            dashPattern: [5,5],
            color: selectedcategory == widget.categoryId?Colors.transparent:Colors.white,
            borderType: BorderType.RRect,
            strokeCap: StrokeCap.square,
            radius: Radius.circular(50),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Container(
                padding: EdgeInsets.zero,
                color: selectedcategory == widget.categoryId?Colors.white:Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 40,
                      height: 40,
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color:selectedcategory==widget.categoryId?Colors.green.shade900: grocery_colorPrimary_light,
                    border: Border.all(color:Colors.transparent,style:BorderStyle.none)
                ),
                        child: Image.asset(widget.imageLocation,height: 20,width: 20,fit: BoxFit.contain,)
                      ),

                    Container(
                      width: 65,
                      margin: EdgeInsets.only(bottom: 3,left: 5),
                      child: Text(
                        widget.imageCaption,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: selectedcategory == widget.categoryId?Colors.black:Colors.white,),
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

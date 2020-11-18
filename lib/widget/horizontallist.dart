import 'package:bakraw/GlobalWidget/GlobalWidget.dart';
import 'package:bakraw/provider/categoryprovider.dart';
import 'package:bakraw/screen/categoryproduct.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HorizontalScrollview extends StatefulWidget {
  @override
  _HorizontalScrollviewState createState() => _HorizontalScrollviewState();
}

class _HorizontalScrollviewState extends State<HorizontalScrollview> {
  var init = true;
  @override
  Widget build(BuildContext context) {
    Provider.of<CategoryProvider>(context, listen: false).getCategories();
    final category = Provider.of<CategoryProvider>(context);
    final categorydata = category.items;

    return Container(
      height: MediaQuery.of(context).size.height / 4.75,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categorydata.length,
        itemBuilder: (BuildContext ctx, int i) {
          return Category(
            imageLocation: categorydata[i].images[0].logo,
            imageCaption: categorydata[i].name,
            categoryId: categorydata[i].categoryId,
          );
        },
      ),
    );
  }

  @override
  void didChangeDependencies() {
    if (init) {}
    init = false;
  }
}

class Category extends StatelessWidget {
  final String imageLocation;
  final String imageCaption;
  final String categoryId;
  String defaultimage =
      'https://cdn1.iconfinder.com/data/icons/food-5-7/128/Vigor_Food-Meat-Slice-Steak-Flesh-Red-Beef-512.png';
  Category({
    this.imageLocation,
    this.imageCaption,
    this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              shadowColor: Colors.grey.shade100,
              elevation: 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(GrocerySubCategoryList.tag,
                        arguments: {'catid': categoryId, 'name': imageCaption});
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      height: MediaQuery.of(context).size.height * 0.15,
                      decoration: BoxDecoration(),
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                padding: EdgeInsets.zero,
                                width: MediaQuery.of(context).size.width * 0.25,
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                decoration: BoxDecoration(

                                    /*image: DecorationImage(
                                  fit: BoxFit.fitWidth,
                                  image: NetworkImage(imageLocation,),),*/
                                    ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    imageUrl: imageLocation.isNotEmpty
                                        ? imageLocation
                                        : defaultimage,
                                    fit: BoxFit.contain,
                                    placeholder: placeholderWidgetFn(),
                                    errorWidget: (context, url, error) =>
                                        new Icon(Icons.error),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 3),
                              child: Text(
                                imageCaption,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )),
        ),
      ),
    );
  }
}

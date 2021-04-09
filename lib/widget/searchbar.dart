import 'package:bakraw/screen/searchscreen.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:flutter/material.dart';

class Searchbar extends StatelessWidget {
  final double topmargin;
  TextEditingController searchController = TextEditingController();

  Searchbar({Key key, @required this.topmargin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
      margin: EdgeInsets.only(top: topmargin),
      height: 55,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
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
                      if (searchController.text.trim() != null ||
                          searchController.text.trim().isNotEmpty) {
                        String text = searchController.text.trim();
                        searchController.clear();
                        Navigator.of(context).pushNamed(SearchScreen.Tag,
                            arguments: {'word': text});
                      }
                    }),
              )),
        ),
      ),
    );
  }
}

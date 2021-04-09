import 'package:bakraw/GlobalWidget/GlobalWidget.dart';
import 'package:bakraw/model/useraddressmodel.dart' as da;
import 'package:bakraw/screen/checkpincode.dart';
import 'package:bakraw/screen/editadduseraddress.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:bakraw/utils/GroceryConstant.dart';
import 'package:flutter/material.dart';

class AddressListWidget extends StatelessWidget {
  final int index;
  final da.Data list;
  final bool isnav;
  final mobile;

  const AddressListWidget(
      {Key key, this.index, this.list, this.isnav, this.mobile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    editAddress(da.Data model, bool isnav) async {
      var bool = await Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => EditUserAddress(
                        model: model,
                        isnav: isnav,
                      ))) ??
          false;
      if (bool) {}
    }

    return GestureDetector(
      onTap: () {
        if (isnav) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CheckPincode(model: list)));
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: spacing_standard_new),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          shadowColor: Colors.black54,
          color: Colors.white.withOpacity(0.8),
          elevation: 5,
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Wrap(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: BoxDecoration(
                    color: grocery_colorPrimary,
                  ),
                  child: Row(
                    children: [
                      Container(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.home_rounded,
                            color: Colors.white,
                          )),
                      Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width - 64,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width - 125,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width -
                                          100,
                                      child: Text(
                                        '${list.firstName} ${list.lastName}',
                                        softWrap: true,
                                        style: TextStyle(
                                            color: grocery_textColorPrimary,
                                            fontSize: textSizeLargeMedium,
                                            fontFamily: fontMedium),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width -
                                          100,
                                      child: Text(
                                        '${list.address1} , ${list.address2}',
                                        softWrap: true,
                                        style: TextStyle(
                                          color: grocery_textColorPrimary,
                                          fontSize: textSizeMedium,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width -
                                          100,
                                      child: Text(
                                        '${list.city} , ${list.state}',
                                        softWrap: true,
                                        style: TextStyle(
                                          color: grocery_textColorPrimary,
                                          fontSize: textSizeMedium,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width -
                                          100,
                                      child: Text(
                                        '${list.country} , ${list.zip}',
                                        softWrap: true,
                                        style: TextStyle(
                                          color: grocery_textColorPrimary,
                                          fontSize: textSizeMedium,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width -
                                          100,
                                      child: Text(
                                        mobile != null
                                            ? 'Mob: ${mobile}'
                                            : 'NA',
                                        softWrap: true,
                                        style: TextStyle(
                                          color: grocery_textColorPrimary,
                                          fontSize: textSizeMedium,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              child: IconButton(
                                  icon: ImageIcon(
                                    AssetImage('images/newicons/editicon.png'),
                                    color: Colors.black,
                                    size: 27,
                                  ),
                                  tooltip: 'Edit Address',
                                  onPressed: () {
                                    editAddress(list, isnav);
                                  }),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

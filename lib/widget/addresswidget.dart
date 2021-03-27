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
      var bool = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => EditUserAddress(
                        model: model,
                        isnav: isnav,
                      ))) ??
          false;
      if (bool) {}
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: spacing_standard_new),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        shadowColor: Colors.black54,
        color: Colors.white.withOpacity(0.8),
        elevation: 5,
        margin: EdgeInsets.only(left: 10, right: 10),
        child: Wrap(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: 160,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                text('${list.firstName} ${list.lastName}',
                                    textColor: grocery_textColorPrimary,
                                    fontFamily: fontMedium,
                                    fontSize: textSizeLargeMedium),
                                text(
                                    '${list.address1} ${'\n'} ${list.address2}',
                                    textColor: grocery_textColorPrimary,
                                    fontSize: textSizeMedium),
                                text('${list.city} , ${list.state}',
                                    textColor: grocery_textColorPrimary,
                                    fontSize: textSizeMedium),
                                text('${list.country} , ${list.zip}',
                                    textColor: grocery_textColorPrimary,
                                    fontSize: textSizeMedium),
                                SizedBox(
                                  height: 5,
                                ),
                                text(mobile != null ? 'Mob: ${mobile}' : 'NA',
                                    textColor: grocery_textColorPrimary,
                                    fontSize: textSizeMedium),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                transform: Matrix4.translationValues(
                                    isnav ? 25 : 0, 0, 0),
                                child: IconButton(
                                    icon: ImageIcon(
                                      AssetImage(
                                          'images/newicons/editicon.png'),
                                      color: Colors.black,
                                      size: 27,
                                    ),
                                    tooltip: 'Edit Address',
                                    onPressed: () {
                                      editAddress(list, isnav);
                                    }),
                              ),
                              isnav == true
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: grocery_colorPrimary,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        CheckPincode(
                                                            model: list)));
                                          },
                                          child: Text('Deliver Here')),
                                    )
                                  : Container()
                            ],
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
    );
  }
}

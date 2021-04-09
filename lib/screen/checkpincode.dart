import 'package:bakraw/model/deliveryslotmodel.dart';
import 'package:bakraw/model/useraddressmodel.dart' as user;
import 'package:bakraw/provider/deliveryslotprovider.dart';
import 'package:bakraw/screen/shippingMethod.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:bakraw/utils/GroceryConstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckPincode extends StatefulWidget {
  user.Data model;

  CheckPincode({Key key, this.model}) : super(key: key);

  @override
  _CheckPincodeState createState() => _CheckPincodeState();
}

class _CheckPincodeState extends State<CheckPincode> {
  List<String> list = [];
  String deliveryslot;
  String Selected = '';

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: grocery_color_white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: Text(
          'Delivery Slot',
          style: TextStyle(color: grocery_color_white),
        ),
      ),
      body: FutureBuilder(
          future: Provider.of<DeliverySlotProvider>(context).getDeliverySlot(),
          builder: (BuildContext context,
              AsyncSnapshot<DeliverySlotModel> snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Please Select Delivery Slot',
                        style: TextStyle(
                            color: Colors.grey.shade800,
                            fontFamily: fontBold,
                            fontSize: textSizeMedium),
                      ),
                    ),
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data.data.length + 1,
                        shrinkWrap: true,
                        itemBuilder: (_, index) {
                          if (index < snapshot.data.data.length) {
                            return ExpansionTile(
                              title: Text(
                                snapshot.data.data[index].day,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: fontBold,
                                    fontSize: textSizeMedium),
                              ),
                              children: [
                                ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: snapshot
                                        .data.data[index].options.length,
                                    itemBuilder: (_, ind) {
                                      return snapshot.data.data[index].options
                                                  .length >
                                              0
                                          ? Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 8, horizontal: 8),
                                              child: GestureDetector(
                                                onTap: () {
                                                  if (snapshot.data.data[index]
                                                          .options[ind].value ==
                                                      Selected) {
                                                    setState(() {
                                                      Selected = '';
                                                    });
                                                  } else {
                                                    setState(() {
                                                      Selected = snapshot
                                                          .data
                                                          .data[index]
                                                          .options[ind]
                                                          .value;
                                                    });
                                                  }
                                                },
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        snapshot
                                                                    .data
                                                                    .data[index]
                                                                    .options[
                                                                        ind]
                                                                    .value ==
                                                                Selected
                                                            ? Icons.check_box
                                                            : Icons
                                                                .check_box_outline_blank_outlined,
                                                        color:
                                                            grocery_colorPrimary,
                                                      ),
                                                      Text(
                                                        snapshot
                                                            .data
                                                            .data[index]
                                                            .options[ind]
                                                            .title,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black87,
                                                            fontFamily:
                                                                fontSemiBold,
                                                            fontSize:
                                                                textSizeMedium),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Container(
                                              padding: EdgeInsets.all(8),
                                              child: Center(
                                                child: Text(
                                                    'No Slots avaliable For today please check slots for some other day.'),
                                              ),
                                            );
                                    })
                              ],
                            );
                          } else {
                            return Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              padding: EdgeInsets.symmetric(
                                  vertical: 08,
                                  horizontal:
                                      MediaQuery.of(context).size.width / 3),
                              child: FlatButton(
                                  onPressed: () {
                                    if (Selected != '') {
                                      /*ShippingMethod(widget.model, Selected)
                                          .launch(context);*/
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ShippingMethod(
                                                      widget.model, Selected)));
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                title: Text('No Slot Selected'),
                                                content: Text(
                                                  'Please Select Delivery Time',
                                                  textAlign: TextAlign.center,
                                                ),
                                                actions: <Widget>[
                                                  FlatButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text('Ok'))
                                                ],
                                              ));
                                    }
                                  },
                                  color: grocery_colorPrimary,
                                  child: Text(
                                    'Next',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: fontBold,
                                        fontSize: textSizeMedium),
                                  )),
                            );
                          }
                        }),
                  ],
                ),
              );
            }
          }),
    );
  }
}

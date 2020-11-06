import 'package:bakraw/model/useraddressmodel.dart';
import 'package:bakraw/provider/deliveryslotprovider.dart';
import 'package:bakraw/provider/pincodeprovider.dart';
import 'package:bakraw/screen/shippingMethod.dart';
import 'package:bakraw/screen/useraddresslist.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:bakraw/utils/GroceryConstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class CheckPincode extends StatefulWidget {
  addressData model;

  CheckPincode({Key key, this.model}) : super(key: key);
  @override
  _CheckPincodeState createState() => _CheckPincodeState();
}

class _CheckPincodeState extends State<CheckPincode> {
  bool pincodestatus = false;
  bool isLoading = true;
  List<String> list = [];
  String deliveryslot;

  @override
  void initState() {
    super.initState();
    if (isLoading) {
      Provider.of<DeliverySlotProvider>(context, listen: false)
          .getDeliverySlot()
          .then((value) {
        if (value.status == 200) {
          value.data.forEach((element) {
            list.add(element);
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading)
      Provider.of<PincodeProvider>(context, listen: false)
          .checkpincodestatus(widget.model.shippingZip)
          .then((value) {
        if (value.status == 200) {
          pincodestatus = value.data.pincodeDeliveryStatus.allowDelivery;
        }
        deliveryslot =
            Provider.of<DeliverySlotProvider>(context, listen: false).value;
        setState(() {
          isLoading = false;
        });
      });

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
          'GoatMeat',
          style: TextStyle(color: grocery_color_white),
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : !pincodestatus
              ? showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text('Sorry......'),
                        content:
                            Text('We aren\'t avaliable at your location yet'),
                        actions: <Widget>[
                          FlatButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .popAndPushNamed(UserAddressManager.tag);
                              },
                              child: Text('Ok'))
                        ],
                      ))
              : Container(
                  child:
                      /*ListView.builder(
                    itemCount: list.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        child: SingleChildScrollView(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  child: Text(list[index]),
                                ),
                              )
                              */ /*Padding(
                            padding: ,
                          )*/ /*
                            ],
                          ),
                        ),
                      );
                    },
                  ),*/
                      Column(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          alignment: Alignment.center,
                          child: Text(
                            'Delivery Slots',
                            style: TextStyle(
                                fontSize: textSizeLarge,
                                fontFamily: fontMedium),
                          )),
                    ),
                    Expanded(
                      child: RadioListBuilder(
                        optionlist: list,
                        model: widget.model,
                      ),
                    ),
                  ],
                )),
    );
  }
}

class RadioListBuilder extends StatefulWidget {
  List<String> optionlist;
  addressData model;

  RadioListBuilder({Key key, this.optionlist, this.model}) : super(key: key);

  @override
  _RadioListBuilderState createState() => _RadioListBuilderState();
}

class _RadioListBuilderState extends State<RadioListBuilder> {
  var samp;
  SelectedRadio(String val) {
    setState(() {
      selectedValue = val;
    });
    Provider.of<DeliverySlotProvider>(context, listen: false)
        .UpdateOptionValue(val)
        .then((value) {
      ShippingMethod(widget.model, selectedValue).launch(context);
    });
  }

  @override
  void dispose() {
    this.dispose();
  }

  var selectedValue;
  var sOptionPrice;
  var sOptionLable;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: widget.optionlist.length,
      itemBuilder: (context, index) {
        return SizedBox(
          width: MediaQuery.of(context).size.width / 2.3,
          child: RadioListTile(
              toggleable: false,
              controlAffinity: ListTileControlAffinity.platform,
              dense: true,
              title: Text(
                widget.optionlist[index],
                style: TextStyle(
                    fontFamily: fontMedium,
                    fontSize: MediaQuery.of(context).size.width / 23),
              ),
              value: widget.optionlist[index],
              groupValue: selectedValue,
              onChanged: (val) {
                SelectedRadio(selectedValue = val);
              }),
        );
      },
    );
  }
}

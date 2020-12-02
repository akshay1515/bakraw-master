import 'package:bakraw/model/deliveryslotmodel.dart';
import 'package:bakraw/model/useraddressmodel.dart';
import 'package:bakraw/provider/deliveryslotprovider.dart';
import 'package:bakraw/screen/shippingMethod.dart';
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
  List<String> list = [];
  String deliveryslot;

  @override
  void initState() {
    super.initState();
  }

  /*Future<List<String>> getDeliverySlot() async {
    Provider.of<DeliverySlotProvider>(context).getDeliverySlot().then((value) {
        value.data.forEach((element) {
          list.add(element);
        });
      return list;
    });
  }*/

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
              return Container(
                  child: Column(
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
                              fontSize: textSizeLarge, fontFamily: fontMedium),
                        )),
                  ),
                  Expanded(
                    child: RadioListBuilder(
                      optionlist: snapshot.data.data,
                      model: widget.model,
                    ),
                  ),
                ],
              ));
            }
          }),
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

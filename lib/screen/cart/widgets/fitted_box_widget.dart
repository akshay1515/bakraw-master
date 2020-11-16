import 'package:bakraw/inherited/cart/cart_container.dart';
import 'package:bakraw/inherited/cart/cart_container_state.dart';
import 'package:bakraw/screen/dashboaruderprofile.dart';
import 'package:bakraw/screen/useraddresslist.dart';
import 'package:bakraw/utils/GeoceryStrings.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:bakraw/utils/GroceryWidget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nb_utils/nb_utils.dart';


class FittedBoxWidget extends StatefulWidget {
  FittedBoxWidgetState createState()=>FittedBoxWidgetState();
}

class FittedBoxWidgetState extends State<FittedBoxWidget>{
  String email='';
  double subTotal=0.0;

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    CartContainerState state=CartContainer.of(context);
    subTotal=state.subtotal;
    email=state.email;
  }

  Widget build(BuildContext context){
    CartContainerState state=CartContainer.of(context);
    subTotal=state.subtotal;
    email=state.email;
    return FittedBox(
      child: groceryButton(
        bgColors: grocery_colorPrimary,
        textContent: grocery_lbl_checkout,
        onPressed: (() {
          !email.isEmptyOrNull
              ? subTotal <= 0
              ? Fluttertoast.showToast(
              msg: 'Your cart is Empty',
              toastLength: Toast.LENGTH_SHORT)
              : Navigator.of(context).pushNamed(
              UserAddressManager.tag,
              arguments: {'isnav': true})
              : DefaultUserProfile(
            istab: false,
          ).launch(context);
        }),
      ),
    );
  }
}
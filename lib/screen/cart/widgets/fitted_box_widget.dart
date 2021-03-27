import 'package:bakraw/inherited/cart/cart_container.dart';
import 'package:bakraw/inherited/cart/cart_container_state.dart';
import 'package:bakraw/screen/newui/newhomepage.dart';
import 'package:bakraw/screen/useraddresslist.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FittedBoxWidget extends StatefulWidget {
  FittedBoxWidgetState createState() => FittedBoxWidgetState();
}

class FittedBoxWidgetState extends State<FittedBoxWidget> {
  String email = '';
  double subTotal = 0.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    CartContainerState state = CartContainer.of(context);
    subTotal = state.subtotal;
    email = state.email;
  }

  Widget build(BuildContext context) {
    CartContainerState state = CartContainer.of(context);
    subTotal = state.subtotal;
    email = state.email;
    return FittedBox(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: RaisedButton(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          color: grocery_colorPrimary,
          child: Text(
            'Checkout',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          onPressed: (() {
            email != null || email.isNotEmpty
                ? subTotal < 1
                    ? Fluttertoast.showToast(
                        msg: 'Your cart is Empty',
                        toastLength: Toast.LENGTH_SHORT)
                    : Navigator.of(context).pushNamed(UserAddressManager.tag,
                        arguments: {'isnav': true})
                : Navigator.of(context)
                    .pushNamed(NewHomepage.Tag, arguments: {'id': 4});
          }),
        ),
      ),
    );
  }
}

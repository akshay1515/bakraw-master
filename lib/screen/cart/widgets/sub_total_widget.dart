import 'package:bakraw/GlobalWidget/GlobalWidget.dart';
import 'package:bakraw/inherited/cart/cart_container.dart';
import 'package:bakraw/inherited/cart/cart_container_state.dart';
import 'package:bakraw/utils/GeoceryStrings.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:bakraw/utils/GroceryConstant.dart';
import 'package:flutter/material.dart';

class SubTotalWidget extends StatefulWidget {
  SubTotalWidgetState createState() => SubTotalWidgetState();
}

class SubTotalWidgetState extends State<SubTotalWidget> {
  CartContainerState state;
  double subTotal = 0.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    state = CartContainer.of(context);
  }

  Widget build(BuildContext context) {
    state = CartContainer.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        text('${grocery_lbl_subtotal}${' '}${'(${state.count} items)'}'),
        text('₹ ${state.subtotal.toString()}',textColor: grocery_colorPrimary_light, fontFamily: fontMedium),
      ],
    );
  }
}

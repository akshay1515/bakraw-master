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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Text(
            '$grocery_lbl_subtotal${' '}${'(${state.count} items)'}',
            style: TextStyle(
                color: grocery_colorPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 17),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Container(
              height: 20,
              width: 10,
              padding: EdgeInsets.only(
                  left: spacing_standard, right: spacing_standard),
              decoration: BoxDecoration(
                  color: Colors.green.shade700,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50),
                      bottomRight: Radius.circular(50))),
              margin: EdgeInsets.only(right: spacing_middle),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                '₹ ${state.subtotal.toString()}',
                style: TextStyle(
                    color: Colors.green.shade700,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ],
        )
      ],
    );
  }
}

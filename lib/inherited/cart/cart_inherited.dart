import 'package:bakraw/inherited/cart/cart_container_state.dart';
import 'package:flutter/material.dart';

class CartInheritedWidget extends InheritedWidget{

  final CartContainerState state;
  CartInheritedWidget({
    Key key,
    @required Widget child,
    @required this.state,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(CartInheritedWidget old)=>true;
}
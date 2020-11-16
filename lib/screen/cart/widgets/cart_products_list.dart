import 'package:bakraw/inherited/cart/cart_container.dart';
import 'package:bakraw/inherited/cart/cart_container_state.dart';
import 'package:bakraw/model/carttoproductmodel.dart';
import 'package:bakraw/screen/cart/widgets/cart_item.dart';
import 'package:flutter/material.dart';

class CartProductsList extends StatefulWidget{
  CartProductsListState createState()=>CartProductsListState();
}

class CartProductsListState extends State<CartProductsList>{

  List<CartProductModel> cartProducts=[];

  void didChangeDependencies(){
    CartContainerState state=CartContainer.of(context);
    cartProducts=state.cartProductModel.values.toList();
  }

  Widget build(BuildContext context){
    cartProducts=CartContainer.of(context).cartProductModel.values.toList();

    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: cartProducts.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return CartItem(
            cartProducts[index].cartModel.id,
            cartProducts[index].cartModel.productid,
            cartProducts[index].cartModel.optionvalueId,
            cartProducts[index].cartModel.optionid,
            cartProducts[index].cartModel.optionname,
            cartProducts[index].cartModel.optionlable,
            cartProducts[index].cartModel.productpriceincreased,
            cartProducts[index].cartModel.price,
            cartProducts[index].cartModel.quantity,
            cartProducts[index].target[0]
        );
      },
    );
  }
}
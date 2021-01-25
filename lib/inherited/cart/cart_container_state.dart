import 'package:bakraw/databasehelper.dart';
import 'package:bakraw/inherited/cart/cart_container.dart';
import 'package:bakraw/inherited/cart/cart_inherited.dart';
import 'package:bakraw/model/carttoproductmodel.dart';
import 'package:bakraw/model/internalcart.dart';
import 'package:bakraw/model/productmodel.dart' as Data;
import 'package:bakraw/provider/productdetailprovider.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class CartContainerState extends State<CartContainer> {
  Map<String, CartProductModel> cartProductModel = {};
  List<CartsModel> rowlist = [];
  double subtotal = 0;
  int count = 0;
  String email = '';

  bool isinit = true;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getUserInfo();
    fetchCartItems();
  }

  Future<String> getUserInfo() async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    if (prefs != null) {
      setState(() {
        email = prefs.getString('id');
      });
    }
  }

  Future fetchCartItems() async {
    subtotal = 0.0;
    count = await DatabaseHelper.instance.getCount();
    rowlist = await DatabaseHelper.instance.getcartItems();

    if (isinit) {
      for (CartsModel element in rowlist) {
        Data.ProductModel model =
            await Provider.of<ProductProvider>(context, listen: false)
                .getProductDetails(element.productid);
        List<Data.Data> target = [];
        target.add(Data.Data(images: model.data.images, name: model.data.name));
        cartProductModel.putIfAbsent(
            element.optionvalueId, () => new CartProductModel(element, target));
      }
      subtotal = calculateSubTotal();
    }
    setState(() {
      isinit = false;
      isLoading = false;
    });
  }

  void updateCartPricing(String productId, String quantity) {
    setState(() {
      CartsModel model = cartProductModel[productId].cartModel;
      model.quantity = quantity;
      if (quantity == "0") cartProductModel.remove(productId);
      subtotal = calculateSubTotal();
    });
  }

  double calculateSubTotal() {
    List<CartProductModel> products = cartProductModel.values.toList();
    double totalCost = 0.0;
    for (int i = 0; i < products.length; i++) {
      double total = double.parse(products[i].cartModel.price);
      int qty = int.parse(products[i].cartModel.quantity);
      double productCost = total * qty;
      totalCost += productCost;
    }
    return totalCost;
  }

  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: Text("Loading"))
        : CartInheritedWidget(state: this, child: widget.child);
  }
}

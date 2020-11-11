import 'package:bakraw/model/productmodel.dart' as Data;

import 'addtocartmodel.dart';
import 'internalcart.dart';

class CartProductModel {
  CartsModel cartModel;
  List<Values> valuelist;
  List<ProductOptions> optionlist = [];
  List<Data.Data> target = [];
  CartProductModel(
      this.cartModel, this.valuelist, this.optionlist, this.target);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (cartModel.id != null) {
      map['id'] = cartModel.id;
    }
    map['cartModel'] = cartModel;
    map['valuelist'] = valuelist;
    map['optionlist'] = optionlist;
    map['target'] = target;

    return map;
  }

  CartProductModel.fromMapObject(Map<String, dynamic> map) {
    dynamic val = map['valuelist'];
    for (int i = 0; i < val.size(); i++) {
      this.valuelist.add(Values.fromJson(val[i]));
    }

    dynamic options = map['optionlist'];
    for (int i = 0; i < options.size(); i++) {
      this.optionlist.add(ProductOptions.fromJson(options[i]));
    }

    dynamic target = map['target'];
    for (int i = 0; i < target.size(); i++) {
      this.target.add(Data.Data.fromJson(target[i]));
    }
    this.cartModel = CartsModel.fromMapObject(map['cartModel']);
  }
}

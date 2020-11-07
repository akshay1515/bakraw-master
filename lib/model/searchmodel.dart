class SearchModel {
  int status;
  String message;
  List<Data> data;

  SearchModel({this.status, this.message, this.data});

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String productId;
  String price;
  String specialPrice;
  String specialPriceType;
  String sku;
  String manageStock;
  String qty;
  String inStock;
  String name;
  String shortDescription;
  List<String> images;
  bool isProductNew;
  bool isProductHasSpecialPrice;
  bool isProductIsInSale;

  Data(
      {this.productId,
      this.price,
      this.specialPrice,
      this.specialPriceType,
      this.sku,
      this.manageStock,
      this.qty,
      this.inStock,
      this.name,
      this.shortDescription,
      this.images,
      this.isProductNew,
      this.isProductHasSpecialPrice,
      this.isProductIsInSale});

  Data.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    price = json['price'];
    specialPrice = json['special_price'];
    specialPriceType = json['special_price_type'];
    sku = json['sku'];
    manageStock = json['manage_stock'];
    qty = json['qty'];
    inStock = json['in_stock'];
    name = json['name'];
    shortDescription = json['short_description'];
    images = json['images'].cast<String>();
    isProductNew = json['is_product_new'];
    isProductHasSpecialPrice = json['is_product_has_special_price'];
    isProductIsInSale = json['is_product_is_in_sale'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['price'] = this.price;
    data['special_price'] = this.specialPrice;
    data['special_price_type'] = this.specialPriceType;
    data['sku'] = this.sku;
    data['manage_stock'] = this.manageStock;
    data['qty'] = this.qty;
    data['in_stock'] = this.inStock;
    data['name'] = this.name;
    data['short_description'] = this.shortDescription;
    data['images'] = this.images;
    data['is_product_new'] = this.isProductNew;
    data['is_product_has_special_price'] = this.isProductHasSpecialPrice;
    data['is_product_is_in_sale'] = this.isProductIsInSale;
    return data;
  }
}

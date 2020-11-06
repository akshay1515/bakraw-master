class FlashsaleModel {
  int status;
  String message;
  List<Data> data;

  FlashsaleModel({this.status, this.message, this.data});

  FlashsaleModel.fromJson(Map<String, dynamic> json) {
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
  String saleId;
  String saleName;
  List<Products> products;

  Data({this.saleId, this.saleName, this.products});

  Data.fromJson(Map<String, dynamic> json) {
    saleId = json['sale_id'];
    saleName = json['sale_name'];
    if (json['products'] != null) {
      products = new List<Products>();
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sale_id'] = this.saleId;
    data['sale_name'] = this.saleName;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  String productId;
  String name;
  String shortDescription;
  List<String> images;
  bool isProductIsInSale;
  String endDate;
  String price;
  String qty;
  int sold;
  bool isProductOutOfStock;

  Products(
      {this.productId,
      this.name,
      this.shortDescription,
      this.images,
      this.isProductIsInSale,
      this.endDate,
      this.price,
      this.qty,
      this.sold,
      this.isProductOutOfStock});

  Products.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    name = json['name'];
    shortDescription = json['short_description'];
    images = json['images'].cast<String>();
    isProductIsInSale = json['is_product_is_in_sale'];
    endDate = json['end_date'];
    price = json['price'];
    qty = json['qty'];
    sold = json['sold'];
    isProductOutOfStock = json['is_product_out_of_stock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['name'] = this.name;
    data['short_description'] = this.shortDescription;
    data['images'] = this.images;
    data['is_product_is_in_sale'] = this.isProductIsInSale;
    data['end_date'] = this.endDate;
    data['price'] = this.price;
    data['qty'] = this.qty;
    data['sold'] = this.sold;
    data['is_product_out_of_stock'] = this.isProductOutOfStock;
    return data;
  }
}

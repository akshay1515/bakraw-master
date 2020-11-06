// To parse this JSON data, do
//
//     final categoryProduct = categoryProductFromJson(jsonString);

import 'dart:convert';

CategoryProduct categoryProductFromJson(String str) =>
    CategoryProduct.fromJson(json.decode(str));

String categoryProductToJson(CategoryProduct data) =>
    json.encode(data.toJson());

class CategoryProduct {
  CategoryProduct({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  List<Datum> data;

  factory CategoryProduct.fromJson(Map<String, dynamic> json) =>
      CategoryProduct(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.productId,
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
    this.isProductIsInSale,
    this.productSaleDetails,
  });
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
  dynamic productSaleDetails;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        productId: json["product_id"],
        price: json["price"],
        specialPrice: json["special_price"],
        specialPriceType: json["special_price_type"],
        sku: json["sku"],
        manageStock: json["manage_stock"],
        qty: json["qty"],
        inStock: json["in_stock"],
        name: json["name"],
        shortDescription: json["short_description"],
        images: List<String>.from(json["images"].map((x) => x)),
        isProductNew: json["is_product_new"],
        isProductHasSpecialPrice: json["is_product_has_special_price"],
        isProductIsInSale: json["is_product_is_in_sale"],
        productSaleDetails: json["product_sale_details"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "price": price,
        "special_price": specialPrice,
        "special_price_type": specialPriceType,
        "sku": sku,
        "manage_stock": manageStock,
        "qty": qty,
        "in_stock": inStock,
        "name": name,
        "short_description": shortDescription,
        "images": List<dynamic>.from(images.map((x) => x)),
        "is_product_new": isProductNew,
        "is_product_has_special_price": isProductHasSpecialPrice,
        "is_product_is_in_sale": isProductIsInSale,
        "product_sale_details": productSaleDetails,
      };
}

class ProductSaleDetailsClass {
  ProductSaleDetailsClass({
    this.saleId,
    this.saleProductId,
    this.inStock,
    this.productSalePrice,
    this.qty,
    this.sold,
  });

  String saleId;
  String saleProductId;
  bool inStock;
  String productSalePrice;
  String qty;
  int sold;

  factory ProductSaleDetailsClass.fromJson(Map<String, dynamic> json) =>
      ProductSaleDetailsClass(
        saleId: json["sale_id"],
        saleProductId: json["sale_product_id"],
        inStock: json["in_stock"],
        productSalePrice: json["product_sale_price"],
        qty: json["qty"],
        sold: json["sold"],
      );

  Map<String, dynamic> toJson() => {
        "sale_id": saleId,
        "sale_product_id": saleProductId,
        "in_stock": inStock,
        "product_sale_price": productSalePrice,
        "qty": qty,
        "sold": sold,
      };
}

// To parse this JSON data, do
//
//     final dbcarTmodel = dbcarTmodelFromJson(jsonString);

import 'dart:convert';

DbcarTmodel dbcarTmodelFromJson(String str) =>
    DbcarTmodel.fromJson(json.decode(str));

String dbcarTmodelToJson(DbcarTmodel data) => json.encode(data.toJson());

class DbcarTmodel {
  DbcarTmodel({
    this.userId,
    this.userEmail,
    this.userPhone,
    this.userFirstName,
    this.userLastName,
    this.billingFirstName,
    this.billingLastName,
    this.billingAddress1,
    this.billingAddress2,
    this.billingCity,
    this.billingState,
    this.billingZip,
    this.billingCountry,
    this.shippingFirstName,
    this.shippingLastName,
    this.shippingAddress1,
    this.shippingAddress2,
    this.shippingCity,
    this.shippingState,
    this.shippingZip,
    this.shippingCountry,
    this.subTotal,
    this.shippingMethod,
    this.shippingCost,
    this.couponId,
    this.discount,
    this.total,
    this.paymentMethod,
    this.currency,
    this.currencyRate,
    this.locale,
    this.status,
    this.deliverySlot,
    this.note,
    this.createdAt,
    this.updatedAt,
    this.orderProducts,
    this.taxDetails,
    this.transactionDetails,
  });

  int userId;
  String userEmail;
  String userPhone;
  String userFirstName;
  String userLastName;
  String billingFirstName;
  String billingLastName;
  String billingAddress1;
  String billingAddress2;
  String billingCity;
  String billingState;
  String billingZip;
  String billingCountry;
  String shippingFirstName;
  String shippingLastName;
  String shippingAddress1;
  String shippingAddress2;
  String shippingCity;
  String shippingState;
  String shippingZip;
  String shippingCountry;
  String subTotal;
  String shippingMethod;
  String shippingCost;
  String couponId;
  String discount;
  String total;
  String paymentMethod;
  String currency;
  String currencyRate;
  String locale;
  String status;
  String deliverySlot;
  String note;
  DateTime createdAt;
  DateTime updatedAt;
  List<OrderProduct> orderProducts;
  List<TaxDetail> taxDetails;
  TransactionDetails transactionDetails;

  factory DbcarTmodel.fromJson(Map<String, dynamic> json) => DbcarTmodel(
        userId: json["user_id"],
        userEmail: json["user_email"],
        userPhone: json["user_phone"],
        userFirstName: json["user_first_name"],
        userLastName: json["user_last_name"],
        billingFirstName: json["billing_first_name"],
        billingLastName: json["billing_last_name"],
        billingAddress1: json["billing_address_1"],
        billingAddress2: json["billing_address_2"],
        billingCity: json["billing_city"],
        billingState: json["billing_state"],
        billingZip: json["billing_zip"],
        billingCountry: json["billing_country"],
        shippingFirstName: json["shipping_first_name"],
        shippingLastName: json["shipping_last_name"],
        shippingAddress1: json["shipping_address_1"],
        shippingAddress2: json["shipping_address_2"],
        shippingCity: json["shipping_city"],
        shippingState: json["shipping_state"],
        shippingZip: json["shipping_zip"],
        shippingCountry: json["shipping_country"],
        subTotal: json["sub_total"],
        shippingMethod: json["shipping_method"],
        shippingCost: json["shipping_cost"],
        couponId: json["coupon_id"],
        discount: json["discount"],
        total: json["total"],
        paymentMethod: json["payment_method"],
        currency: json["currency"],
        currencyRate: json["currency_rate"],
        locale: json["locale"],
        status: json["status"],
        deliverySlot: json["delivery_slot"],
        note: json["note"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        orderProducts: List<OrderProduct>.from(
            json["order_products"].map((x) => OrderProduct.fromJson(x))),
        taxDetails: List<TaxDetail>.from(
            json["tax_details"].map((x) => TaxDetail.fromJson(x))),
        transactionDetails:
            TransactionDetails.fromJson(json["transaction_details"]),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user_email": userEmail,
        "user_phone": userPhone,
        "user_first_name": userFirstName,
        "user_last_name": userLastName,
        "billing_first_name": billingFirstName,
        "billing_last_name": billingLastName,
        "billing_address_1": billingAddress1,
        "billing_address_2": billingAddress2,
        "billing_city": billingCity,
        "billing_state": billingState,
        "billing_zip": billingZip,
        "billing_country": billingCountry,
        "shipping_first_name": shippingFirstName,
        "shipping_last_name": shippingLastName,
        "shipping_address_1": shippingAddress1,
        "shipping_address_2": shippingAddress2,
        "shipping_city": shippingCity,
        "shipping_state": shippingState,
        "shipping_zip": shippingZip,
        "shipping_country": shippingCountry,
        "sub_total": subTotal,
        "shipping_method": shippingMethod,
        "shipping_cost": shippingCost,
        "coupon_id": couponId,
        "discount": discount,
        "total": total,
        "payment_method": paymentMethod,
        "currency": currency,
        "currency_rate": currencyRate,
        "locale": locale,
        "status": status,
        "delivery_slot": deliverySlot,
        "note": note,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "order_products":
            List<dynamic>.from(orderProducts.map((x) => x.toJson())),
        "tax_details": List<dynamic>.from(taxDetails.map((x) => x.toJson())),
        "transaction_details": transactionDetails.toJson(),
      };
}

class OrderProduct {
  OrderProduct({
    this.productId,
    this.productName,
    this.unitPrice,
    this.qty,
    this.lineTotal,
    this.productOptions,
    this.isProductIsInSale,
  });

  String productId;
  String productName;
  String unitPrice;
  String qty;
  String lineTotal;
  List<ProductOption> productOptions;
  bool isProductIsInSale;

  factory OrderProduct.fromJson(Map<String, dynamic> json) => OrderProduct(
        productId: json["product_id"],
        productName: json["product_name"],
        unitPrice: json["unit_price"],
        qty: json["qty"],
        lineTotal: json["line_total"],
        productOptions: List<ProductOption>.from(
            json["product_options"].map((x) => ProductOption.fromJson(x))),
        isProductIsInSale: json["is_product_is_in_sale"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "product_name": productName,
        "unit_price": unitPrice,
        "qty": qty,
        "line_total": lineTotal,
        "product_options":
            List<dynamic>.from(productOptions.map((x) => x.toJson())),
        "is_product_is_in_sale": isProductIsInSale,
      };
}

class ProductOption {
  ProductOption({
    this.optionName,
    this.optionId,
    this.optionLabel,
    this.values,
  });

  String optionName;
  int optionId;
  String optionLabel;
  List<Value> values;

  factory ProductOption.fromJson(Map<String, dynamic> json) => ProductOption(
        optionName: json["option_name"],
        optionId: json["option_id"],
        optionLabel: json["option_label"],
        values: List<Value>.from(json["values"].map((x) => Value.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "option_name": optionName,
        "option_id": optionId,
        "option_label": optionLabel,
        "values": List<dynamic>.from(values.map((x) => x.toJson())),
      };
}

class Value {
  Value({
    this.optionValueId,
    this.increaseProductPriceBy,
  });

  int optionValueId;
  String increaseProductPriceBy;

  factory Value.fromJson(Map<String, dynamic> json) => Value(
        optionValueId: json["option_value_id"],
        increaseProductPriceBy: json["increase_product_price_by"],
      );

  Map<String, dynamic> toJson() => {
        "option_value_id": optionValueId,
        "increase_product_price_by": increaseProductPriceBy,
      };
}

class TaxDetail {
  TaxDetail({
    this.taxRateId,
    this.amount,
  });

  int taxRateId;
  String amount;

  factory TaxDetail.fromJson(Map<String, dynamic> json) => TaxDetail(
        taxRateId: json["tax_rate_id"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "tax_rate_id": taxRateId,
        "amount": amount,
      };
}

class TransactionDetails {
  TransactionDetails({
    this.transactionId,
    this.paymentMethod,
    this.createdAt,
    this.updatedAt,
  });

  String transactionId;
  String paymentMethod;
  String createdAt;
  String updatedAt;

  factory TransactionDetails.fromJson(Map<String, dynamic> json) =>
      TransactionDetails(
        transactionId: json["transaction_id"],
        paymentMethod: json["payment_method"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "transaction_id": transactionId,
        "payment_method": paymentMethod,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

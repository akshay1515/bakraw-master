class DbcarTmodel {
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
  String createdAt;
  String updatedAt;
  List<OrderProducts> orderProducts;
  List<TaxDetails> taxDetails;
  TransactionDetails transactionDetails;

  DbcarTmodel(
      {this.userId,
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
      this.transactionDetails});

  DbcarTmodel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userEmail = json['user_email'];
    userPhone = json['user_phone'];
    userFirstName = json['user_first_name'];
    userLastName = json['user_last_name'];
    billingFirstName = json['billing_first_name'];
    billingLastName = json['billing_last_name'];
    billingAddress1 = json['billing_address_1'];
    billingAddress2 = json['billing_address_2'];
    billingCity = json['billing_city'];
    billingState = json['billing_state'];
    billingZip = json['billing_zip'];
    billingCountry = json['billing_country'];
    shippingFirstName = json['shipping_first_name'];
    shippingLastName = json['shipping_last_name'];
    shippingAddress1 = json['shipping_address_1'];
    shippingAddress2 = json['shipping_address_2'];
    shippingCity = json['shipping_city'];
    shippingState = json['shipping_state'];
    shippingZip = json['shipping_zip'];
    shippingCountry = json['shipping_country'];
    subTotal = json['sub_total'];
    shippingMethod = json['shipping_method'];
    shippingCost = json['shipping_cost'];
    couponId = json['coupon_id'];
    discount = json['discount'];
    total = json['total'];
    paymentMethod = json['payment_method'];
    currency = json['currency'];
    currencyRate = json['currency_rate'];
    locale = json['locale'];
    status = json['status'];
    deliverySlot = json['delivery_slot'];
    note = json['note'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['order_products'] != null) {
      orderProducts = new List<OrderProducts>();
      json['order_products'].forEach((v) {
        orderProducts.add(new OrderProducts.fromJson(v));
      });
    }
    if (json['tax_details'] != null) {
      taxDetails = new List<TaxDetails>();
      json['tax_details'].forEach((v) {
        taxDetails.add(new TaxDetails.fromJson(v));
      });
    }
    transactionDetails = json['transaction_details'] != null
        ? new TransactionDetails.fromJson(json['transaction_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['user_email'] = this.userEmail;
    data['user_phone'] = this.userPhone;
    data['user_first_name'] = this.userFirstName;
    data['user_last_name'] = this.userLastName;
    data['billing_first_name'] = this.billingFirstName;
    data['billing_last_name'] = this.billingLastName;
    data['billing_address_1'] = this.billingAddress1;
    data['billing_address_2'] = this.billingAddress2;
    data['billing_city'] = this.billingCity;
    data['billing_state'] = this.billingState;
    data['billing_zip'] = this.billingZip;
    data['billing_country'] = this.billingCountry;
    data['shipping_first_name'] = this.shippingFirstName;
    data['shipping_last_name'] = this.shippingLastName;
    data['shipping_address_1'] = this.shippingAddress1;
    data['shipping_address_2'] = this.shippingAddress2;
    data['shipping_city'] = this.shippingCity;
    data['shipping_state'] = this.shippingState;
    data['shipping_zip'] = this.shippingZip;
    data['shipping_country'] = this.shippingCountry;
    data['sub_total'] = this.subTotal;
    data['shipping_method'] = this.shippingMethod;
    data['shipping_cost'] = this.shippingCost;
    data['coupon_id'] = this.couponId;
    data['discount'] = this.discount;
    data['total'] = this.total;
    data['payment_method'] = this.paymentMethod;
    data['currency'] = this.currency;
    data['currency_rate'] = this.currencyRate;
    data['locale'] = this.locale;
    data['status'] = this.status;
    data['delivery_slot'] = this.deliverySlot;
    data['note'] = this.note;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.orderProducts != null) {
      data['order_products'] =
          this.orderProducts.map((v) => v.toJson()).toList();
    }
    if (this.taxDetails != null) {
      data['tax_details'] = this.taxDetails.map((v) => v.toJson()).toList();
    }
    if (this.transactionDetails != null) {
      data['transaction_details'] = this.transactionDetails.toJson();
    }
    return data;
  }
}

class OrderProducts {
  String productId;
  String productName;
  String unitPrice;
  String qty;
  String lineTotal;
  List<ProductOptions> productOptions;
  bool isProductIsInSale;
  ProductSaleDetails productSaleDetails;

  OrderProducts(
      {this.productId,
      this.productName,
      this.unitPrice,
      this.qty,
      this.lineTotal,
      this.productOptions,
      this.isProductIsInSale,
      this.productSaleDetails});

  OrderProducts.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    unitPrice = json['unit_price'];
    qty = json['qty'];
    lineTotal = json['line_total'];
    if (json['product_options'] != null) {
      productOptions = new List<ProductOptions>();
      json['product_options'].forEach((v) {
        productOptions.add(new ProductOptions.fromJson(v));
      });
    }
    isProductIsInSale = json['is_product_is_in_sale'];
    productSaleDetails = json['product_sale_details'] != null
        ? new ProductSaleDetails.fromJson(json['product_sale_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['unit_price'] = this.unitPrice;
    data['qty'] = this.qty;
    data['line_total'] = this.lineTotal;
    if (this.productOptions != null) {
      data['product_options'] =
          this.productOptions.map((v) => v.toJson()).toList();
    }
    data['is_product_is_in_sale'] = this.isProductIsInSale;
    if (this.productSaleDetails != null) {
      data['product_sale_details'] = this.productSaleDetails.toJson();
    }
    return data;
  }
}

class ProductOptions {
  String optionName;
  int optionId;
  String optionLabel;
  List<Values> values;

  ProductOptions(
      {this.optionName, this.optionId, this.optionLabel, this.values});

  ProductOptions.fromJson(Map<String, dynamic> json) {
    optionName = json['option_name'];
    optionId = json['option_id'];
    optionLabel = json['option_label'];
    if (json['values'] != null) {
      values = new List<Values>();
      json['values'].forEach((v) {
        values.add(new Values.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['option_name'] = this.optionName;
    data['option_id'] = this.optionId;
    data['option_label'] = this.optionLabel;
    if (this.values != null) {
      data['values'] = this.values.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Values {
  int optionValueId;
  String increaseProductPriceBy;

  Values({this.optionValueId, this.increaseProductPriceBy});

  Values.fromJson(Map<String, dynamic> json) {
    optionValueId = json['option_value_id'];
    increaseProductPriceBy = json['increase_product_price_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['option_value_id'] = this.optionValueId;
    data['increase_product_price_by'] = this.increaseProductPriceBy;
    return data;
  }
}

class ProductSaleDetails {
  int saleProductId;

  ProductSaleDetails({this.saleProductId});

  ProductSaleDetails.fromJson(Map<String, dynamic> json) {
    saleProductId = json['sale_product_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sale_product_id'] = this.saleProductId;
    return data;
  }
}

class TaxDetails {
  int taxRateId;
  String amount;

  TaxDetails({this.taxRateId, this.amount});

  TaxDetails.fromJson(Map<String, dynamic> json) {
    taxRateId = json['tax_rate_id'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tax_rate_id'] = this.taxRateId;
    data['amount'] = this.amount;
    return data;
  }
}

class TransactionDetails {
  String transactionId;
  String paymentMethod;
  String createdAt;
  String updatedAt;

  TransactionDetails(
      {this.transactionId, this.paymentMethod, this.createdAt, this.updatedAt});

  TransactionDetails.fromJson(Map<String, dynamic> json) {
    transactionId = json['transaction_id'];
    paymentMethod = json['payment_method'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transaction_id'] = this.transactionId;
    data['payment_method'] = this.paymentMethod;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

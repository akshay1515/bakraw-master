class OrderDetailsModel {
  int status;
  String message;
  Data data;

  OrderDetailsModel({this.status, this.message, this.data});

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String orderId;
  String customerEmail;
  String customerPhone;
  String customerFirstName;
  String customerLastName;
  String subTotal;
  String shippingMethod;
  String shippingCost;
  String total;
  String paymentMethod;
  String deliverySlot;
  String status;
  String note;
  bool isOrderDeleted;
  String deletedAt;
  String createdAt;
  Coupon coupon;
  Address address;
  List<Products> products;
  List<TaxDetails> taxDetails;
  var transactionDetails;

  Data(
      {this.orderId,
      this.customerEmail,
      this.customerPhone,
      this.customerFirstName,
      this.customerLastName,
      this.subTotal,
      this.shippingMethod,
      this.shippingCost,
      this.total,
      this.paymentMethod,
      this.deliverySlot,
      this.status,
      this.note,
      this.isOrderDeleted,
      this.deletedAt,
      this.createdAt,
      this.coupon,
      this.address,
      this.products,
      this.taxDetails,
      this.transactionDetails});

  Data.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    customerEmail = json['customer_email'];
    customerPhone = json['customer_phone'];
    customerFirstName = json['customer_first_name'];
    customerLastName = json['customer_last_name'];
    subTotal = json['sub_total'];
    shippingMethod = json['shipping_method'];
    shippingCost = json['shipping_cost'];
    total = json['total'];
    paymentMethod = json['payment_method'];
    deliverySlot = json['delivery_slot'];
    status = json['status'];
    note = json['note'];
    isOrderDeleted = json['is_order_deleted'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    coupon =
        json['coupon'] != null ? new Coupon.fromJson(json['coupon']) : null;
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    if (json['products'] != null) {
      products = new List<Products>();
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
    if (json['tax_details'] != null) {
      taxDetails = new List<TaxDetails>();
      json['tax_details'].forEach((v) {
        taxDetails.add(new TaxDetails.fromJson(v));
      });
    }
    transactionDetails = json['transaction_details'].length > 0
        ? new TransactionDetails.fromJson(json['transaction_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['customer_email'] = this.customerEmail;
    data['customer_phone'] = this.customerPhone;
    data['customer_first_name'] = this.customerFirstName;
    data['customer_last_name'] = this.customerLastName;
    data['sub_total'] = this.subTotal;
    data['shipping_method'] = this.shippingMethod;
    data['shipping_cost'] = this.shippingCost;
    data['total'] = this.total;
    data['payment_method'] = this.paymentMethod;
    data['delivery_slot'] = this.deliverySlot;
    data['status'] = this.status;
    data['note'] = this.note;
    data['is_order_deleted'] = this.isOrderDeleted;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    if (this.coupon != null) {
      data['coupon'] = this.coupon.toJson();
    }
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
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

class Coupon {
  bool isCouponApplied;
  String discount;

  Coupon({this.isCouponApplied, this.discount});

  Coupon.fromJson(Map<String, dynamic> json) {
    isCouponApplied = json['is_coupon_applied'];
    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_coupon_applied'] = this.isCouponApplied;
    data['discount'] = this.discount;
    return data;
  }
}

class Address {
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

  Address(
      {this.billingFirstName,
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
      this.shippingCountry});

  Address.fromJson(Map<String, dynamic> json) {
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    return data;
  }
}

class Products {
  String id;
  String orderId;
  String productId;
  String unitPrice;
  String qty;
  String lineTotal;
  String name;
  String shortDescription;
  List<String> images;
  List<ProductOptions> productOptions;

  Products(
      {this.id,
      this.orderId,
      this.productId,
      this.unitPrice,
      this.qty,
      this.lineTotal,
      this.name,
      this.shortDescription,
      this.images,
      this.productOptions});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    productId = json['product_id'];
    unitPrice = json['unit_price'];
    qty = json['qty'];
    lineTotal = json['line_total'];
    name = json['name'];
    shortDescription = json['short_description'];
    images = json['images'].cast<String>();
    if (json['product_options'] != null) {
      productOptions = new List<ProductOptions>();
      json['product_options'].forEach((v) {
        productOptions.add(new ProductOptions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['product_id'] = this.productId;
    data['unit_price'] = this.unitPrice;
    data['qty'] = this.qty;
    data['line_total'] = this.lineTotal;
    data['name'] = this.name;
    data['short_description'] = this.shortDescription;
    data['images'] = this.images;
    if (this.productOptions != null) {
      data['product_options'] =
          this.productOptions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductOptions {
  String name;
  String value;

  ProductOptions({this.name, this.value});

  ProductOptions.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['value'] = this.value;
    return data;
  }
}

class TaxDetails {
  String taxRateId;
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
  String deletedAt;
  String createdAt;
  String updatedAt;

  TransactionDetails(
      {this.transactionId,
      this.paymentMethod,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  TransactionDetails.fromJson(Map<String, dynamic> json) {
    transactionId = json['transaction_id'];
    paymentMethod = json['payment_method'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transaction_id'] = this.transactionId;
    data['payment_method'] = this.paymentMethod;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}


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

class CartProducts {
  String productId;
  String unitPrice;
  String qty;
  String lineTotal;
  List<ProductOptions> productOptions;
  bool isProductIsInSale;
  ProductSaleDetails productSaleDetails;

  CartProducts(
      {this.productId,
        this.unitPrice,
        this.qty,
        this.lineTotal,
        this.productOptions,
        this.isProductIsInSale,
        this.productSaleDetails});

  CartProducts.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
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
  int optionId;
  String optionLabel;
  List<Values> values;

  ProductOptions({this.optionId, this.optionLabel, this.values});

  ProductOptions.fromJson(Map<String, dynamic> json) {
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
  String saleId;
  String saleProductId;
  String productSalePrice;

  ProductSaleDetails({this.saleId, this.saleProductId, this.productSalePrice});

  ProductSaleDetails.fromJson(Map<String, dynamic> json) {
    saleId = json['sale_id'];
    saleProductId = json['sale_product_id'];
    productSalePrice = json['product_sale_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sale_id'] = this.saleId;
    data['sale_product_id'] = this.saleProductId;
    data['product_sale_price'] = this.productSalePrice;
    return data;
  }
}
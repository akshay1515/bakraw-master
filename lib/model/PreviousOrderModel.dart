class PreviousOrderProduct {
  int status;
  String message;
  List<Data> data;

  PreviousOrderProduct({this.status, this.message, this.data});

  PreviousOrderProduct.fromJson(Map<String, dynamic> json) {
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
  var productSaleDetails;
  ProductRating productRating;

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
        this.isProductIsInSale,
        this.productSaleDetails,
        this.productRating});

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
    productSaleDetails = json['product_sale_details'].length > 0
        ? new ProductSaleDetails.fromJson(json['product_sale_details'])
        : null;
    productRating = json['product_rating'] != null
        ? new ProductRating.fromJson(json['product_rating'])
        : null;
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
    if (this.productSaleDetails != null) {
      data['product_sale_details'] = this.productSaleDetails.toJson();
    }
    if (this.productRating != null) {
      data['product_rating'] = this.productRating.toJson();
    }
    return data;
  }
}

class ProductSaleDetails {
  String saleId;
  String saleProductId;
  bool inStock;
  String productSalePrice;
  String qty;
  int sold;

  ProductSaleDetails(
      {this.saleId,
        this.saleProductId,
        this.inStock,
        this.productSalePrice,
        this.qty,
        this.sold});

  ProductSaleDetails.fromJson(Map<String, dynamic> json) {
    saleId = json['sale_id'];
    saleProductId = json['sale_product_id'];
    inStock = json['in_stock'];
    productSalePrice = json['product_sale_price'];
    qty = json['qty'];
    sold = json['sold'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sale_id'] = this.saleId;
    data['sale_product_id'] = this.saleProductId;
    data['in_stock'] = this.inStock;
    data['product_sale_price'] = this.productSalePrice;
    data['qty'] = this.qty;
    data['sold'] = this.sold;
    return data;
  }
}

class ProductRating {
  int totalReviewsCount;
  var avgRating;

  ProductRating({this.totalReviewsCount, this.avgRating});

  ProductRating.fromJson(Map<String, dynamic> json) {
    totalReviewsCount = json['total_reviews_count'];
    avgRating = json['avg_rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_reviews_count'] = this.totalReviewsCount;
    data['avg_rating'] = this.avgRating;
    return data;
  }
}

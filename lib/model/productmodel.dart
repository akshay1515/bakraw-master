class ProductModel {
  int status;
  String message;
  Data data;

  ProductModel({this.status, this.message, this.data});

  ProductModel.fromJson(Map<String, dynamic> json) {
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
  String productId;
  String price;
  String specialPrice;
  String specialPriceType;
  String specialPriceStart;
  String specialPriceEnd;
  String sellingPrice;
  String sku;
  String manageStock;
  String qty;
  String inStock;
  String name;
  String shortDescription;
  String description;
  List<Images> images;
  bool isProductNew;
  bool isProductHasSpecialPrice;
  List<ProductOptions> productOptions;
  bool isProductIsInSale;
  var productSaleDetails;
  ProductRating productRating;

  Data(
      {this.productId,
        this.price,
        this.specialPrice,
        this.specialPriceType,
        this.specialPriceStart,
        this.specialPriceEnd,
        this.sellingPrice,
        this.sku,
        this.manageStock,
        this.qty,
        this.inStock,
        this.name,
        this.shortDescription,
        this.description,
        this.images,
        this.isProductNew,
        this.isProductHasSpecialPrice,
        this.productOptions,
        this.isProductIsInSale,
        this.productSaleDetails,
        this.productRating});

  Data.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    price = json['price'];
    specialPrice = json['special_price'];
    specialPriceType = json['special_price_type'];
    specialPriceStart = json['special_price_start'];
    specialPriceEnd = json['special_price_end'];
    sellingPrice = json['selling_price'];
    sku = json['sku'];
    manageStock = json['manage_stock'];
    qty = json['qty'];
    inStock = json['in_stock'];
    name = json['name'];
    shortDescription = json['short_description'];
    description = json['description'];
    if (json['images'] != null) {
      images = new List<Images>();
      json['images'].forEach((v) {
        images.add(new Images.fromJson(v));
      });
    }
    isProductNew = json['is_product_new'];
    isProductHasSpecialPrice = json['is_product_has_special_price'];
    if (json['product_options'] != null) {
      productOptions = new List<ProductOptions>();
      json['product_options'].forEach((v) {
        productOptions.add(new ProductOptions.fromJson(v));
      });
    }
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
    data['special_price_start'] = this.specialPriceStart;
    data['special_price_end'] = this.specialPriceEnd;
    data['selling_price'] = this.sellingPrice;
    data['sku'] = this.sku;
    data['manage_stock'] = this.manageStock;
    data['qty'] = this.qty;
    data['in_stock'] = this.inStock;
    data['name'] = this.name;
    data['short_description'] = this.shortDescription;
    data['description'] = this.description;
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    data['is_product_new'] = this.isProductNew;
    data['is_product_has_special_price'] = this.isProductHasSpecialPrice;
    if (this.productOptions != null) {
      data['product_options'] =
          this.productOptions.map((v) => v.toJson()).toList();
    }
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

class Images {
  String type;
  String path;

  Images({this.type, this.path});

  Images.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['path'] = this.path;
    return data;
  }
}

class ProductOptions {
  String optionId;
  String name;
  String type;
  String isRequired;
  String position;
  String isGlobal;
  List<Options> options;

  ProductOptions(
      {this.optionId,
        this.name,
        this.type,
        this.isRequired,
        this.position,
        this.isGlobal,
        this.options});

  ProductOptions.fromJson(Map<String, dynamic> json) {
    optionId = json['option_id'];
    name = json['name'];
    type = json['type'];
    isRequired = json['is_required'];
    position = json['position'];
    isGlobal = json['is_global'];
    if (json['options'] != null) {
      options = new List<Options>();
      json['options'].forEach((v) {
        options.add(new Options.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['option_id'] = this.optionId;
    data['name'] = this.name;
    data['type'] = this.type;
    data['is_required'] = this.isRequired;
    data['position'] = this.position;
    data['is_global'] = this.isGlobal;
    if (this.options != null) {
      data['options'] = this.options.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Options {
  String optionValueId;
  String price;
  String priceType;
  int increaseProductPriceBy;
  String label;
  String name;

  Options(
      {this.optionValueId,
        this.price,
        this.priceType,
        this.increaseProductPriceBy,
        this.label,
        this.name});

  Options.fromJson(Map<String, dynamic> json) {
    optionValueId = json['option_value_id'];
    price = json['price'];
    priceType = json['price_type'];
    increaseProductPriceBy = json['increase_product_price_by'];
    label = json['label'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['option_value_id'] = this.optionValueId;
    data['price'] = this.price;
    data['price_type'] = this.priceType;
    data['increase_product_price_by'] = this.increaseProductPriceBy;
    data['label'] = this.label;
    data['name'] = this.name;
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
  String avgRating;

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

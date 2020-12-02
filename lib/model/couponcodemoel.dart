class CouponModel {
  int status;
  bool hasError;
  String message;
  Data data;

  CouponModel({this.status, this.hasError, this.message, this.data});

  CouponModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    hasError = json['hasError'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['hasError'] = this.hasError;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String couponId;
  String couponCode;
  bool freeShipping;
  String discountAmount;

  Data(
      {this.couponId, this.couponCode, this.freeShipping, this.discountAmount});

  Data.fromJson(Map<String, dynamic> json) {
    couponId = json['coupon_id'];
    couponCode = json['coupon_code'];
    freeShipping = json['free_shipping'];
    discountAmount = json['discount_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coupon_id'] = this.couponId;
    data['coupon_code'] = this.couponCode;
    data['free_shipping'] = this.freeShipping;
    data['discount_amount'] = this.discountAmount;
    return data;
  }
}

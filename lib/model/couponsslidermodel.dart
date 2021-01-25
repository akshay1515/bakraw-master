class couponSliderModel {
  int status;
  String message;
  List<Data> data;

  couponSliderModel({this.status, this.message, this.data});

  couponSliderModel.fromJson(Map<String, dynamic> json) {
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
  String couponId;
  String filePath;

  Data({this.couponId, this.filePath});

  Data.fromJson(Map<String, dynamic> json) {
    couponId = json['coupon_id'];
    filePath = json['file_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coupon_id'] = this.couponId;
    data['file_path'] = this.filePath;
    return data;
  }
}

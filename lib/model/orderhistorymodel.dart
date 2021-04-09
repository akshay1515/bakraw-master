class OrderHistoryModel {
  int status;
  String message;
  List<Data> data;

  OrderHistoryModel({this.status, this.message, this.data});

  OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
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
  String orderId;
  String subTotal;
  String total;
  String status;
  String createdAt;

  Data({this.orderId, this.subTotal, this.total, this.status, this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    subTotal = json['sub_total'];
    total = json['total'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['sub_total'] = this.subTotal;
    data['total'] = this.total;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}

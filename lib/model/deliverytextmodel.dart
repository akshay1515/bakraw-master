class DeliveryTextModel {
  int status;
  String message;
  var data;

  DeliveryTextModel({this.status, this.message, this.data});

  DeliveryTextModel.fromJson(Map<String, dynamic> json) {
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
  String plainDeliveryText;
  String htmlDeliveryText;

  Data({this.plainDeliveryText, this.htmlDeliveryText});

  Data.fromJson(Map<String, dynamic> json) {
    plainDeliveryText = json['plain_delivery_text'];
    htmlDeliveryText = json['html_delivery_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['plain_delivery_text'] = this.plainDeliveryText;
    data['html_delivery_text'] = this.htmlDeliveryText;
    return data;
  }
}

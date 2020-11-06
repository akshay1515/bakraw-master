class PincodeModel {
  int status;
  String message;
  Data data;

  PincodeModel({this.status, this.message, this.data});

  PincodeModel.fromJson(Map<String, dynamic> json) {
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
  List<int> pincodes;
  PincodeDeliveryStatus pincodeDeliveryStatus;

  Data({this.pincodes, this.pincodeDeliveryStatus});

  Data.fromJson(Map<String, dynamic> json) {
    pincodes = json['pincodes'].cast<int>();
    pincodeDeliveryStatus = json['pincode_delivery_status'] != null
        ? new PincodeDeliveryStatus.fromJson(json['pincode_delivery_status'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pincodes'] = this.pincodes;
    if (this.pincodeDeliveryStatus != null) {
      data['pincode_delivery_status'] = this.pincodeDeliveryStatus.toJson();
    }
    return data;
  }
}

class PincodeDeliveryStatus {
  int pincode;
  bool allowDelivery;

  PincodeDeliveryStatus({this.pincode, this.allowDelivery});

  PincodeDeliveryStatus.fromJson(Map<String, dynamic> json) {
    pincode = json['pincode'];
    allowDelivery = json['allow_delivery'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pincode'] = this.pincode;
    data['allow_delivery'] = this.allowDelivery;
    return data;
  }
}

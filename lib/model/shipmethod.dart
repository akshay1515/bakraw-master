class ShipMethodModel {
  int status;
  String message;
  List<Data> data;

  ShipMethodModel({this.status, this.message, this.data});

  ShipMethodModel.fromJson(Map<String, dynamic> json) {
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
  String freeShippingLabel;
  String freeShippingName;
  String freeShippingMinAmount;
  String freeShippingEnabled;
  String localPickupLabel;
  String localPickupName;
  String localPickupCost;
  String localPickupEnabled;

  Data(
      {this.freeShippingLabel,
      this.freeShippingName,
      this.freeShippingMinAmount,
      this.freeShippingEnabled,
      this.localPickupLabel,
      this.localPickupName,
      this.localPickupCost,
      this.localPickupEnabled});

  Data.fromJson(Map<String, dynamic> json) {
    freeShippingLabel = json['free_shipping_label'];
    freeShippingName = json['free_shipping_name'];
    freeShippingMinAmount = json['free_shipping_min_amount'];
    freeShippingEnabled = json['free_shipping_enabled'];
    localPickupLabel = json['local_pickup_label'];
    localPickupName = json['local_pickup_name'];
    localPickupCost = json['local_pickup_cost'];
    localPickupEnabled = json['local_pickup_enabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['free_shipping_label'] = this.freeShippingLabel;
    data['free_shipping_name'] = this.freeShippingName;
    data['free_shipping_min_amount'] = this.freeShippingMinAmount;
    data['free_shipping_enabled'] = this.freeShippingEnabled;
    data['local_pickup_label'] = this.localPickupLabel;
    data['local_pickup_name'] = this.localPickupName;
    data['local_pickup_cost'] = this.localPickupCost;
    data['local_pickup_enabled'] = this.localPickupEnabled;
    return data;
  }
}

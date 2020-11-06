class UserAddressModel {
  int status;
  String message;
  List<addressData> data;

  UserAddressModel({this.status, this.message, this.data});

  UserAddressModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<addressData>();
      json['data'].forEach((v) {
        data.add(new addressData.fromJson(v));
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

class addressData {
  String id;
  String addressTitle;
  String userId;
  String userFirstname;
  String userLastname;
  String userEmail;
  String userPhone;
  String billingFirstName;
  String billingLastName;
  String billingAddress1;
  String billingAddress2;
  String billingCity;
  String billingState;
  String billingZip;
  String shippingFirstName;
  String shippingLastName;
  String shippingAddress1;
  String shippingAddress2;
  String shippingCountry;
  String shippingState;
  String shippingCity;
  String shippingZip;
  String isDefault;
  String isActive;
  String createdAt;
  String updatedAt;

  addressData(
      {this.id,
      this.addressTitle,
      this.userId,
      this.userFirstname,
      this.userLastname,
      this.userEmail,
      this.userPhone,
      this.billingFirstName,
      this.billingLastName,
      this.billingAddress1,
      this.billingAddress2,
      this.billingCity,
      this.billingState,
      this.billingZip,
      this.shippingFirstName,
      this.shippingLastName,
      this.shippingAddress1,
      this.shippingAddress2,
      this.shippingCountry,
      this.shippingState,
      this.shippingCity,
      this.shippingZip,
      this.isDefault,
      this.isActive,
      this.createdAt,
      this.updatedAt});

  addressData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    addressTitle = json['address_title'];
    userId = json['user_id'];
    userFirstname = json['user_firstname'];
    userLastname = json['user_lastname'];
    userEmail = json['user_email'];
    userPhone = json['user_phone'];
    billingFirstName = json['billing_first_name'];
    billingLastName = json['billing_last_name'];
    billingAddress1 = json['billing_address_1'];
    billingAddress2 = json['billing_address_2'];
    billingCity = json['billing_city'];
    billingState = json['billing_state'];
    billingZip = json['billing_zip'];
    shippingFirstName = json['shipping_first_name'];
    shippingLastName = json['shipping_last_name'];
    shippingAddress1 = json['shipping_address_1'];
    shippingAddress2 = json['shipping_address_2'];
    shippingCountry = json['shipping_country'];
    shippingState = json['shipping_state'];
    shippingCity = json['shipping_city'];
    shippingZip = json['shipping_zip'];
    isDefault = json['is_default'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['address_title'] = this.addressTitle;
    data['user_id'] = this.userId;
    data['user_firstname'] = this.userFirstname;
    data['user_lastname'] = this.userLastname;
    data['user_email'] = this.userEmail;
    data['user_phone'] = this.userPhone;
    data['billing_first_name'] = this.billingFirstName;
    data['billing_last_name'] = this.billingLastName;
    data['billing_address_1'] = this.billingAddress1;
    data['billing_address_2'] = this.billingAddress2;
    data['billing_city'] = this.billingCity;
    data['billing_state'] = this.billingState;
    data['billing_zip'] = this.billingZip;
    data['shipping_first_name'] = this.shippingFirstName;
    data['shipping_last_name'] = this.shippingLastName;
    data['shipping_address_1'] = this.shippingAddress1;
    data['shipping_address_2'] = this.shippingAddress2;
    data['shipping_country'] = this.shippingCountry;
    data['shipping_state'] = this.shippingState;
    data['shipping_city'] = this.shippingCity;
    data['shipping_zip'] = this.shippingZip;
    data['is_default'] = this.isDefault;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class OTPverifyModel {
  int status;
  String message;
  Data data;

  OTPverifyModel({this.status, this.message, this.data});

  OTPverifyModel.fromJson(Map<String, dynamic> json) {
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
  bool isNewUser;
  String userId;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String permissions;
  String token;

  Data(
      {this.isNewUser,
        this.userId,
        this.firstName,
        this.lastName,
        this.email,
        this.phoneNumber,
        this.permissions,
        this.token});

  Data.fromJson(Map<String, dynamic> json) {
    isNewUser = json['is_new_user'];
    userId = json['userId'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    permissions = json['permissions'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_new_user'] = this.isNewUser;
    data['userId'] = this.userId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['permissions'] = this.permissions;
    data['token'] = this.token;
    return data;
  }
}

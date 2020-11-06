class ProductModel {
  var name = "";
  var price = "";
  var weight = "";
  var img = "";
}

class CategoryModel {
  var name = "";
  var img = "";

  CategoryModel(this.name, this.img);
}

class UserloginModel {
  var email = "";
  var password = "";
  var firstname = "";
  var lastname = "";
  var mobile = "";

  UserloginModel(
      {this.email, this.password, this.firstname, this.lastname, this.mobile});
}

class UserModel {
  int status;
  String message;
  Data data;

  UserModel({this.status, this.message, this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
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
  String userId;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String permissions;
  String token;
  String password;

  Data(
      {this.userId,
      this.firstName,
      this.lastName,
      this.email,
      this.phoneNumber,
      this.permissions,
      this.password,
      this.token});

  Data.fromJson(Map<String, dynamic> json) {
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

class NotificationModel {
  var name = "";
  var duration = "";
  var description = "";

  NotificationModel(this.name, this.duration, this.description);
}

class CategoryOptionModel {
  var name = "";

  CategoryOptionModel(this.name);
}

class ReviewModel {
  var name = "";
  var duration = "";
  var description = "";
  var img = "";

  ReviewModel(this.name, this.duration, this.description, this.img);
}

class CartModel {
  var name = "";
  var price = "";
  var totalItem = "";

  CartModel(
    this.name,
    this.price,
    this.totalItem,
  );
}

class GroceryProfileModel {
  var icon = "";
  var title = "";
  var color;
}

class GroceryPaymentModel {
  var cardImg = "";
  var color;
  var name = "";
  var cardNumber = "";
  bool isSelected = false;

  GroceryPaymentModel(
      this.cardImg, this.color, this.name, this.cardNumber, this.isSelected);
}

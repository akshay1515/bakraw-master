import 'dart:convert';

import 'package:bakraw/model/usermodel.dart';
import 'package:bakraw/model/verifyModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../backend.dart';

class OTPProvider with ChangeNotifier {

  Future<OTPverifyModel> sendOTP(String mobilenumber) async {
    const url = '${Utility.BaseURL}${'send-otp.php'}';
    OTPverifyModel userModel;
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'mobile' : num.parse(mobilenumber)}));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['status'] == 200) {
        userModel = OTPverifyModel(
          message: data['message'],
          status: data['status']
        );
      } else {
        userModel = OTPverifyModel(status: data['status'], message: data['message'],data: data['data']);
      }
    }
    notifyListeners();
    return userModel;
  }
  Future<OTPverifyModel> VerifyOTP(String mobilenumber,String otp) async {
    const url = '${Utility.BaseURL}${'verify-otp.php'}';
    OTPverifyModel model;
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
         'mobile' : num.parse(mobilenumber),
          'otp' :  num.parse(otp)
        }));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['status'] == 200) {
        model = OTPverifyModel.fromJson(data);
        //print(model.message);
      } else {
        model = OTPverifyModel(status: data['status'], message: data['message']);
      }
    }
    notifyListeners();
    return model;
  }

}

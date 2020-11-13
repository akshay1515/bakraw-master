

import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  Razorpay razorpay;
  TextEditingController txtAmount = new TextEditingController();

  void handleSuccessPayment(PaymentSuccessResponse response){
    print("payment success"+response.toString());
  }

  void handleErrorPayment(PaymentFailureResponse response){
    print("payment error"+response.message.toString());
  }
  void handleExternalWalletPayment(ExternalWalletResponse response){
    print("External wallet"+response.toString());
  }

  void openCheckout(){



    try{

      var options = {
        "key":"rzp_test_a6FHbsZ5pwGKyF",
        "amount":1000,
        "name":"Test name",
        "description":"This is test payment",
        "prefill":{
          "contact":"9096982124",
          "email":"test@gmail.com"
        },
        "external":{
          "wallets":["paytm"]
        }
      };

      razorpay.open(options);

    }catch(e){
      print(e.toString());
    }

  }

  @override
  void initState() {
    super.initState();
    razorpay = new Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handleSuccessPayment);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handleErrorPayment);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletPayment);

  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [

            TextFormField(
              controller: txtAmount,
              decoration: InputDecoration(
                labelText: "Amount",
                hintText: "Amount"
              ),
            ),
            Container(
              child: FlatButton(
                color: Colors.cyan,
                  onPressed: (){
                    openCheckout();
                  },
                  child: Text("Pay Now")
              ),
            )


          ],
        ),
      ),
    );
  }
}

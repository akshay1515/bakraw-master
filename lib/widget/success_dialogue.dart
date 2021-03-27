import 'package:bakraw/screen/newui/newhomepage.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:bakraw/utils/GroceryConstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogResponses extends StatefulWidget {
  Color color;
  IconData icon;
  String id;
  String message;

  DialogResponses({this.color, this.icon, this.id, this.message, issuccess});

  @override
  _DialogResponsesState createState() => _DialogResponsesState();
}

class _DialogResponsesState extends State<DialogResponses> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent, //this right here
          child: Container(
            height: 200,
            width: MediaQuery.of(context).size.width * 0.55,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment(0, 1.5),
                  child: Container(
                    height: 170,
                    width: MediaQuery.of(context).size.width * 0.55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                      color: Colors.white,
                    ),
                    child: Container(
                      margin: EdgeInsets.only(top: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.message,
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          widget.id == null
                              ? Container()
                              : Text(
                                  "ID: ${widget.id}",
                                  style: TextStyle(fontWeight: FontWeight.w300),
                                ),
                          TextButton(
                              style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              onPressed: () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    NewHomepage.Tag, (route) => false,
                                    arguments: {'id': 0});
                              },
                              child: Container(
                                width: 65,
                                height: 40,
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: grocery_colorPrimary,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                    child: Text(
                                  'Ok',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: fontBold,
                                      fontSize: 20),
                                )),
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(0, -1),
                  child: Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        color: widget.color, shape: BoxShape.circle),
                    child: Icon(
                      widget.icon,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        onWillPop: () {
          return Navigator.of(context).pushNamedAndRemoveUntil(
              NewHomepage.Tag, (route) => false,
              arguments: {'id': 0});
        });
  }
}

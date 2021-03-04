import 'package:bakraw/GlobalWidget/GlobalWidget.dart';
import 'package:bakraw/model/internalcart.dart';
import 'package:bakraw/model/pincodemodel.dart';
import 'package:bakraw/model/useraddressmodel.dart' as da;
import 'package:bakraw/provider/pincodeprovider.dart';
import 'package:bakraw/provider/useraddressprovider.dart';
import 'package:bakraw/screen/checkpincode.dart';
import 'package:bakraw/screen/dashboard.dart';
import 'package:bakraw/screen/dashboaruderprofile.dart';
import 'package:bakraw/screen/editadduseraddress.dart';
import 'package:bakraw/screen/newui/newhomepage.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:bakraw/utils/GroceryConstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:flutter/scheduler.dart';

class UserAddressManager extends StatefulWidget {
  static String tag = '/AddressManagerScreen';

  @override
  _UserAddressManagerState createState() => _UserAddressManagerState();
}

class _UserAddressManagerState extends State<UserAddressManager> {
  String email = '';
  String apikey = '';
  String userid = '';
  String fname = '';
  String lname = '';
  String mobile = '';
  List<da.Data> list = [];
  bool isloading = true;
  bool isinit = false;
  int count = 0;

  var selectedValue;
  var sOptionPrice;

  @override
  void initState() {
    getUserInfo().then((value){
      setState(() {
        isinit = true;
      });
    });
  }

  Future<String> getUserInfo() async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    if (prefs != null) {
      setState(() {
        email = prefs.getString('email');
        apikey = prefs.getString('apikey');
        userid = prefs.getString('id');
        fname = prefs.getString('fname');
        lname = prefs.getString('lname');
        mobile = prefs.getString('mobile');
      });
    }

    return userid;
  }

  SelectedRadio(da.Data val) {
    setState(() {
      Provider.of<UserAddressProvider>(context, listen: false)
          .UpdateOptionValue(val);
    });
  }

  editAddress(da.Data model) async {
    var bool = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => EditUserAddress(
                      model: model,
                    ))) ??
        false;
    if (bool) {}
  }
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var argument = ModalRoute.of(context).settings.arguments as Map;

    if (isloading) {
      Provider.of<UserAddressProvider>(context, listen: false)
          .getuserAddressList(userid,apikey)
          .then((value) {
        value.data.forEach((element) {
          list.add(da.Data(
            id: element.id,
            firstName: element.firstName,
            lastName: element.lastName,
            address1: element.address1,
            address2: element.address2,
             city: element.city,
            state: element.state,
            zip: element.zip,
            country: element.country,
            customerId: element.customerId,
            createdAt: element.createdAt,
            updatedAt: element.updatedAt
          ));
        });
        setState(() {
          isloading = false;
        });
      });
    }
    if(isinit) {
      if (userid.isEmptyOrNull) {
        if (count < 1) {
          count++;
          SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pushNamed(
              NewHomepage.Tag, arguments: {'id': 4});
          });
          return Container(
            color: Colors.white,
          );
        }
      }else{
        return  WillPopScope(
          child:  Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: grocery_color_white,
                  ),
                  onPressed: () {
                    if (argument != null) {
                      Navigator.of(context).pop();
                    } else {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          NewHomepage.Tag, (route) => false,arguments: {'id':0});
                    }
                  }),
              title: Text(
                'User Addresss',
                style: TextStyle(color: grocery_color_white),
              ),
              actions: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.add,
                      color: grocery_color_white,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(EditUserAddress.tag);
                    })
              ],
            ),
            body: isloading
                ? Container(
              color: grocery_color_white,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
                :list.isNotEmpty? ListView.builder(
                padding: EdgeInsets.only(top: spacing_middle),
                scrollDirection: Axis.vertical,
                itemCount: list.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        bottom: spacing_standard_new),
                    child: Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      actions: <Widget>[
                        IconSlideAction(
                          caption: 'Edit',
                          color: Colors.green,
                          icon: Icons.edit,
                          onTap: () {
                            editAddress(list[index]);
                          },
                        )
                      ],
                      child: InkWell(
                        onTap: () {
                          if(argument != null ||
                              argument['isnav'] == true) {
                            CheckPincode(model: list[index])
                                .launch(context);
                          }else{
                            editAddress(list[index]);
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(spacing_standard_new),
                          margin: EdgeInsets.only(
                            right: spacing_standard_new,
                            left: spacing_standard_new,
                          ),
                          color: grocery_app_background,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: <Widget>[
                                    text(
                                        '${list[index].firstName } ${list[index].lastName}',
                                        textColor: textPrimaryColor,
                                        fontFamily: fontMedium,
                                        fontSize: textSizeLargeMedium),
                                    text(
                                        ' ${list[index].address1} ${'\n'} ${list[index].address2}',
                                        textColor: textPrimaryColor,
                                        fontSize: textSizeMedium),
                                    text(
                                        ' ${list[index].city} , ${list[index].state}',
                                        textColor: textPrimaryColor,
                                        fontSize: textSizeMedium),
                                    text(
                                        '${list[index].country} , ${list[index].zip}',
                                        textColor: textPrimaryColor,
                                        fontSize: textSizeMedium),
                                    SizedBox(
                                      height: spacing_standard_new,
                                    ),
                                    text(mobile != null ? mobile  :'NA',
                                        textColor: textPrimaryColor,
                                        fontSize: textSizeMedium),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }): Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.inbox,color: grocery_colorPrimary,size: MediaQuery.of(context).size.height/5,),
                    ),
                    Text('Your Saved Address List Is Empty'),
                  ],)
            ),
          ),
          onWillPop: () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(NewHomepage.Tag, (route) => false,arguments: {'id':0});
          },
        );
      }
    }else {
      return Container(
        color: Colors.white,
      );
    }
  }
}

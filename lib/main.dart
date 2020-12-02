import 'package:bakraw/provider/carttoserverprovider.dart';
import 'package:bakraw/provider/categoryproductprovider.dart';
import 'package:bakraw/provider/categoryprovider.dart';
import 'package:bakraw/provider/changepasswordprovider.dart';
import 'package:bakraw/provider/couponprovider.dart';
import 'package:bakraw/provider/deliveryslotprovider.dart';
import 'package:bakraw/provider/favouriteproductprovider.dart';
import 'package:bakraw/provider/flashsaleprovider.dart';
import 'package:bakraw/provider/markfavouriteprovider.dart';
import 'package:bakraw/provider/orderdetailsprovider.dart';
import 'package:bakraw/provider/orderhistoryprovider.dart';
import 'package:bakraw/provider/passwordprovider.dart';
import 'package:bakraw/provider/pincodeprovider.dart';
import 'package:bakraw/provider/previousorderprovider.dart';
import 'package:bakraw/provider/productdetailprovider.dart';
import 'package:bakraw/provider/relatedproductprovider.dart';
import 'package:bakraw/provider/searchprovider.dart';
import 'package:bakraw/provider/shipmethodprovider.dart';
import 'package:bakraw/provider/sliderprovider.dart';
import 'package:bakraw/provider/taxProvider.dart';
import 'package:bakraw/provider/useraddressprovider.dart';
import 'package:bakraw/provider/userprovider.dart';
import 'package:bakraw/screen/addnumber.dart';
import 'package:bakraw/screen/cart/mycart2.dart';
import 'package:bakraw/screen/categoryproduct.dart';
import 'package:bakraw/screen/dashboard.dart';
import 'package:bakraw/screen/editadduseraddress.dart';
import 'package:bakraw/screen/forgotpassword.dart';
import 'package:bakraw/screen/mycart.dart';
import 'package:bakraw/screen/productdetail.dart';
import 'package:bakraw/screen/signup.dart';
import 'package:bakraw/screen/splashscreen.dart';
import 'package:bakraw/screen/useraddresslist.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: SliderProvider()),
        ChangeNotifierProvider.value(value: CategoryProvider()),
        ChangeNotifierProvider.value(value: FlashSaleProvider()),
        ChangeNotifierProvider.value(value: CategoryProductProvider()),
        ChangeNotifierProvider.value(value: ProductProvider()),
        ChangeNotifierProvider.value(value: UserProvider()),
        ChangeNotifierProvider.value(value: ForgotProvider()),
        ChangeNotifierProvider.value(value: UserFavouriteProvider()),
        ChangeNotifierProvider.value(value: MarkFavourite()),
        ChangeNotifierProvider.value(value: OrderHistoryProvider()),
        ChangeNotifierProvider.value(value: Change_Password_Provider()),
        ChangeNotifierProvider.value(value: UserAddressProvider()),
        ChangeNotifierProvider.value(value: RelatedProductProvier()),
        ChangeNotifierProvider.value(value: PincodeProvider()),
        ChangeNotifierProvider.value(value: DeliverySlotProvider()),
        ChangeNotifierProvider.value(value: ShipmethodProvider()),
        ChangeNotifierProvider.value(value: TaxProvider()),
        ChangeNotifierProvider.value(value: OrderDetailsProvider()),
        ChangeNotifierProvider.value(value: ShipmethodProvider()),
        ChangeNotifierProvider.value(value: CartToserverProvider()),
        ChangeNotifierProvider.value(value: SearchProvider()),
        ChangeNotifierProvider.value(value: PreviousOrderProvider()),
        ChangeNotifierProvider.value(value: CouponProvider())
      ],
      child: MaterialApp(
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
        debugShowMaterialGrid: false,
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: grocery_colorPrimary,
        ),
        routes: {
          GrocerySubCategoryList.tag: (ctx) => GrocerySubCategoryList(),
          GroceryProductDescription.tag: (ctx) => GroceryProductDescription(),
          Dashboard.Tag: (ctx) => Dashboard(),
          SignUp.tag: (ctx) => SignUp(),
          Mycart.tag: (ctx) => Mycart2(),
          GroceryAddNumber.tag: (ctx) => GroceryAddNumber(),
          GroceryForgotPassword.tag: (ctx) => GroceryForgotPassword(),
          UserAddressManager.tag: (ctx) => UserAddressManager(),
          EditUserAddress.tag: (ctx) => EditUserAddress(),
        },
      ),
    );
  }
}

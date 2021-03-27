import 'package:bakraw/provider/OTPProvider.dart';
import 'package:bakraw/provider/bestsellerprovider.dart';
import 'package:bakraw/provider/carttoserverprovider.dart';
import 'package:bakraw/provider/categoryproductprovider.dart';
import 'package:bakraw/provider/categoryprovider.dart';
import 'package:bakraw/provider/changepasswordprovider.dart';
import 'package:bakraw/provider/couponprovider.dart';
import 'package:bakraw/provider/couponsliderProvider.dart';
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
import 'package:bakraw/screen/aboutus.dart';
import 'package:bakraw/screen/cart/mycart2.dart';
import 'package:bakraw/screen/editadduseraddress.dart';
import 'package:bakraw/screen/newui/newcategory.dart';
import 'package:bakraw/screen/newui/newdashboard.dart';
import 'package:bakraw/screen/newui/newgooglemap.dart';
import 'package:bakraw/screen/newui/newhomepage.dart';
import 'package:bakraw/screen/newui/newproductdetail.dart';
import 'package:bakraw/screen/orderhistory.dart';
import 'package:bakraw/screen/privacypolicy.dart';
import 'package:bakraw/screen/searchscreen.dart';
import 'package:bakraw/screen/splashscreen.dart';
import 'package:bakraw/screen/termsandcondition.dart';
import 'package:bakraw/screen/useraddresslist.dart';
import 'package:bakraw/screen/webview.dart';
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
        ChangeNotifierProvider.value(value: OTPProvider()),
        ChangeNotifierProvider.value(value: CouponProvider()),
        ChangeNotifierProvider.value(value: couponslideProvider()),
        ChangeNotifierProvider.value(value: BestSellerProvider())
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
          NewCategory.TAG: (ctx) => NewCategory(),
          NewHomepage.Tag: (ctx) => NewDashboard(),
          SearchScreen.Tag: (ctx) => SearchScreen(),
          NewProductDetails.tag: (ctx) => NewProductDetails(),
          UserAddressManager.tag: (ctx) => UserAddressManager(),
          Mycart2.tag: (ctx) => Mycart2(),
          GoogleMapActivity.Tag:(ctx)=> GoogleMapActivity(),
          EditUserAddress.tag: (ctx) => EditUserAddress(),
          GroceryOrderHistoryScreen.tag: (ctx) => GroceryOrderHistoryScreen(),
          Terms.tag: (ctx) => Terms(),
          Privacy.tag: (ctx) => Privacy(),
          ContentDisplay.tag: (ctx) => ContentDisplay(),
          AboutUs.tag: (ctx) => AboutUs()
        },
      ),
    );
  }
}

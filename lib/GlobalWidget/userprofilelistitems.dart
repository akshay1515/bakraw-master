import 'package:bakraw/GlobalWidget/profilelistmodel.dart';
import 'package:bakraw/utils/GeoceryStrings.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:bakraw/utils/GroceryImages.dart';

List<GroceryProfileModel> groceryProfileList() {
  List<GroceryProfileModel> list = List<GroceryProfileModel>();

  var list2 = GroceryProfileModel();
  list2.title = grocery_lbl_Delivery_Address;
  list2.icon = Grocery_ic_DeliveryTruck;
  list2.color = grocery_orangeLight_Color;
  list.add(list2);

  /*var list3 = GroceryProfileModel();
  list3.title = grocery_lbl_Payment_Methods;
  list3.icon = Grocery_ic_Dollar;
  list3.color = grocery_orangeColor;
  list.add(list3);*/

  var list4 = GroceryProfileModel();
  list4.title = grocery_lbl_Change_Password;
  list4.icon = Grocery_ic_Lock;
  list4.color = grocery_RedLight_Color;
  list.add(list4);

  var list5 = GroceryProfileModel();
  list5.title = grocery_lbl_Logout;
  list5.icon = Grocery_ic_Logout;
  list5.color = grocery_Red_Color;
  list.add(list5);

  return list;
}

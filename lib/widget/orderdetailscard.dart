import 'package:bakraw/GlobalWidget/GlobalWidget.dart';
import 'package:bakraw/model/orderdetailsmodel.dart';
import 'package:bakraw/provider/orderdetailsprovider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class OrderDetailsCard extends StatefulWidget {
  String orderid;
  OrderDetailsCard({this.orderid});

  @override
  _OrderDetailsCardState createState() => _OrderDetailsCardState();
}

class _OrderDetailsCardState extends State<OrderDetailsCard> {
  String userid = '', email = '', apikey = '';
  Data model;
  List<Products> productslist = [];
  List<Address> addresslist = [];
  Products products;
  ProductOptions options;
  bool isLoading = true;
  bool isinit = false;
  List<ProductOptions> optionlist = [];
  static const range = 0;

  @override
  void initState() {
    super.initState();
    getUserInfo();
    isinit = true;
  }

  Future<String> getUserInfo() async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    if (prefs != null) {
      email = prefs.getString('email');
      apikey = prefs.getString('apikey');
      userid = prefs.getString('id');
    }
    return email;
  }

  @override
  Widget build(BuildContext context) {
    if (isinit == true) {
      Provider.of<OrderDetailsProvider>(context)
          .getOrderDetail(apikey, userid, email, '32')
          .then((value) {
        model = Data(
            status: value.data.status,
            createdAt: value.data.createdAt,
            paymentMethod: value.data.paymentMethod,
            note: value.data.note,
            deliverySlot: value.data.deliverySlot,
            total: value.data.total,
            shippingCost: value.data.shippingCost,
            shippingMethod: value.data.shippingMethod,
            subTotal: value.data.subTotal,
            orderId: value.data.orderId,
            address: value.data.address,
            coupon: value.data.coupon,
            customerEmail: value.data.customerEmail,
            products: value.data.products);
        value.data.products.forEach((element) {
          productslist.add(Products(
              orderId: element.orderId,
              lineTotal: element.lineTotal,
              unitPrice: element.unitPrice,
              images: element.images,
              qty: element.qty,
              name: element.name,
              productId: element.productId,
              id: element.id,
              shortDescription: element.shortDescription,
              productOptions: element.productOptions));
          element.productOptions.forEach((element) {
            optionlist
                .add(ProductOptions(name: element.name, value: element.value));
          });
        });
        setState(() {
          isLoading = false;
        });
      });
      isinit = false;
    }

    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Card(
              margin: EdgeInsets.all(16),
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              child: InkWell(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                onTap: () {},
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.only(left: 16, right: 16),
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(model.status,
                              style: boldTextStyle(
                                size: 23,
                              )),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.only(left: 16, right: 16),
                        child: Text('Order Id: ${model.orderId}',
                            style: secondaryTextStyle(
                              size: 16,
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16, right: 16),
                        child: Text(
                            'Amount Paid: ₹ ${double.parse(model.subTotal).toStringAsFixed(2)}',
                            style: secondaryTextStyle(
                              size: 16,
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16, right: 16),
                        child: Text('Payment Method: ${model.paymentMethod}',
                            style: secondaryTextStyle(
                              size: 16,
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16, right: 16),
                        child: Text('Order Date: ${model.createdAt}',
                            style: secondaryTextStyle(
                              size: 16,
                            )),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.only(left: 16, right: 16),
                        child: Text('Delivered At:',
                            style: secondaryTextStyle(
                              size: 16,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 16),
                        child: Text(
                            'Name : ${model.address.shippingFirstName + ' ' + model.address.shippingLastName}'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25, right: 16),
                        child: Text('${model.address.shippingAddress1}'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25, right: 16),
                        child: Text(
                            '${model.address.shippingAddress2 + ' \,'}${model.address.shippingCity}'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25, right: 16),
                        child: Text(
                            '${model.address.shippingState + ' \,'}${model.address.shippingCountry + ' - ' + model.address.shippingZip}'),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.only(left: 16, right: 16),
                        child: Text('Products Ordered',
                            style: secondaryTextStyle(
                              size: 20,
                            )),
                      ),
                      Container(
                        height: 500,
                        child: ListView.builder(
                            itemCount: productslist.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                width: MediaQuery.of(context).size.width,
                                height: 100,
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black,
                                              width: 2,
                                              style: BorderStyle.solid)),
                                      height: 100,
                                      width: 150,
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            productslist[index].images[range],
                                        fit: BoxFit.contain,
                                        placeholder: placeholderWidgetFn(),
                                        errorWidget: (context, url, error) =>
                                            new Icon(Icons.error),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            productslist[index].name,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            '${optionlist[0].value}',
                                            style: TextStyle(
                                              fontSize: 15,
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        Flexible(child: Container()),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            'Price : ₹ ${double.parse(productslist[index].unitPrice).toStringAsFixed(2)}',
                                            style: TextStyle(
                                              fontSize: 15,
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            'Quantity :${int.parse(productslist[index].qty)}',
                                            style: TextStyle(
                                              fontSize: 15,
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            'Total : ₹ ${double.parse(productslist[index].lineTotal).toStringAsFixed(2)}',
                                            style: TextStyle(
                                              fontSize: 15,
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            }),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}

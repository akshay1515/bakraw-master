import 'package:bakraw/GlobalWidget/GlobalWidget.dart';
import 'package:bakraw/model/orderdetailsmodel.dart';
import 'package:bakraw/provider/orderdetailsprovider.dart';
import 'package:bakraw/utils/GroceryConstant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderDetailsCard extends StatefulWidget {
  String orderid, email, userid, apikey;

  OrderDetailsCard({this.orderid, this.email, this.userid, this.apikey});

  @override
  _OrderDetailsCardState createState() => _OrderDetailsCardState();
}

class _OrderDetailsCardState extends State<OrderDetailsCard> {
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
    isinit = true;
  }

  @override
  Widget build(BuildContext context) {
    if (isinit == true) {
      Provider.of<OrderDetailsProvider>(context)
          .getOrderDetail(
              widget.apikey, widget.userid, widget.email, widget.orderid)
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
            taxDetails: value.data.taxDetails,
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
        ? Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            backgroundColor: Colors.grey.shade200,
            appBar: AppBar(
              title: Text('Order Details'),
            ),
            body: SingleChildScrollView(
              child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        margin: EdgeInsets.only(left: 8, right: 8),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(16))),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 3),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 10),
                              Padding(
                                padding: EdgeInsets.only(left: 8, right: 8),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(model.status,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 23)),
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 16, right: 16),
                                        child: Text('Order Id',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontFamily: fontSemiBold,
                                              fontSize: 16,
                                            )),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 16, right: 16),
                                        child: Text('Order Total',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontFamily: fontSemiBold,
                                              fontSize: 16,
                                            )),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 16, right: 16),
                                        child: Text('Tax Amount',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontFamily: fontSemiBold,
                                              fontSize: 16,
                                            )),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 16, right: 16),
                                        child: Text('Amount Paid',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontFamily: fontSemiBold,
                                              fontSize: 16,
                                            )),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 16, right: 16),
                                        child: Text('Payment Method',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontFamily: fontSemiBold,
                                              fontSize: 16,
                                            )),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 16, right: 16),
                                        child: Text('Order Date',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontFamily: fontSemiBold,
                                              fontSize: 16,
                                            )),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 16, right: 16),
                                        child: Text(':',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontFamily: fontSemiBold,
                                              fontSize: 16,
                                            )),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 16, right: 16),
                                        child: Text(':',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontFamily: fontSemiBold,
                                              fontSize: 16,
                                            )),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 16, right: 16),
                                        child: Text(':',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontFamily: fontSemiBold,
                                              fontSize: 16,
                                            )),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 16, right: 16),
                                        child: Text(':',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontFamily: fontSemiBold,
                                              fontSize: 16,
                                            )),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 16, right: 16),
                                        child: Text(':',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontFamily: fontSemiBold,
                                              fontSize: 16,
                                            )),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 16, right: 16),
                                        child: Text(':',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontFamily: fontSemiBold,
                                              fontSize: 16,
                                            )),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 16, right: 16),
                                        child: Text(model.orderId,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16,
                                            )),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 16, right: 16),
                                        child: Text(
                                            '??? ${double.parse(model.subTotal).toStringAsFixed(2)}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16,
                                            )),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 16, right: 16),
                                        child: Text(
                                            '??? ${double.parse(model.taxDetails[0].amount).toStringAsFixed(2)}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16,
                                            )),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 16, right: 16),
                                        child: Text(
                                            '??? ${double.parse(model.total).toStringAsFixed(2)}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16,
                                            )),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 16, right: 16),
                                        child: Text('${model.paymentMethod}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16,
                                            )),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 16, right: 16),
                                        child: Text(
                                            '${DateFormate(model.createdAt)}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16,
                                            )),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: 20),
                              !model.note.contains('-1')
                                  ? Padding(
                                      padding:
                                          EdgeInsets.only(left: 16, right: 16),
                                      child: Text('Note :',
                                          style: TextStyle(
                                            fontFamily: fontBold,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 20,
                                          )),
                                    )
                                  : Container(),
                              !model.note.contains('-1')
                                  ? Padding(
                                      padding:
                                          EdgeInsets.only(left: 16, right: 16),
                                      child: Text('${model.note}',
                                          style: TextStyle(
                                            fontSize: 16,
                                          )),
                                    )
                                  : Container(),
                              SizedBox(height: 10),
                              Padding(
                                padding: EdgeInsets.only(left: 16, right: 16),
                                child: Text('Delivery Address :',
                                    style: TextStyle(
                                      fontFamily: fontBold,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                    )),
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16),
                                    child: Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: Text(
                                        '${model.address.shippingFirstName + ' ' + model.address.shippingLastName}',
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16),
                                    child: Text(
                                        '${model.address.shippingAddress1}'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16),
                                    child: Text(
                                        '${model.address.shippingAddress2 + ' \,'}${model.address.shippingCity}'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16, bottom: 8),
                                    child: Text(
                                        '${model.address.shippingState + ' \,'}${model.address.shippingCountry + ' - ' + model.address.shippingZip}'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.only(left: 8, right: 8, bottom: 10),
                        child: Text('Products Ordered',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            )),
                      ),
                      ListView.builder(
                          itemCount: productslist.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (_, index) {
                            return Card(
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              margin:
                                  EdgeInsets.only(left: 8, right: 8, bottom: 8),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 120,
                                child: Row(
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          bottomLeft: Radius.circular(10)),
                                      child: CachedNetworkImage(
                                        height: 120,
                                        width: 120,
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
                                        Flexible(
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                top: 8,
                                                left: 10,
                                                bottom: 5,
                                                right: 10),
                                            child: Text(
                                              productslist[index].name,
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            '${optionlist[index].value}',
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
                                            'Price : ??? ${double.parse(productslist[index].unitPrice).toStringAsFixed(2)}',
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
                                            'Total : ??? ${double.parse(productslist[index].lineTotal).toStringAsFixed(2)}',
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
                              ),
                            );
                          })
                    ],
                  )),
            ),
          );
  }

  String DateFormate(String Date) {
    final date = DateFormat('dd-MMM-yyyy').parse(Date);
    final df = new DateFormat('dd-MMM-yyyy');
    final fdate = df.format(date);

    return fdate.toString();
  }
}

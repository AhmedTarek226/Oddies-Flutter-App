import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/models/order.dart';
import 'package:e_commerce/provider/user_provider.dart';
import 'package:e_commerce/screens/user_order_details.dart';
import 'package:e_commerce/services/store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class MyOrders extends StatefulWidget {
  static String id = 'MyOrders';

  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  void initState() {
    setState(() {
      getdata();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double size = (height + width) / 2;
    final _store = Store();
    List<int> ordersNum =
        Provider.of<UserProvider>(context, listen: true).ordersNum;
    return Container(
      height: height * .963,
      width: width,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: KMainColor,
          elevation: 0,
          title: Text(
            'orders placed'.toUpperCase(),
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                letterSpacing: .5,
                fontFamily: 'Karla'),
          ),
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.clear,
              color: Colors.black,
              size: size * .05,
            ),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: _store.loadOrders(),
            builder: (context, snapshot) {
              _store.loadOrders();
              if (!snapshot.hasData) {
                return Center(child: Text('Loading...'));
              } else if (ordersNum.length == 0)
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.listUl,
                      size: size * .05,
                    ),
                    SizedBox(
                      height: height * .023,
                    ),
                    Center(
                        child: Text(
                      'You have not yet placed an order',
                      style: TextStyle(
                          fontSize: size * .025, fontWeight: FontWeight.w500),
                    )),
                  ],
                );
              else {
                List<Order> allorders = [];
                List<Order> orders = [];
                for (var doc in snapshot.data.docs) {
                  allorders.add(Order(
                    totalPrice: doc.get(KTotalPrice),
                    address: doc.get(KAddress),
                    addressDetails: doc.get(KAddressDetails),
                    orderNumber: doc.get(KUserOrderId),
                    documentId: doc.id,
                  ));
                }
                for (var order in allorders) {
                  for (var userorder in ordersNum) {
                    if (order.orderNumber == userorder) {
                      orders.add(order);
                    }
                  }
                }
                return ListView.builder(
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: height * .01, horizontal: width * .04),
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => SingleChildScrollView(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom),
                                    child: UserOrderDetails(
                                      order: orders[index],
                                    ),
                                  ),
                                ));
                      },
                      child: Card(
                        //height: MediaQuery.of(context).size.height * .2,
                        color: Colors.lightGreen[100],
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: height * .025, horizontal: width * .05),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: [
                                  Text(
                                    'Order Number : ',
                                    style: TextStyle(
                                        fontSize: size * .035,
                                        fontWeight: FontWeight.w800,
                                        fontFamily: 'Amiri'),
                                  ),
                                  Text(
                                    orders[index].orderNumber.toString(),
                                    style: TextStyle(
                                        fontSize: size * .032,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Amiri'),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: height * .015,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Address : ',
                                    style: TextStyle(
                                        fontSize: size * .035,
                                        fontWeight: FontWeight.w800,
                                        fontFamily: 'Amiri'),
                                  ),
                                  Text(
                                    orders[index].address,
                                    style: TextStyle(
                                        fontSize: size * .034,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Amiri'),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: height * .015,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Total Price : ',
                                    style: TextStyle(
                                        fontSize: size * .035,
                                        fontWeight: FontWeight.w800,
                                        fontFamily: 'Amiri'),
                                  ),
                                  Text(
                                    '${orders[index].totalPrice.toString()} EGP',
                                    style: TextStyle(
                                        fontSize: size * .032,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Amiri'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  itemCount: orders.length,
                );
              }
            }),
      ),
    );
  }

  getdata() async {
    List<int> ordersNumbers = [];
    final user = Provider.of<UserProvider>(context, listen: false).currentUser;
    try {
      await FirebaseFirestore.instance
          .collection(KUserCollection)
          .doc(user.Uid)
          .get()
          .then((value) {
        List.from(value.get(KUserOrderId)).forEach((element) {
          ordersNumbers.add(element);
        });
      });
      Provider.of<UserProvider>(context, listen: false)
          .setListOfOrders(ordersNumbers);
    } catch (e) {
      print(e);
    }
  }
}

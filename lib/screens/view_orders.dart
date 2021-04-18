import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/models/order.dart';
import 'package:e_commerce/screens/order_details.dart';
import 'package:e_commerce/services/store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewOrders extends StatelessWidget {
  static String id = 'ViewOrders';
  @override
  Widget build(BuildContext context) {
    final _store = Store();
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadOrders(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data.size==0) {
            return Center(child: Text('No Orders'));
          } else {
            List<Order> orders = [];
            for (var doc in snapshot.data.docs) {
              orders.add(Order(
                totalPrice: doc.data()[KTotalPrice],
                address: doc.data()[KAddress],
                addressDetails: doc.data()[KAddressDetails],
                orderNumber: doc.data()[KUserOrderId],
                isConfirmed: doc.data()[KOrderConfirmed],
                documentId: doc.id,
              ));
            }
            return ListView.builder(
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(15.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, OrderDetails.id,
                        arguments: orders[index]);
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * .2,
                    color: Colors.lightGreen[100],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Order Number : ${orders[index].orderNumber}',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Address : ${orders[index].address}',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Total Price : ${orders[index].totalPrice.toString()}',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
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
        },
      ),
    );
  }
}

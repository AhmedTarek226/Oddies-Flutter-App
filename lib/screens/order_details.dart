import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/models/cart_item_details.dart';
import 'package:e_commerce/models/order.dart';
import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/services/store.dart';
import 'package:flutter/material.dart';

class OrderDetails extends StatelessWidget {
  static String id = 'OrderDetails';
  Store _store = Store();
  @override
  Widget build(BuildContext context) {
    Order order = ModalRoute.of(context).settings.arguments;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double size = (height + width) / 2;
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadOrderDetails(order.documentId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //cartItems.addAll({cartItems.length+1:{cartItemDetails.product.Pname:cartItemDetails}});
            Map<int, Map<String, CartItemDetails>> products = {};
            int i = 1;
            for (var doc in snapshot.data.docs) {
              var cartitems = doc.data();
              products.addAll({
                i: {
                  cartitems[KProductName]: CartItemDetails(
                    // product: cartitems.values.elementAt(i).values.single.product,
                    name: cartitems[KProductName],
                    size: cartitems[KProductSize],
                    quantity: cartitems[KProductQuantity],
                    totalprice: cartitems[KProductPrice],
                  )
                }
              });
              i++;
              //print(products.keys.last);
            }
            return Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 8),
                      child: Card(
                        color: Colors.lightGreen[100],
                        //height: MediaQuery.of(context).size.height * .2,
                        child: Padding(
                          padding: const EdgeInsets.all(13),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Name: ${products.values.elementAt(index).values.single.name}',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Size: ${products.values.elementAt(index).values.single.size}',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                products.values
                                            .elementAt(index)
                                            .values
                                            .single
                                            .quantity >
                                        1
                                    ? 'Quantity: ${products.values.elementAt(index).values.single.quantity} Items'
                                    : 'Quantity: ${products.values.elementAt(index).values.single.quantity} Item',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Price: ${products.values.elementAt(index).values.single.totalprice} EGP',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    itemCount: products.keys.length,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: ButtonTheme(
                          height: height * .055,
                          //minWidth: width * .35,
                          buttonColor: Colors.black,
                          child: Builder(
                            builder: (context) => RaisedButton(
                              elevation: 0,
                              onPressed: () async{
                                await _store.updateOrderConfirmation(
                                    {KOrderConfirmed: true}, order.documentId);
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text('confirmed'),
                                ));
                              },
                              child: Text('Confirm Order',
                                  style: TextStyle(
                                      fontSize: size * .028,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700)),
                              //textColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                // borderRadius: BorderRadius.circular(60),
                                side: BorderSide(
                                  color: Colors.black,
                                  width: 1.2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width*.025,
                      ),
                      Expanded(
                        child: ButtonTheme(
                          height: height * .055,
                          //minWidth: width * .35,
                          buttonColor: KMainColor,
                          child: Builder(
                            builder: (context) => RaisedButton(
                              elevation: 0,
                              onPressed: () async{
                                Navigator.pop(context);
                                await _store.deleteOrder(order,context);
                              },
                              child: Text('Cancel Order',
                                  style: TextStyle(
                                      fontSize: size * .028,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700)),
                              textColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                // borderRadius: BorderRadius.circular(60),
                                side: BorderSide(
                                  color: Colors.black,
                                  width: 1.2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          } else {
            return Center(
              child: Text('Loading Order...'),
            );
          }
        },
      ),
    );
  }
}

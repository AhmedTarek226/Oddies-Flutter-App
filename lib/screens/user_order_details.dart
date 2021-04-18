import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/models/cart_item_details.dart';
import 'package:e_commerce/models/order.dart';
import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/provider/user_provider.dart';
import 'package:e_commerce/services/store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserOrderDetails extends StatelessWidget {
  static String id = 'UserOrderDetails';
  Store _store = Store();
  Order order;
  UserOrderDetails({this.order});
  @override
  Widget build(BuildContext context) {
    //Order order = ModalRoute.of(context).settings.arguments;
    final user = Provider.of<UserProvider>(context).currentUser;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double size = (height + width) / 2;
    return Container(
        height: height * .925,
        width: width,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: KMainColor,
            elevation: 0,
            title: Text(
              'order number ${order.orderNumber}'.toUpperCase(),
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
                Icons.keyboard_backspace,
                color: Colors.black,
                size: size * .05,
              ),
            ),
          ),
          body: StreamBuilder<QuerySnapshot>(
            stream: _store.loadOrderDetails(order.documentId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Map<int, Map<String, CartItemDetails>> products = {};
                int i = 1;
                for (var doc in snapshot.data.docs) {
                  var cartitems = doc.data();
                  products.addAll({
                    i: {
                      cartitems[KProductName]: CartItemDetails(
                        // product: cartitems.values.elementAt(i).values.single.product,
                        location: cartitems[KProductLocation],
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
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: width * .01,
                            right: width * .01),
                        child: ListView.builder(
                          itemBuilder: (context, index) => Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: width * .01,
                                vertical: height * .008),
                            child: Column(
                              children: [
                                Card(
                                  color: Colors.lightGreen[100],
                                  //height: MediaQuery.of(context).size.height * .2,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width * .01,
                                        vertical: height * .001),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          'images/${products.values.elementAt(index).values.single.location}',
                                          width: width * .35,
                                          height: height * .3,
                                        ),
                                        SizedBox(
                                          width: width * .025,
                                        ),
                                        Flexible(
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                products.values.elementAt(index).values.single.name.toUpperCase(),
                                                maxLines: 1,
                                                overflow:
                                                TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: size * .027,
                                                    fontWeight:
                                                    FontWeight.w700,
                                                    fontFamily: 'Amiri'),
                                              ),
                                              SizedBox(
                                                height: height * .015,
                                              ),
                                              Text(
                                                products.values.elementAt(index).values.single.size.toUpperCase(),
                                                style: TextStyle(
                                                    fontSize: size * .027,
                                                    fontWeight:
                                                    FontWeight.w700,
                                                    fontFamily: 'Amiri'),
                                              ),
                                              SizedBox(
                                                height: height * .015,
                                              ),
                                              Text(
                                                products.values
                                                    .elementAt(index)
                                                    .values
                                                    .single
                                                    .quantity >
                                                    1
                                                    ? '${products.values.elementAt(index).values.single.quantity} x ${products.values.elementAt(index).values.single.totalprice} EGP'
                                                    : '',
                                                style: TextStyle(
                                                    fontSize: size * .035,
                                                    fontWeight:
                                                    FontWeight.w400,
                                                    fontFamily: 'Amiri'),
                                              ),
                                              SizedBox(
                                                height: height * .015,
                                              ),
                                              Text(
                                                '${products.values.elementAt(index).values.single.totalprice} EGP',
                                                style: TextStyle(
                                                    fontSize: size * .035,
                                                    fontWeight:
                                                    FontWeight.w400,
                                                    fontFamily: 'Amiri'),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: height * .02,
                                ),
                                Container(
                                  height: height * .002,
                                  width: width * .8,
                                  color: Colors.black,
                                ),
                                // SizedBox(
                                //   height: height * .01,
                                // ),
                              ],
                            ),
                          ),
                          itemCount: products.length,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: height * .015),
                      child: ButtonTheme(
                        minWidth: MediaQuery.of(context).size.width * .95,
                        height: MediaQuery.of(context).size.height * .06,
                        buttonColor: Colors.black,
                        child: Builder(
                          builder: (context) => RaisedButton(
                            onPressed: () async {
                                 showCustomDialog(order, context);
                                        },
                            child: Text(
                              'Cancel Order'.toUpperCase(),
                              style: TextStyle(color: Colors.white,fontFamily: 'Karla',
                                  fontSize: size * .027,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.7),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: Text('Loading Order...'),
                );
              }
            },
          ),
        ));
  }

  void showCustomDialog(Order order, context) {
    AlertDialog alertDialog = AlertDialog(
      title: Text('Delete order number ${order.orderNumber} ?'),
      actions: <Widget>[
        MaterialButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Cancel',
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
        ),
        MaterialButton(
          onPressed: () async {
            await  _store.deleteOrder(order,context);
            // await _store.updateUserInfo({
            //   KUserOrderId: FieldValue.arrayRemove([orderNumber])
            // }, Uid);
            Navigator.pop(context);
            Navigator.pop(context);
          },
          child: Text(
            'Delete',
            style: TextStyle(fontSize: 18, color: Colors.red[400]),
          ),
        )
      ],
    );
    showDialog(
        context: context,
        builder: (context) {
          return alertDialog;
        });
  }
}

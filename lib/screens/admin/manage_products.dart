import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/services/store.dart';
import 'package:e_commerce/widgets/custom_popupmenu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'file:///E:/kolya/projects/e_commerce/lib/screens/admin/view_products.dart';

import 'edit_products.dart';

class ManageProducts extends StatefulWidget {
  static String id = 'ManageProducts';
  @override
  _ManageProductsState createState() => _ManageProductsState();
}

class _ManageProductsState extends State<ManageProducts> {
  final _store = Store();

  showAlertDialog(BuildContext context, String productname, String Pid) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text(
        "Cancel",
        style: TextStyle(fontSize: 15),
      ),
      onPressed: () {
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );
    Widget deleteButton = FlatButton(
      child: Text(
        "Delete",
        style: TextStyle(color: Colors.red, fontSize: 15),
      ),
      onPressed: () {
        _store.deleteProduct(Pid);
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        'Would you like to delete $productname ?',
        style: TextStyle(fontSize: 18),
      ),
      //content: Text('Would you like to delete $productname'),
      actions: [
        cancelButton,
        deleteButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<QuerySnapshot>(
          stream: _store.loadProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Product> _products = [];
              for (var doc in snapshot.data.docs) {
                var data = doc.data();
                _products.add(Product(
                  Pprice: data[KProductPrice],
                  Pname: data[KProductName],
                  Plocation: data[KProductLocation],
                  Pcategory: data[KProductCategory],
                  Pdescription: data[KProductDescription],
                  Pid: doc.id,
                ));
              }
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
                  child: GestureDetector(
                    onLongPress: () {
                      Navigator.pushNamed(context, ViewProducts.id,
                          arguments: _products[index]);
                    },
                    onTapUp: (details) {
                      double dx = details.globalPosition.dx;
                      double dy = details.globalPosition.dy;
                      double dx2 = MediaQuery.of(context).size.width - dx;
                      double dy2 = MediaQuery.of(context).size.height - dy;
                      showMenu(
                          context: context,
                          position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
                          items: [
                            MyPopupMenuItem(
                              child: Text('Edit'),
                              onclick: () {
                                Navigator.pushNamed(context, EditProduct.id,
                                    arguments: _products[index]);
                              },
                            ),
                            MyPopupMenuItem(
                              child: Text('Delete'),
                              onclick: () {
                                showAlertDialog(context, _products[index].Pname,
                                    _products[index].Pid);
                                // _store.deleteProduct(_products[index].Pid);
                              },
                            ),
                          ]);
                    },
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: Image.asset('images/${_products[index].Plocation}'),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Opacity(
                              opacity: .7,
                              child: Container(
                                color: Colors.white,
                                height:
                                    MediaQuery.of(context).size.height * .08,
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        _products[index].Pname,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 17),
                                      ),
                                      Text(
                                        '${_products[index].Pprice} EGP',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
                itemCount: _products.length,
              );
            } else
              return Center(child: Text('Loading ...'));
          },
        ),
      ),
    );
  }
}

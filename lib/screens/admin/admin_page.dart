import 'package:e_commerce/constants.dart';
import 'package:e_commerce/screens/view_orders.dart';
import 'package:flutter/material.dart';

import 'file:///E:/kolya/projects/e_commerce/lib/screens/admin/add_product.dart';
import 'file:///E:/kolya/projects/e_commerce/lib/screens/admin/manage_products.dart';

class AdminPage extends StatelessWidget {
  static String id = 'AdminPage';
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double size = (height + width) / 2;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.lightGreen[100],
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(width: double.infinity,),
             ButtonTheme(
              height: height * .065,
              //minWidth: width * .35,
              buttonColor: KMainColor,
              child: Builder(
                builder: (context) => RaisedButton(
                  elevation: 0,
                  onPressed: () {
                    Navigator.pushNamed(context, AddProduct.id);
                  },
                  child: Text('Add Product',
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
            SizedBox(
              height: height * .025,
            ),
            ButtonTheme(
              height: height * .065,
              //minWidth: width * .35,
              buttonColor: KMainColor,
              child: Builder(
                builder: (context) => RaisedButton(
                  elevation: 0,
                  onPressed: () {
                    Navigator.pushNamed(context, ManageProducts.id);
                  },
                  child: Text('Manage Products',
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
            SizedBox(
              height: height * .025,
            ),
            ButtonTheme(
              height: height * .065,
              //minWidth: width * .35,
              buttonColor: KMainColor,
              child: Builder(
                builder: (context) => RaisedButton(
                  elevation: 0,
                  onPressed: () {
                    Navigator.pushNamed(context, ViewOrders.id);
                  },
                  child: Text('View Orders',
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
          ],
        ),
      ),
    );
  }
}

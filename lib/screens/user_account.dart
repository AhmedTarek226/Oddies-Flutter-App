// ignore: avoid_web_libraries_in_flutter
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/models/user_info.dart';
import 'package:e_commerce/provider/cart_item.dart';
import 'package:e_commerce/provider/user_provider.dart';
import 'package:e_commerce/screens/login_page.dart';
import 'package:e_commerce/screens/my_info.dart';
import 'package:e_commerce/screens/my_orders.dart';
import 'package:e_commerce/services/auth.dart';
import 'package:e_commerce/services/store.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class UserAccount extends StatelessWidget {
  static String id = 'UserAccount';

  String _name, _phoneNumber, _address, _addressDetails, _email;

  final _store = Store();
  final _auth = Auth();

  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  UserInformation userOldInfo = UserInformation();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double size = (height + width) / 2;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.clear,
                  size: height * .04,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        body: user.currentUser!=null ?Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * .08, vertical: height * .015),
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Welcome ${user.currentUser.name},'
                    .toUpperCase(),
                style: TextStyle(
                    fontSize: height * .025,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1),
              ),
              SizedBox(
                height: height * .017,
              ),
              Text(
                user.currentUser.email,
                style: TextStyle(
                    fontSize: height * .025,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 2),
              ),
              SizedBox(
                height: height * .12,
              ),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) =>
                          SingleChildScrollView(
                            child: Container(
                              padding: EdgeInsets.only(
                                  bottom: MediaQuery.of(context)
                                      .viewInsets
                                      .bottom),
                              child: MyOrders(),
                            ),
                          ));
                },
                child: Text(
                  'my purchases'.toUpperCase(),
                  style: TextStyle(
                      fontSize: height * .05,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Karla'),
                ),
              ),
              SizedBox(
                height: size * .017,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, MyInfo.id,arguments: user.currentUser);
                  // showModalBottomSheet(
                  //     context: context,
                  //     isScrollControlled: true,
                  //     builder: (context) =>
                  //         SingleChildScrollView(
                  //           child: Container(
                  //             padding: EdgeInsets.only(
                  //                 bottom: MediaQuery.of(context)
                  //                     .viewInsets
                  //                     .bottom,),
                  //             child: MyInfo(
                  //               user: user.currentUser,
                  //             ),
                  //           ),
                  //         ));
                },
                child: Text(
                  'my information'.toUpperCase(),
                  style: TextStyle(
                      fontSize: size * .06,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Karla'),
                ),
              ),
              SizedBox(
                height: height * .017,
              ),
              Text(
                'Help'.toUpperCase(),
                style: TextStyle(
                    fontSize: size * .06,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Karla'),
              ),
              SizedBox(
                height: height * .017,
              ),
              Text(
                'settings'.toUpperCase(),
                style: TextStyle(
                    fontSize: size * .06,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Karla'),
              ),
              SizedBox(
                height: height * .24,
              ),
              Text(
                'Rate this app',
                style: TextStyle(fontSize: size * .03),
              ),
              SizedBox(
                height: height * .017,
              ),
              Text(
                'Recommend this app',
                style: TextStyle(fontSize: size * .03),
              ),
              SizedBox(
                height: height * .017,
              ),
              GestureDetector(
                onTap: () async {
                  // Provider.of<CartItem>(context, listen: false)
                  //     .products
                  //     .clear();
                  SharedPreferences pref =
                  await SharedPreferences.getInstance();
                  pref.clear();
                  await _auth.signOut();
                  Provider.of<UserProvider>(context,
                      listen: false)
                      .clearlist();
                  // Provider.of<UserProvider>(context,
                  //     listen: false)
                  //     .dispose();
                  Navigator.popAndPushNamed(
                      context, loginPage.id);
                },
                child: Text(
                  'End this session',
                  style: TextStyle(fontSize: size * .03),
                ),
              ),
            ],
          ),
        ):Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * .08, vertical: height * .015),
          child: ListView(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, loginPage.id);
                },
                child: Text(
                  'Log In',
                  style: TextStyle(
                    fontSize: height * .025,
                  ),
                ),
              ),
              SizedBox(
                height: height * .1,
              ),
              Text(
                'Help'.toUpperCase(),
                style: TextStyle(
                    fontSize: height * .05,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Karla'),
              ),
              SizedBox(
                height: height * .017,
              ),
              Text(
                'settings'.toUpperCase(),
                style: TextStyle(
                    fontSize: height * .05,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Karla'),
              ),
              SizedBox(
                height: height * .48,
              ),
              Text(
                'Rate this app',
                style: TextStyle(fontSize: height * .025),
              ),
              SizedBox(
                height: height * .017,
              ),
              Text(
                'Recommend this app',
                style: TextStyle(fontSize: height * .025),
              ),
            ],
          ),
        ),
        // body: StreamBuilder<QuerySnapshot>(
        //     stream: _store.loadUsers(),
        //     builder: (context, snapshot) {
        //       if (snapshot.hasData) {
        //         List<UserInformation> users = [];
        //         for (var doc in snapshot.data.docs) {
        //           users.add(UserInformation(
        //             email: doc.get(KUserEmail),
        //             name: doc.get(KUserName),
        //             phoneNumber: doc.get(KUserPhone),
        //             address: doc.get(KUserAddress),
        //             addressDetails: doc.get(KUserAddressDetails),
        //             Uid: doc.id,
        //           ));
        //         }
        //         bool isfound = user.getCurrentUser(users);
        //         //if user is found
        //         if (user.currentUser != null) {
        //           return Padding(
        //             padding: EdgeInsets.symmetric(
        //                 horizontal: width * .08, vertical: height * .015),
        //             child: ListView(
        //              // crossAxisAlignment: CrossAxisAlignment.start,
        //               children: <Widget>[
        //                 Text(
        //                   'Welcome ${user.currentUser.name},'
        //                       .toUpperCase(),
        //                   style: TextStyle(
        //                       fontSize: height * .025,
        //                       fontWeight: FontWeight.w500,
        //                       letterSpacing: 1),
        //                 ),
        //                 SizedBox(
        //                   height: height * .017,
        //                 ),
        //                 Text(
        //                   user.currentUser.email,
        //                   style: TextStyle(
        //                       fontSize: height * .025,
        //                       fontWeight: FontWeight.w400,
        //                       letterSpacing: 2),
        //                 ),
        //                 SizedBox(
        //                   height: height * .12,
        //                 ),
        //                 GestureDetector(
        //                   onTap: () {
        //                     showModalBottomSheet(
        //                         context: context,
        //                         isScrollControlled: true,
        //                         builder: (context) =>
        //                             SingleChildScrollView(
        //                               child: Container(
        //                                 padding: EdgeInsets.only(
        //                                     bottom: MediaQuery.of(context)
        //                                         .viewInsets
        //                                         .bottom),
        //                                 child: MyOrders(),
        //                               ),
        //                             ));
        //                   },
        //                   child: Text(
        //                     'my purchases'.toUpperCase(),
        //                     style: TextStyle(
        //                         fontSize: height * .05,
        //                         fontWeight: FontWeight.bold,
        //                         fontFamily: 'Karla'),
        //                   ),
        //                 ),
        //                 SizedBox(
        //                   height: size * .017,
        //                 ),
        //                 GestureDetector(
        //                   onTap: () {
        //                     Navigator.pushNamed(context, MyInfo.id,arguments: user.currentUser);
        //                     // showModalBottomSheet(
        //                     //     context: context,
        //                     //     isScrollControlled: true,
        //                     //     builder: (context) =>
        //                     //         SingleChildScrollView(
        //                     //           child: Container(
        //                     //             padding: EdgeInsets.only(
        //                     //                 bottom: MediaQuery.of(context)
        //                     //                     .viewInsets
        //                     //                     .bottom,),
        //                     //             child: MyInfo(
        //                     //               user: user.currentUser,
        //                     //             ),
        //                     //           ),
        //                     //         ));
        //                   },
        //                   child: Text(
        //                     'my information'.toUpperCase(),
        //                     style: TextStyle(
        //                         fontSize: size * .06,
        //                         fontWeight: FontWeight.bold,
        //                         fontFamily: 'Karla'),
        //                   ),
        //                 ),
        //                 SizedBox(
        //                   height: height * .017,
        //                 ),
        //                 Text(
        //                   'Help'.toUpperCase(),
        //                   style: TextStyle(
        //                       fontSize: size * .06,
        //                       fontWeight: FontWeight.bold,
        //                       fontFamily: 'Karla'),
        //                 ),
        //                 SizedBox(
        //                   height: height * .017,
        //                 ),
        //                 Text(
        //                   'settings'.toUpperCase(),
        //                   style: TextStyle(
        //                       fontSize: size * .06,
        //                       fontWeight: FontWeight.bold,
        //                       fontFamily: 'Karla'),
        //                 ),
        //                 SizedBox(
        //                   height: height * .24,
        //                 ),
        //                 Text(
        //                   'Rate this app',
        //                   style: TextStyle(fontSize: size * .03),
        //                 ),
        //                 SizedBox(
        //                   height: height * .017,
        //                 ),
        //                 Text(
        //                   'Recommend this app',
        //                   style: TextStyle(fontSize: size * .03),
        //                 ),
        //                 SizedBox(
        //                   height: height * .017,
        //                 ),
        //                 GestureDetector(
        //                   onTap: () async {
        //                     // Provider.of<CartItem>(context, listen: false)
        //                     //     .products
        //                     //     .clear();
        //                     SharedPreferences pref =
        //                         await SharedPreferences.getInstance();
        //                     pref.clear();
        //                     await _auth.signOut();
        //                     Provider.of<UserProvider>(context,
        //                             listen: false)
        //                         .clearlist();
        //                     Provider.of<UserProvider>(context,
        //                             listen: false)
        //                         .dispose();
        //                     Navigator.popAndPushNamed(
        //                         context, loginPage.id);
        //                   },
        //                   child: Text(
        //                     'End this session',
        //                     style: TextStyle(fontSize: size * .03),
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           );
        //         } else {
        //           return Padding(
        //             padding: EdgeInsets.symmetric(
        //                 horizontal: width * .08, vertical: height * .015),
        //             child: ListView(
        //               //crossAxisAlignment: CrossAxisAlignment.start,
        //               children: <Widget>[
        //                 GestureDetector(
        //                   onTap: () {
        //                     Navigator.pushNamed(context, loginPage.id);
        //                   },
        //                   child: Text(
        //                     'Log In',
        //                     style: TextStyle(
        //                       fontSize: height * .025,
        //                     ),
        //                   ),
        //                 ),
        //                 SizedBox(
        //                   height: height * .1,
        //                 ),
        //                 Text(
        //                   'Help'.toUpperCase(),
        //                   style: TextStyle(
        //                       fontSize: height * .05,
        //                       fontWeight: FontWeight.bold,
        //                       fontFamily: 'Karla'),
        //                 ),
        //                 SizedBox(
        //                   height: height * .017,
        //                 ),
        //                 Text(
        //                   'settings'.toUpperCase(),
        //                   style: TextStyle(
        //                       fontSize: height * .05,
        //                       fontWeight: FontWeight.bold,
        //                       fontFamily: 'Karla'),
        //                 ),
        //                 SizedBox(
        //                   height: height * .48,
        //                 ),
        //                 Text(
        //                   'Rate this app',
        //                   style: TextStyle(fontSize: height * .025),
        //                 ),
        //                 SizedBox(
        //                   height: height * .017,
        //                 ),
        //                 Text(
        //                   'Recommend this app',
        //                   style: TextStyle(fontSize: height * .025),
        //                 ),
        //               ],
        //             ),
        //           );
        //         }
        //       } else {
        //         return Center(child: Text('Loading'));
        //       }
        //     }));
    );}
}

//Column(
//                         children: <Widget>[
//                           SizedBox(
//                             height: 20,
//                           ),
//                           Text(
//                             'Welcome ${user.currentUser.name}',
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 20,
//                                 color: Colors.black),
//                           ),
//                           Text(
//                             user.currentUser.email,
//                             style: TextStyle(fontSize: 15, color: Colors.black),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           CustomTextField(
//                             initvalue: user.currentUser.name,
//                             onClick: (value) {
//                               _name = value;
//                             },
//                             hint: 'Your Name',
//                             icon: Icons.contacts,
//                           ),
//                           CustomTextField(
//                             initvalue: user.currentUser.phoneNumber,
//                             onClick: (value) {
//                               _phoneNumber = value;
//                             },
//                             hint: 'Phone Number',
//                             icon: Icons.phone,
//                           ),
//                           CustomTextField(
//                             initvalue: user.currentUser.address,
//                             onClick: (value) {
//                               _address = value;
//                             },
//                             hint: 'Address',
//                             icon: Icons.location_on,
//                           ),
//                           CustomTextField(
//                             initvalue: user.currentUser.addressDetails,
//                             onClick: (value) {
//                               _addressDetails = value;
//                             },
//                             hint: 'Address Details',
//                             icon: Icons.location_on,
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 40, vertical: 10),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: <Widget>[
//                                 RaisedButton(
//                                   onPressed: () async {
//                                     await updateUserInfo(user);
//                                     user.currentUser.address = _address;
//                                     user.currentUser.addressDetails =
//                                         _addressDetails;
//                                     Scaffold.of(context).showSnackBar(SnackBar(
//                                       content: Text('Updated Successfully'),
//                                     ));
//                                   },
//                                   child: Text('Update'),
//                                 ),
//                                 GestureDetector(
//                                   child: Row(
//                                     children: <Widget>[
//                                       Text(
//                                         'TO MY CART',
//                                         style: TextStyle(
//                                             fontSize: 15,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                       Icon(Icons.arrow_forward_ios),
//                                     ],
//                                   ),
//                                   onTap: () async {
//                                     print('address1 is $_address');
//                                     print(
//                                         'address1 prov is: ${user.currentUser.address}');
//                                     await updateUserInfo(user);
//                                     user.currentUser.address = _address;
//                                     user.currentUser.addressDetails =
//                                         _addressDetails;
//                                     Navigator.pushNamed(context, CartScreen.id);
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.pushNamed(context, MyOrders.id);
//                             },
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: <Widget>[
//                                 Icon(
//                                   Icons.list,
//                                   size: 40,
//                                 ),
//                                 Text(
//                                   'MY ORDERS',
//                                   style: TextStyle(fontSize: 20),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),

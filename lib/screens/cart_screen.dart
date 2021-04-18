import 'package:basic_utils/basic_utils.dart';
import 'package:circular_check_box/circular_check_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/models/cart_item_details.dart';
import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/provider/cart_item.dart';
import 'package:e_commerce/provider/user_provider.dart';
import 'package:e_commerce/screens/my_info.dart';
import 'package:e_commerce/screens/product_info.dart';
import 'package:e_commerce/screens/user_account.dart';
import 'package:e_commerce/screens/user_page.dart';
import 'package:e_commerce/services/store.dart';
import 'package:e_commerce/widgets/custom_popupmenu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:text_tools/text_tools.dart';

class CartScreen extends StatefulWidget {
  static String id = 'CartScreen';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int lengthh;
  bool edit = false;
  int counter=1;

  @override
  Widget build(BuildContext context) {
    final _store = Store();
    //CartItem cartItem = Provider.of<CartItem>(context, listen: false);
    //Map<int,Map<String,CartItemDetails>> cartItemss = cartItem.cartItems;
    Map<int, Map<String, CartItemDetails>> products = {};
    //cartItem.cartItems=products;
    final user = Provider
        .of<UserProvider>(context,listen: true)
        .currentUser;
    final double height = MediaQuery
        .of(context)
        .size
        .height;
    final double width = MediaQuery
        .of(context)
        .size
        .width;
    double size = (height + width) / 2;

    return Container(
        height: height * .963,
        width: width,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: AppBar(
                backgroundColor: KMainColor,
                elevation: 0,
                title: Text(
                  'Shopping bag'.toUpperCase(),
                  style: TextStyle(
                      fontSize: size * .032,
                      letterSpacing: 1,
                      fontFamily: 'Karla',
                      color: Colors.black),
                ),
                centerTitle: true,
                actions: products.length > 0
                    ? <Widget>[
                  Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        //todo
                        onTap: ()  {
                          setState(() {
                            edit = !edit;
                            if (edit == false) {
                              //cartItem.removeCheckedMark();
                              _store.cartScreenremoveCheckedMark(products);
                            }
                          });
                        },
                        child: Text(
                          edit == false
                              ? 'edit   '.toUpperCase()
                              : 'done  '.toUpperCase(),
                          style: TextStyle(
                              fontFamily: 'Karla',
                              color: Colors.black,
                              fontSize: size * .027),
                        ),
                      ),
                    ],
                  )
                ]
                    : null,
                leading: edit == true
                    ? null
                    : IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.black,
                    size: size * .05,
                  ),
                  onPressed: () {
                   Navigator.pop(context);
                  },
                )),
          ),
          backgroundColor: Colors.white,
          body:user==null? Column(
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
                    'You have not yet placed shopping bag items',
                    style: TextStyle(
                        fontSize: size * .025, fontWeight: FontWeight.w500),
                  )),
            ],
          ): StreamBuilder<QuerySnapshot>(
            stream: _store.loadCartItems(user.Uid),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data.docs.length>0) {
                //int j = 0;
                for (int i=0;i< snapshot.data.docs.length;i++) {
                  //print('i is: $i');
                  //j++;
                  //print('j is: $j');
                  final cartitems = snapshot.data.docs[i].data();
                  products.addAll({
                    i: {
                      cartitems[KProductName]: CartItemDetails(
                        // product: cartitems.values.elementAt(i).values.single.product,
                        docId: snapshot.data.docs[i].id,
                        location: cartitems[KProductLocation],
                        name: cartitems[KProductName],
                        size: cartitems[KProductSize],
                        quantity: cartitems[KProductQuantity],
                        price: cartitems[KProductPrice],
                        totalprice: cartitems[KTotalPrice],
                      )
                    }
                  });
                  //i++;
                  //print(products.keys.last);
                }
                //cartItemss=products;
                print('products length is: ${products.length}');
                //print('length is: ${cartItemss.length}');
                if (edit == false) {
                  return Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: width * .01,
                              right: width * .01,
                              top: height * .015),
                          child: ListView.builder(
                            itemBuilder: (context, index) =>
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * .01,
                                      vertical: height * .008),
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTapUp: (details)async{
                                          await showCustomMenu(details, context, user.Uid, products.values.elementAt(index).values.single.docId);
                                        },
                                        child: Card(
                                          color: Colors.lightGreen[100],
                                          //height: MediaQuery.of(context).size.height * .2,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: width * .01,
                                                vertical: height * .001),
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  'images/${products
                                                      .values
                                                      .elementAt(index)
                                                      .values
                                                      .single
                                                      .location}',
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
                                                        products.values
                                                            .elementAt(index)
                                                            .values
                                                            .single
                                                            .name.toUpperCase()
                                                            ,
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
                                                        products.values
                                                            .elementAt(index)
                                                            .values
                                                            .single
                                                            .size.toUpperCase(),
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
                                                            ? '${products.values
                                                            .elementAt(index)
                                                            .values
                                                            .single
                                                            .quantity} x ${products.values
                                                            .elementAt(index)
                                                            .values
                                                            .single
                                                            .price} EGP'
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
                                                        '${products
                                                            .values
                                                            .elementAt(index)
                                                            .values
                                                            .single
                                                            .price*products
                                                            .values
                                                            .elementAt(index)
                                                            .values
                                                            .single
                                                            .quantity} EGP',
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
                          minWidth: MediaQuery
                              .of(context)
                              .size
                              .width * .95,
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * .06,
                          buttonColor: Colors.black,
                          child: Builder(
                            builder: (context) =>
                                RaisedButton(
                                  onPressed: () async {
                                    print(user.address);
                                    //todo
                                    await showCustomDialog(user,
                                        products,
                                        context,
                                        user.address,
                                        user.addressDetails,
                                        user.Uid,
                                        size,
                                        width);
                                    await _store.updateUserInfo({
                                      KUserOrderId: FieldValue.arrayUnion(
                                          [lengthh])
                                    }, user.Uid);
                                  },
                                  child: Text(
                                    'order now'.toUpperCase(),
                                    style: TextStyle(color: Colors.white,
                                        fontFamily: 'Karla',
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
                }
                //while editing
                else{
                  return Column(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                            padding: EdgeInsets.only(
                                left: width * .01,
                                right: width * .01,
                                top: height * .015),
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          products.values
                                              .elementAt(index)
                                              .values
                                              .single
                                              .togglechecked();
                                        });
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width * .01,
                                            vertical: height * .008),
                                        child: Column(
                                          children: [
                                            Card(
                                              color: Colors.lightGreen[100],
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: width * .01,
                                                    vertical: height * .001),
                                                child: Row(
                                                  children: [
                                                    Stack(
                                                      children: [
                                                        Image.asset(
                                                          "images/${products
                                                              .values
                                                              .elementAt(index)
                                                              .values
                                                              .single
                                                              .location}",
                                                          width: width * .35,
                                                          height: height * .3,
                                                        ),
                                                        CircularCheckBox(
                                                          checkColor:
                                                          Colors.white,
                                                          activeColor:
                                                          Colors.black,
                                                          inactiveColor:
                                                          Colors.white,
                                                          disabledColor: Colors
                                                              .transparent,
                                                          value: products
                                                              .values
                                                              .elementAt(index)
                                                              .values
                                                              .single
                                                              .checkedincart,
                                                          materialTapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                          onChanged:
                                                              (bool value) {
                                                            setState(() {
                                                              products
                                                                  .values
                                                                  .elementAt(
                                                                  index)
                                                                  .values
                                                                  .single
                                                                  .togglechecked();
                                                            });
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      width: width * .025,
                                                    ),
                                                    Flexible(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: <Widget>[
                                                          Text(
                                                            products
                                                                .values
                                                                .elementAt(
                                                                index)
                                                                .values
                                                                .single
                                                                .name
                                                                .toUpperCase(),
                                                            maxLines: 1,
                                                            overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                            style: TextStyle(
                                                                fontSize: size *
                                                                    .027,
                                                                fontWeight:
                                                                FontWeight.w700,
                                                                fontFamily: 'Amiri'),
                                                          ),
                                                          SizedBox(
                                                            height: height *
                                                                .015,
                                                          ),
                                                          Text(
                                                            products
                                                                .values
                                                                .elementAt(
                                                                index)
                                                                .values
                                                                .single
                                                                .size.toUpperCase(),
                                                            style: TextStyle(
                                                                fontSize: size *
                                                                    .027,
                                                                fontWeight:
                                                                FontWeight.w700,
                                                                fontFamily: 'Amiri'),
                                                          ),
                                                          SizedBox(
                                                            height: height *
                                                                .015,
                                                          ),
                                                          Text(
                                                            products
                                                                .values
                                                                .elementAt(
                                                                index)
                                                                .values
                                                                .single
                                                                .quantity >
                                                                1
                                                                ? '${products
                                                                .values
                                                                .elementAt(
                                                                index)
                                                                .values
                                                                .single
                                                                .quantity} x ${products
                                                                .values
                                                                .elementAt(
                                                                index)
                                                                .values
                                                                .single
                                                                .price} EGP'
                                                                : '',
                                                            style: TextStyle(
                                                                fontSize: size *
                                                                    .035,
                                                                fontWeight:
                                                                FontWeight.w400,
                                                                fontFamily: 'Amiri'),
                                                          ),
                                                          SizedBox(
                                                            height: height *
                                                                .015,
                                                          ),
                                                          Text(
                                                            '${products
                                                                .values
                                                                .elementAt(
                                                                index)
                                                                .values
                                                                .single
                                                                .totalprice} EGP',
                                                            style: TextStyle(
                                                                fontSize: size *
                                                                    .035,
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
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                                },
                                itemCount: products.length)),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: height * .015),
                        child: ButtonTheme(
                          minWidth: MediaQuery
                              .of(context)
                              .size
                              .width * .95,
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * .06,
                          buttonColor: Colors.grey[100],
                          child: Builder(
                            builder: (context) =>
                                RaisedButton(
                                  onPressed: _store.cartScreenOneOrMoreChecked(products) ==
                                      false
                                      ? null
                                      : () async {
                                    setState(() {
                                      _store.cartScreenremoveCheckedProducts(user.Uid, products);
                                      //         _store.setCartItems(user.Uid, cartItem.cartItems);
                                      edit = false;
                                    });
                                    // await _store.setCartItems(
                                    //     user.Uid, cartItemss,context);
                                  },
                                  disabledColor: Colors.grey[200],
                                  disabledTextColor: Colors.grey[500],
                                  child: Text(
                                    'delete'.toUpperCase(),
                                    style: TextStyle(
                                      //color: Colors.black,
                                        fontFamily: 'Karla',
                                        fontSize: size * .027,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.7),
                                  ),
                                  elevation: 0,
                                  shape:_store.cartScreenOneOrMoreChecked(products) == false
                                      ? null
                                      : RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: Colors.black,
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              }
              else if(snapshot.hasData && snapshot.data.docs.length==0){
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
                          'Your shopping bag is empty',
                          style: TextStyle(
                              fontSize: size * .025,
                              fontWeight: FontWeight.w500),
                        )),
                  ],
                );
              }
              else if(snapshot.data==null){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                        child: Text(
                          'loading...'.toUpperCase(),
                          style: TextStyle(
                              fontSize: size * .023,
                              fontWeight: FontWeight.w500),
                        )),
                  ],
                );
              }
             else{
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                        child: Text(
                          'loading...'.toUpperCase(),
                          style: TextStyle(
                              fontSize: size * .023,
                              fontWeight: FontWeight.w500),
                        )),
                  ],
                );
              }
            },

          ),
        )
    );
  }

    showCustomMenu(details, context,Uid,docid) async {
    final _store = Store();
    double dx = details.globalPosition.dx;
    double dy = details.globalPosition.dy;
    double dx2 = MediaQuery.of(context).size.width - dx;
    double dy2 = MediaQuery.of(context).size.height - dy;
    await showMenu(
        context: context,
        position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
        items: [
          // MyPopupMenuItem(
          //   child: Text('Edit'),
          //   onclick: () {
          //     // Navigator.pop(context);
          //     // Provider.of<CartItem>(context, listen: false).deleteProduct(key);
          //     // Navigator.pushNamed(context, ProductInfo.id, arguments: product);
          //   },
          // ),
          MyPopupMenuItem(
            child: Text('Delete'),
            onclick: () async{
              print(docid);
              await _store.cartScreenDeleteProduct(Uid, docid);
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context,CartScreen.id);
              counter++;
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('Deleted Successfully'),backgroundColor: Colors.black,
                duration: Duration(seconds: 1),
              ));
              //Provider.of<CartItem>(context, listen: false).deleteProduct(key);

            },
          ),
        ]);
  }

  void showCustomDialog(user,cartitems, context, String Uaddress,
      String UaddressDetails,Uid, size, width) async {
    var price = getTotalPrice(context,cartitems);
    final length = await getOrdercount();
    // final user = Provider
    //     .of<UserProvider>(context,listen: false)
    //     .currentUser;
    lengthh = length;
    if (Uaddress == "" ||
        Uaddress == null ||
        UaddressDetails == "" ||
        UaddressDetails == null) {
      Navigator.pushNamed(context, UserAccount.id);
    } else {
      AlertDialog alertDialog = AlertDialog(
        title: Text(
          'Total Price : $price EGP'.toUpperCase(),
          style: TextStyle(fontSize: size * .027, fontFamily: 'Karla'),
        ),
        content: Text(
          'Your address is $UaddressDetails in $Uaddress',
          style: TextStyle(fontSize: size * .026, fontFamily: 'Karla'),
        ),
        //actionsOverflowButtonSpacing: 100,
        actions: <Widget>[
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Cancel'.toUpperCase(),
              style: TextStyle(fontSize: size * .021, color: Colors.red),
            ),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, MyInfo.id,arguments: user);
            },
            child: Text(
              'Update Address'.toUpperCase(),
              style: TextStyle(fontSize: size * .021, color: Colors.black),
            ),
          ),
          //todo
          MaterialButton(
            onPressed: () async{
              try {
                final _store = Store();
                await _store.ordersStore({
                  KTotalPrice: price,
                  KAddress: Uaddress,
                  KAddressDetails: UaddressDetails,
                  KUserOrderId: length,
                  KOrderConfirmed: false,
                }, cartitems);
                _store.deleteCartItems(Uid);
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('Ordered Successfully'),backgroundColor: Colors.black,
                ));
              } catch (e) {
                print(e);
              }
              Navigator.pop(context);
            },
            child: Text(
              'Confirm'.toUpperCase(),
              style: TextStyle(fontSize: size * .021, color: Colors.black),
            ),
          ),
        ],
      );
      showDialog(
          context: context,
          builder: (context) {
            return alertDialog;
          });
    }
  }

  int getTotalPrice(context,Map<int,Map<String,CartItemDetails>>cartitems) {
    int price = 0;
    for (int i = 0; i < cartitems.length; i++) {
      price += cartitems.values.elementAt(i).values.single.totalprice;
    }
    return price;
  }

  Future<int> getOrdercount() async {
    final _store = Store();
    int length = await _store.getOrdersCount();
    return length++;
  }

  int add(quantity) {
    if (quantity < 9) return ++quantity;
  }

  int minimize(quantity) {
    if (quantity > 1) return --quantity;
  }
}

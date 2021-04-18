import 'package:e_commerce/constants.dart';
import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/provider/cart_item.dart';
import 'package:e_commerce/provider/favourite_products.dart';
import 'package:e_commerce/provider/save_mode.dart';
import 'package:e_commerce/provider/user_provider.dart';
import 'package:e_commerce/screens/add_size_screen.dart';
import 'package:e_commerce/screens/cart_screen.dart';
import 'package:e_commerce/screens/fav_products_screen.dart';
import 'package:e_commerce/screens/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ProductInfo extends StatefulWidget {
  static String id = 'ProductInfo';
  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  int _quantity = 1;
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  //String selectedCurrency = 'S';
  // List<String> sizes = ['S', 'M', 'L', 'XL'];
  //
  // DropdownButton<String> androidDropdown() {
  //   List<DropdownMenuItem<String>> DropDownItems = [];
  //   for (String item in sizes) {
  //     var newitem = DropdownMenuItem(
  //       child: Text(item),
  //       value: item,
  //     );
  //     DropDownItems.add(newitem);
  //   }
  //
  //   return DropdownButton<String>(
  //     value: selectedCurrency,
  //     items: DropDownItems,
  //     onChanged: (value) {
  //       setState(() {
  //         selectedCurrency = value;
  //         print(selectedCurrency);
  //       });
  //     },
  //   );
  // }
  //
  // CupertinoPicker IOSPicker() {
  //   List<Text> pickeritems = [];
  //   for (String currency in sizes) {
  //     pickeritems.add(Text(currency));
  //   }
  //
  //   return CupertinoPicker(
  //     itemExtent: 32.0,
  //     onSelectedItemChanged: (selectedIndex) {
  //       setState(() {
  //         selectedCurrency = sizes[selectedIndex];
  //         print(selectedCurrency);
  //       });
  //     },
  //     children: pickeritems,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context).settings.arguments;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double size = (height + width) / 2;
    final user = Provider.of<UserProvider>(context,listen: false).currentUser;
    final saveprovider=Provider.of<SaveProductMode>(context, listen: true);
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * .7,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    "images/${product.Plocation}",
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(width * .02, 0, width * .024, 0),
                  child: Container(
                    height: height * .1,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: width*.015),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                Navigator.pop(context);
                              });
                            },
                            child: Icon(
                              Icons.close,
                              size: size * .045,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, CartScreen.id);
                            },
                            child: Icon(
                              Icons.add_shopping_cart,
                              size: size * .035,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * .04, vertical: height * .01),
                child: Container(
                  width: width,
                  height: height * .158,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        product.Pname.toUpperCase(),
                        style: TextStyle(
                            letterSpacing: 1,
                            fontSize: size * .03,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Karla'),
                      ),
                      Text(
                        product.Pdescription,
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: size * .028,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${product.Pprice} EGP',
                            style: TextStyle(
                                fontSize: size * .03,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Karla'),
                          ),
                          // Container(
                          //   height: 40.0,
                          //   alignment: Alignment.center,
                          //   //padding: EdgeInsets.only(bottom: 30.0),
                          //   color: Colors.transparent,
                          //   child: Platform.isIOS
                          //       ? IOSPicker()
                          //       : androidDropdown(),
                          // ),
                          // ToggleButtons(
                          //   children: [Text('S'), Text('M'), Text('L')],
                          //   isSelected: _selections,
                          //   //color: Colors.orangeAccent,
                          //   onPressed: (index) {
                          //     setState(() {
                          //       _selections[index] = true;
                          //       print(index);
                          //     });
                          //   },
                          //   selectedColor: Colors.orangeAccent,
                          //   disabledColor: Colors.grey,
                          //   borderWidth: 1,
                          //   borderColor: Colors.black,
                          // )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * .04),
              child: Row(
                children: <Widget>[
                  ButtonTheme(
                    height: height * .065,
                    minWidth: width * .35,
                    buttonColor: KMainColor,
                    child: Builder(
                      builder: (context) => RaisedButton(
                        elevation: 0,
                        onPressed: () async {
                         if(user == null){
                           _scaffoldKey.currentState.showSnackBar(SnackBar(
                             content: Text(
                               'Please login first',
                               style: TextStyle(fontFamily: 'Karla'),
                             ),
                             backgroundColor: Colors.black,
                             elevation: 0,
                             duration: Duration(seconds: 2),
                             action: SnackBarAction(
                               label: 'login'.toUpperCase(),
                               textColor: Colors.white,
                               onPressed: () {
                                 Navigator.pushNamed(context,loginPage.id);
                               },
                             ),
                           ));
                         }
                         else{
                           // product.Pquantity = _quantity;
                           AddSize addsize=AddSize(product: product,
                             quantity: _quantity,);
                           await showModalBottomSheet(
                               context: context,
                               isScrollControlled: false,
                               isDismissible: true,
                               elevation: 0,
                               backgroundColor: Colors.transparent,
                               barrierColor: Colors.black12,
                               builder: (context) => SingleChildScrollView(
                                   child: addsize
                               ));
                           //if press any thing in bottomsheet print snackbar
                           if(addsize.found){
                             _scaffoldKey.currentState.showSnackBar(SnackBar(
                               content: Text(
                                 'Item added to my cart',
                                 style: TextStyle(fontFamily: 'Karla'),
                               ),
                               backgroundColor: Colors.black,
                               elevation: 0,
                               duration: Duration(seconds: 1,microseconds: 30),
                               action: SnackBarAction(
                                 label: 'view'.toUpperCase(),
                                 textColor: Colors.white,
                                 onPressed: () {
                                   Navigator.pushNamed(context,CartScreen.id);
                                 },
                               ),
                             ));
                           }
                           //addToCart(context, product);
                         }
                        },
                        child: Text('ADD',
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
                    width: width * .14,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        minimize();
                      });
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: size * .04,
                    ),
                  ),
                  SizedBox(
                    width: width * .018,
                  ),
                  Text(
                    _quantity.toString(),
                    style: TextStyle(
                        fontSize: size * .035, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    width: width * .018,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        add();
                      });
                    },
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: size * .04,
                    ),
                  ),
                  SizedBox(
                    width: width * .2,
                  ),
                  GestureDetector(
                    onTap: () {
                      saveprovider
                          .updateSaved(product, context);
                      if(product.saved==true){
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text(
                            'Item added to my list',
                            style: TextStyle(fontFamily: 'Karla'),
                          ),
                          backgroundColor: Colors.black,
                          elevation: 0,
                          duration: Duration(seconds: 1),
                          action: SnackBarAction(
                            label: 'View'.toUpperCase(),
                            textColor: Colors.white,
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) => SingleChildScrollView(
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context).viewInsets.bottom),
                                      child: FavProducts(),
                                    ),
                                  ));
                            },
                          ),
                        ));
                      }
                    },
                    child: Icon(
                      product.saved == true||
                          productinfavourites(
                              context, product)==true
                          ? FontAwesomeIcons.solidBookmark
                          : FontAwesomeIcons.bookmark,
                      size: size * .031,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  int add() {
    if (_quantity < 9) _quantity++;
  }

  int minimize() {
    if (_quantity > 1) _quantity--;
  }
  bool productinfavourites(context, Product product) {
    FavouriteProducts favouriteProducts =
    Provider.of<FavouriteProducts>(context, listen: false);
    //List<Product> productsInCart = [...favouriteProducts.products];
    //bool found = false;
    for (Product productInCart in favouriteProducts.products) {
      if (productInCart.Pname == product.Pname) {
        product.saved=true;
        //found = true;
        return true;
      }
    }
    return false;
    // if (found) {
    //   Scaffold.of(context).showSnackBar(
    //       SnackBar(content: Text('This product is already in your cart')));
    // } else {
    //   Scaffold.of(context)
    //       .showSnackBar(SnackBar(content: Text('Added To Cart')));
    // }
  }

// void addToCart(context, Product product) {
//   CartItem cartItem = Provider.of<CartItem>(context, listen: false);
//   var productsInCart = cartItem.products;
//   product.Pquantity = _quantity;
//   bool found = false;
//   for (var productInCart in productsInCart) {
//     if (productInCart.Pname == product.Pname) {
//       if (productInCart.Psize == product.Psize) {
//         found = true;
//       }
//     }
//   }
//   if (found == true) {
//     //increase quantity
//     int quantity = product.Pquantity + _quantity;
//     if (quantity >= 9)
//       product.Pquantity = 9;
//     else
//       product.Pquantity = quantity;
//   } else
//     cartItem.addProduct(product);
//
//   Scaffold.of(context)
//       .showSnackBar(SnackBar(content: Text('Item is added to my cart')));
// }
//
// void aaddToCart(context, Product product) {
//   CartItem cartItem = Provider.of<CartItem>(context, listen: false);
//   var productsInCart = cartItem.products;
//   bool found = false;
//   for (var productInCart in productsInCart) {
//     if (productInCart.Pname == product.Pname) {
//       found = true;
//     }
//   }
//   if (found) {
//     Scaffold.of(context).showSnackBar(
//         SnackBar(content: Text('This product is already in your cart')));
//   } else {
//     product.Pquantity = _quantity;
//     cartItem.addProduct(product);
//     Scaffold.of(context)
//         .showSnackBar(SnackBar(content: Text('Added To Cart')));
//   }
// }
}

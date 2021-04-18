import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/functions.dart';
import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/provider/favourite_products.dart';
import 'package:e_commerce/provider/save_mode.dart';
import 'package:e_commerce/screens/fav_products_screen.dart';
import 'package:e_commerce/screens/product_info.dart';
import 'package:e_commerce/services/store.dart';
import 'package:e_commerce/widgets/custom_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class ProductView extends StatefulWidget {
  static String id = 'ProductView';

  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  @override
  Widget build(BuildContext context) {
    String category = ModalRoute.of(context).settings.arguments;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double size = (height + width) / 2;
    double itemheight = (height - kToolbarHeight - 40) / 2;
    double itemwidth = width / 2;
    List<Product> _products = [];
    Store _store = Store();
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
            // Navigator.popAndPushNamed(context, UserPage.id);
          },
          child: Icon(
            Icons.keyboard_backspace,
            color: Colors.black,
            size: size * .04,
          ),
        ),
        centerTitle: true,
        title: Text(
          '${category.split(" ").last} Collection',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Karla',
            fontSize: size * .031,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(context),
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadProducts(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: Text('Loading ...'));
          } else {
            List<Product> products = [];
            for (var doc in snapshot.data.docs) {
              var data = doc.data();
              products.add(Product(
                  Pprice: data[KProductPrice].toString(),
                  Pname: data[KProductName],
                  Plocation: data[KProductLocation],
                  Pcategory: data[KProductCategory],
                  Pdescription: data[KProductDescription],
                  Psizes: data[KProductSizes],
                  Pid: doc.id,
                  //saved: false,
                  checkedinfav: false));
            }
            _products = [...products];
            products.clear();
            products = getProductsByCategory(category, _products);
            return Padding(
              padding: EdgeInsets.only(
                  left: width * .025, right: width * .025, top: height * .015),
              child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: (itemwidth / itemheight),
                      crossAxisSpacing: width * .025),
                  itemBuilder: (context, index) {
                    {
                      final saveProvider =
                          Provider.of<SaveProductMode>(context, listen: true);
                      saveProvider.products = [...products];
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, ProductInfo.id,
                              arguments: saveProvider.products[index]);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Image.asset(
                                "images/${saveProvider.products[index].Plocation}",
                                fit: BoxFit.fitWidth,
                                width: width * .5,
                                height: height * .32,
                              ), //just for testing, will fill with image later
                            ),
                            SizedBox(
                              height: height * .01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        saveProvider.products[index].Pname
                                            .toUpperCase(),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        softWrap: false,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                            fontSize: size * .023,
                                            fontFamily: 'Karla'),
                                      ),
                                      Text(
                                        '${saveProvider.products[index].Pprice} EGP',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                            fontFamily: 'Amiri',
                                            fontSize: size * .025),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    try {
                                      saveProvider.updateSaved(
                                          products[index], context);
                                      if(products[index].saved==true){
                                        Scaffold.of(context).showSnackBar(SnackBar(
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
                                    } catch (e) {
                                      print(e);
                                    }
                                  },
                                  child: Icon(
                                    products[index].saved ==true||
                                        productinfavourites(
                                            context, products[index])==true
                                        ? FontAwesomeIcons.solidBookmark
                                        : FontAwesomeIcons.bookmark,
                                    size: size * .025,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    }
                  },
                  itemCount: products.length),
            );
          }
        },
      ),
    );
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
}

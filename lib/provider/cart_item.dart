import 'package:e_commerce/models/cart_item_details.dart';
import 'package:e_commerce/models/product.dart';
import 'package:flutter/cupertino.dart';

class CartItem extends ChangeNotifier {
  //List<Product> products = [];
  Map<int,Map<String,CartItemDetails>> cartItems={};


  // addinmap(String productname,CartItemDetails cartItemDetails){
  //   cartItems.addAll({cartItems.length+1:{productname:cartItemDetails}});
  //   notifyListeners();
  // }

  addProduct(CartItemDetails cartItemDetails) {
    //add product to list of cart products
   // products.add(product);
    //add product with its details to the map
    cartItems.addAll({cartItems.length+1:{cartItemDetails.name:cartItemDetails}});
    notifyListeners();
  }

  deleteProduct(int key) {
  //  products.remove(product);
    cartItems.remove(key);
    notifyListeners();
  }

  updateProduct(product) {
   // products.remove(product);
  }

  //when cancel edit button revert check marks for all products to false
  removeCheckedMark() {
    for(int i=0;i<cartItems.length;i++){
      cartItems.values.elementAt(i).values.single.checkedincart=false;
      notifyListeners();
    }
  }

  //check if user mark any product to appear the delete btn
  bool OneOrMoreChecked() {
    for (int i=0;i<cartItems.length;i++) {
      if (cartItems.values.elementAt(i).values.single.checkedincart == true) {
        return true;
      }
    }
    return false;
  }

  //remove the checked products
  removeCheckedProducts(context) {
    List<int> _deletedProducts = [];
    for (int i=0;i<cartItems.length;i++) {
      if (cartItems.values.elementAt(i).values.single.checkedincart == true) {
        //cartItems.values.elementAt(i).values.single.checkedincart = false;
        _deletedProducts.add(cartItems.keys.elementAt(i));
        print(i);
      }
    }
    for (int i=0;i<_deletedProducts.length;i++) {
      cartItems.remove(_deletedProducts[i]);
      notifyListeners();
    }
  }
}

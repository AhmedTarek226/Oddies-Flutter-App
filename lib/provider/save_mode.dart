import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/provider/favourite_products.dart';
import 'package:e_commerce/screens/fav_products_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SaveProductMode extends ChangeNotifier {
  List<Product> products = [];

  updateSaved(product, context) {
    final favouriteProducts =
        Provider.of<FavouriteProducts>(context, listen: false);
    product.toggleSaved();
    //product.saved=!product.saved;

    print('before  product name ${product.Pname}');
    print('before  product saved? ${product.saved}');
    var productsInFavourite = [...favouriteProducts.products];
    bool found = false;
    int i =0;
    for (Product productInFavourite in productsInFavourite) {
      i++;
      print(i);
      if (productInFavourite.Pname == product.Pname ) {
        found = true;
        print ('found $found');
        if(product.saved==false)
        {
          favouriteProducts.deleteProduct(product);
          print('product deleted');
          //notifyListeners();
          //return;
        }
        else{
          print('product nothing');
        // notifyListeners();
         //return;
        }
      }
    }
    //print (found);
    if (found == false) {
      if(product.saved==true){
        print('product added');
        //print (found);
        favouriteProducts.addProduct(product);
        //notifyListeners();
      }
    }
    notifyListeners();
  }
}

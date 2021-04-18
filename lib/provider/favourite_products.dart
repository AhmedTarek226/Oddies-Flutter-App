import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/provider/save_mode.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class FavouriteProducts extends ChangeNotifier {
  List<Product> products = [];

  addProduct(product) {
    products.add(product);
    notifyListeners();
  }

  deleteProduct(product) {
      products.remove(product);
      notifyListeners();
  }

  removeCheckedMark() {
    for (var product in products) {
      product.checkedinfav = false;
      notifyListeners();
    }
  }

  bool OneOrMoreChecked() {
    for (var product in products) {
      if (product.checkedinfav == true) {
        return true;
      }
    }
    return false;
  }

  removeCheckedProducts(context) {
    List<Product> _deletedProducts = [];
    for (var product in products) {
      if (product.checkedinfav == true) {
        product.togglechecked();
        _deletedProducts.add(product);
      }
    }
    for (var deletedproduct in _deletedProducts) {
      Provider.of<SaveProductMode>(context, listen: false)
          .updateSaved(deletedproduct, context);
    }
  }
}

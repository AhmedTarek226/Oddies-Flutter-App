import 'models/product.dart';

//home_page
List<Product> getProductsByCategory(category, List<Product> allproducts) {
  List<Product> products = [];
  try {
    for (var product in allproducts) {
      if (product.Pcategory == category) products.add(product);
    }
  } catch (e) {
    print(e);
  }
  return products;
}

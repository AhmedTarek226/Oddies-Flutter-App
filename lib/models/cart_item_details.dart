import 'package:e_commerce/models/product.dart';

class CartItemDetails{
  Product product;
  String size;
  int quantity;
  int totalprice;
  int price;
  bool checkedincart;
  String location;
  String name;
  String docId;
  CartItemDetails({
    this.product,
    this.size,
    this.quantity=1,
    this.totalprice,
    this.checkedincart=false,
    this.name,
    this.location,
    this.price,
    this.docId,
});
  void togglechecked() {
    checkedincart = !checkedincart;
  }
}
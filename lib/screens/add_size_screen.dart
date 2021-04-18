import 'package:e_commerce/constants.dart';
import 'package:e_commerce/models/cart_item_details.dart';
import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/provider/cart_item.dart';
import 'package:e_commerce/provider/user_provider.dart';
import 'package:e_commerce/services/store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddSize extends StatelessWidget {
  final Product product;
  final int quantity;
  bool found=false;
  AddSize({this.product, this.quantity});
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double size = (height + width) / 2;
    return Container(
      width: width,
      color: Colors.transparent,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * .42),
            child: Container(
              height: height * .005,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
            ),
          ),
          SizedBox(
            height: height * .015,
          ),
          ConstrainedBox(
            constraints:
                BoxConstraints(maxHeight: height * .45, maxWidth: width * .92),
            child: Container(
              //width: width - 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0.0),
                  topRight: Radius.circular(0.0),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: height * .015),
                child: ListView.builder(
                  itemBuilder: (context,index)=>
                    RaisedButton(
                      color: Colors.white,
                      elevation: 0,
                      splashColor: Colors.grey[100],
                      hoverColor: Colors.grey[100],
                      onPressed: () async{
                        await addToCart(context, product, product.Psizes[index]);
                        Navigator.pop(context);
                        found=true;
                      },
                      child: Text( product.Psizes[index].toString().toUpperCase()),
                    ),
                   itemCount: product.Psizes.length,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * .04),
            child: ButtonTheme(
              buttonColor: Colors.white,
              height: height * .083,
              minWidth: width * .92,
              child: RaisedButton(
                //todo size guide
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Size guide',
                        style: TextStyle(
                            fontSize: size * .028,
                            letterSpacing: .7,
                            color: Colors.black,
                            fontWeight: FontWeight.w500)),
                    SizedBox(
                      width: width * .01,
                    ),
                    Icon(
                      //Icons.wb_incandescent,
                      Icons.help_outline,
                      color: Colors.black,
                      size: size * .033,
                    ),
                  ],
                ),
                textColor: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }

  void addToCart(context, Product product, String size) async{
    CartItem cartItem = Provider.of<CartItem>(context, listen: false);
    final user = Provider.of<UserProvider>(context,listen: false).currentUser;
    final _store=Store();
    Map<int,Map<String,CartItemDetails>> products= await _store.cartScreengetproducts(user.Uid)??{};
    //   var productsInCart = cartItem.products;
    //print(size);
    bool found = false;
    String foundkey;
    int foundindex=0;
    print('naaaaaaaame ${product.Pname}');
    //print('lenth ${products.length}');
    //check if product is found before
    for(int i=0;i<products.length;i++){
      if(products.values.elementAt(i).values.single.name==product.Pname&&products.values.elementAt(i).values.single.size==size){
        found=true;
        foundkey=products.values.elementAt(i).values.single.docId;
        foundindex=i;
        print(products.values.elementAt(i).values.single.size);
        break;
      }
    }
    print('found is : $found');
    if (found == true) {
      //increase quantity
      int productquantity=products.values.elementAt(foundindex).values.single.quantity;
      int quan = productquantity + quantity;
      print(quan);
      if (quan >= 9)
        productquantity = 9;
      else if (quan > productquantity) productquantity = quan;
     // products.values.elementAt(foundindex).values.single.quantity=productquantity;
     // products.values.elementAt(foundindex).values.single.totalprice*=productquantity;
      await _store.cartScreenUpdateQuantity(user.Uid, foundkey,{KProductQuantity: productquantity} );
    } else {
      CartItemDetails cartitemDetails =new CartItemDetails();
      //product.Pquantity = quantity;
      print('size now: $size');
      cartitemDetails.product=product;
      cartitemDetails.size=size;
      cartitemDetails.quantity=quantity;
      cartitemDetails.name=product.Pname;
      cartitemDetails.location=product.Plocation;
      cartitemDetails.price = int.parse(product.Pprice);
      //cartitemDetails.name=product.Pname;
      //total price for this product of this size
      cartitemDetails.totalprice=(cartitemDetails.quantity*int.parse(product.Pprice));
      print('name: ${cartitemDetails.name}, quantity: ${cartitemDetails.quantity}, price: ${cartitemDetails.price}, totalprice: ${cartitemDetails.totalprice}');
      //cartItem.addProduct(cartitemDetails);
      await _store.cartScreenAddProduct(user.Uid,{products.length:{product.Pname:cartitemDetails}});
    }
    //await _store.setCartItems(user.Uid, cartItem.cartItems,context);
  }


  // void addToCart(context, Product product, String size) async{
  //   CartItem cartItem = Provider.of<CartItem>(context, listen: false);
  //   final user = Provider.of<UserProvider>(context,listen: false).currentUser;
  //   final _store=Store();
  //   //   var productsInCart = cartItem.products;
  //   //print(size);
  //   bool found = false;
  //   int foundindex;
  //   print('naaaaaaaame ${product.Pname}');
  //   //check if product is found before
  //       for(int i=0;i<cartItem.cartItems.length;i++){
  //         if(cartItem.cartItems.values.elementAt(i).values.single.name==product.Pname&&cartItem.cartItems.values.elementAt(i).values.single.size==size){
  //           found=true;
  //           foundindex=i;
  //           print(cartItem.cartItems.values.elementAt(i).values.single.size);
  //           break;
  //         }
  //   }
  //   print(found);
  //   if (found == true) {
  //     //increase quantity
  //     int productquantity=cartItem.cartItems.values.elementAt(foundindex).values.single.quantity;
  //     int quan = productquantity + quantity;
  //     print(quan);
  //     if (quan >= 9)
  //       productquantity = 9;
  //     else if (quan > productquantity) productquantity = quan;
  //     cartItem.cartItems.values.elementAt(foundindex).values.single.quantity=productquantity;
  //     cartItem.cartItems.values.elementAt(foundindex).values.single.totalprice*=productquantity;
  //   } else {
  //     CartItemDetails cartitemDetails =new CartItemDetails();
  //     //product.Pquantity = quantity;
  //     print('size now: $size');
  //     cartitemDetails.product=product;
  //     cartitemDetails.size=size;
  //     cartitemDetails.quantity=quantity;
  //     cartitemDetails.name=product.Pname;
  //     cartitemDetails.location=product.Plocation;
  //     //cartitemDetails.name=product.Pname;
  //     //total price for this product of this size
  //     cartitemDetails.totalprice=(cartitemDetails.quantity*int.parse(cartitemDetails.product.Pprice));
  //     print('name: ${cartitemDetails.name}, quantity: ${cartitemDetails.quantity}, price: ${cartitemDetails.product.Pprice}, totalprice: ${cartitemDetails.totalprice}');
  //     cartItem.addProduct(cartitemDetails);
  //   }
  //   await _store.setCartItems(user.Uid, cartItem.cartItems,context);
  // }
}

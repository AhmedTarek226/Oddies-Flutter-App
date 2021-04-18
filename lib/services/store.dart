import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/models/cart_item_details.dart';
import 'package:e_commerce/models/order.dart';
import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/models/user_info.dart';
import 'package:e_commerce/provider/cart_item.dart';
import 'package:e_commerce/provider/user_provider.dart';
import 'package:e_commerce/services/auth.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class Store {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  addProduct(Product newproduct) {
    _firestore.collection(KcollectionName).add({
      KProductName: newproduct.Pname,
      KProductPrice: newproduct.Pprice,
      KProductDescription: newproduct.Pdescription,
      KProductCategory: newproduct.Pcategory,
      KProductLocation: newproduct.Plocation,
      KProductSizes: newproduct.Psizes
    });
  }

  addUser(UserInformation user) {
    _firestore.collection(KUserCollection).add({
      KUserEmail: user.email,
      KUserName: user.name,
      KUserPhone: user.phoneNumber,
      KUserAddress: user.address,
      KUserAddressDetails: user.addressDetails,
    });
  }

  Future<List<int>> getOrdersList(documentId) async {
    List<int> orders = [];
    await _firestore
        .collection(KUserCollection)
        .doc(documentId)
        .get()
        .then((value) {
      List.from(value.get(KUserOrderId)).forEach((element) {
        //print(element);
        orders.add(element);
      });
    });
    return orders;
  }

  updateUserInfo(data, documentId) async{
    await _firestore.collection(KUserCollection).doc(documentId).update(data);
  }

  // updateCartItems(documentId,data){
  //   _firestore.collection(KUserCollection).doc(documentId).
  // }

  Stream<QuerySnapshot> loadProducts() {
    return _firestore
        .collection(KcollectionName)
        .orderBy(KProductName)
        .snapshots();
  }

  Stream<QuerySnapshot> loadUsers() {
    return _firestore.collection(KUserCollection).snapshots();
  }
  Future<void> loadUserss(context) async {
    final _userProvider = Provider.of<UserProvider>(context);
    QuerySnapshot doc = await _firestore.collection(KUserCollection).get();
    List<DocumentSnapshot> docs = doc.docs;
    List<UserInformation> users=[];
    int i=1;
    for(var doc in docs){
      users.add(UserInformation(
        email: doc.get(KUserEmail),
        name: doc.get(KUserName),
        phoneNumber: doc.get(KUserPhone),
        address: doc.get(KUserAddress),
        addressDetails: doc.get(KUserAddressDetails),
        Uid: doc.id,
      ));
      print(i);
      i++;
    }
    bool found=await _userProvider.getCurrentUser(users);
  }

  Stream<QuerySnapshot> loadOrders() {
    return _firestore.collection(KOrders).orderBy(KUserOrderId).snapshots();
  }

  Future<int> getOrdersCount() async {
    QuerySnapshot doc = await _firestore.collection(KOrders).get();
    List<DocumentSnapshot> docsCount = doc.docs;
    return docsCount.length + 1;
  }

  Stream<QuerySnapshot> loadOrderDetails(String documentId) {
    return _firestore
        .collection(KOrders)
        .doc(documentId)
        .collection(KOrderDetails)
        .snapshots();
  }

  Stream<QuerySnapshot> loadCartItems(String Uid) {
    if(Uid==null){
      return null;
    }
    return _firestore
        .collection(KUserCollection)
        .doc(Uid)
        .collection(KUserCartItems)
        .snapshots();
  }

  deleteProduct(documentid) {
    _firestore.collection(KcollectionName).doc(documentid).delete();
  }

  editProduct(data, documentid) {
    _firestore.collection(KcollectionName).doc(documentid).update(data);
  }

  ordersStore(data,Map<int,Map<String,CartItemDetails>>cartitems) {
    var docRef = _firestore.collection(KOrders).doc();
    docRef.set(data);
    for (int i=0;i<cartitems.length;i++) {
      docRef.collection(KOrderDetails).doc().set({
        KProductName: cartitems.values.elementAt(i).values.single.name,
        KProductPrice: cartitems.values.elementAt(i).values.single.totalprice,
        KProductQuantity: cartitems.values.elementAt(i).values.single.quantity,
        KProductLocation: cartitems.values.elementAt(i).values.single.location,
        KProductSize:cartitems.values.elementAt(i).values.single.size,
      });
    }
  }

  setCartItems(documentId,Map<int,Map<String,CartItemDetails>>cartitems,context)async{
    //final provCartItems = Provider.of<CartItem>(context,listen: false);
    var docRef= _firestore.collection(KUserCollection).doc(documentId);
    //await deleteCartItems(documentId);
    Map<int,Map<String,CartItemDetails>> myoldproducts=await deleteandreturn(documentId);
    for(int i=0;i<myoldproducts.length;i++){
      for(int j=0;j<cartitems.length;j++){
        if(cartitems.values.elementAt(j).values.single.name==myoldproducts.values.elementAt(i).values.single.name&&cartitems.values.elementAt(j).values.single.size==myoldproducts.values.elementAt(i).values.single.size){
          print('true ${cartitems.values.elementAt(j).values.single.name}  ${cartitems.values.elementAt(j).values.single.size}');
          int productquantity=cartitems.values.elementAt(j).values.single.quantity;
          int quan = productquantity + myoldproducts.values.elementAt(i).values.single.quantity;
          print(quan);
          if (quan >= 9)
            productquantity = 9;
          else if (quan > productquantity) productquantity = quan;
          cartitems.values.elementAt(j).values.single.quantity=productquantity;
          cartitems.values.elementAt(j).values.single.totalprice*=productquantity;
        }
        else{
          print('false ${cartitems.values.elementAt(j).values.single.name}  ${cartitems.values.elementAt(j).values.single.size}');
          cartitems.addAll({cartitems.length+1:{myoldproducts.values.elementAt(i).values.single.name:CartItemDetails(
            name: myoldproducts.values.elementAt(i).values.single.name,
            totalprice: myoldproducts.values.elementAt(i).values.single.totalprice,
            quantity: myoldproducts.values.elementAt(i).values.single.quantity,
            size: myoldproducts.values.elementAt(i).values.single.size,
            location: myoldproducts.values.elementAt(i).values.single.location,
          )}});
          // provCartItems.addProduct(CartItemDetails(
          //   name: myoldproducts.values.elementAt(i).values.single.name,
          //   totalprice: myoldproducts.values.elementAt(i).values.single.totalprice,
          //   quantity: myoldproducts.values.elementAt(i).values.single.quantity,
          //   size: myoldproducts.values.elementAt(i).values.single.size,
          //   location: myoldproducts.values.elementAt(i).values.single.location,
          // ));
        }}
    }
    print('cartitems length${cartitems.length}');
    print('oldproducts length${myoldproducts.length}');
    for (int i=0;i<cartitems.length;i++) {
       await  docRef.collection(KUserCartItems).doc().set({
        KProductName: cartitems.values.elementAt(i).values.single.name,
        KProductPrice: cartitems.values.elementAt(i).values.single.totalprice,
        KProductQuantity: cartitems.values.elementAt(i).values.single.quantity,
        KProductLocation: cartitems.values.elementAt(i).values.single.location,
        KProductSize:cartitems.values.elementAt(i).values.single.size,
    });
    }
  }

  Future<Map<int, Map<String, CartItemDetails>>> deleteandreturn(documentId)async{
    Map<int,Map<String,CartItemDetails>> products={};
    var docRef= _firestore.collection(KUserCollection).doc(documentId);
    int i=1;
    await docRef.collection(KUserCartItems).get().then((snapshot) { for(DocumentSnapshot ds in snapshot.docs){
      products.addAll({i:{ds.data()[KProductName]:CartItemDetails(
      location: ds.data()[KProductLocation],
      name: ds.data()[KProductName],
      size: ds.data()[KProductSize],
      quantity: ds.data()[KProductQuantity],
      totalprice: ds.data()[KProductPrice],
      )
      }});
      //ds.reference.delete();
      i++;
    }});
    await docRef.collection(KUserCartItems).get().then((snapshot) { for(DocumentSnapshot ds in snapshot.docs){
      ds.reference.delete();
          }});
    return products;
  }

  //delete all the products in cartscreen
  deleteCartItems(documentId)async{
    var docRef= _firestore.collection(KUserCollection).doc(documentId);
    await docRef.collection(KUserCartItems).get().then((snapshot) { for(DocumentSnapshot ds in snapshot.docs){
      ds.reference.delete();
    }});
  }


  updateOrderConfirmation(data, documentId) {
    _firestore.collection(KOrders).doc(documentId).update(data);
  }

  deleteOrder(Order order,context) async{
    final user = Provider.of<UserProvider>(context,listen: false).currentUser;
    var docRef= _firestore.collection(KOrders).doc(order.documentId);
    await _firestore.collection(KOrders).doc(order.documentId).delete();
    await docRef.collection(KOrderDetails).get().then((snapshot) { for(DocumentSnapshot ds in snapshot.docs){
      ds.reference.delete();
    }});

    await updateUserInfo({
      KUserOrderId: FieldValue.arrayRemove([order.orderNumber])
    }, user.Uid);

   // _firestore.collection(KOrders).doc(documentId).collection(KOrderDetails).doc().delete();
  }

  cartScreenAddProduct(Uid, Map<int,Map<String,CartItemDetails>> cartItems){
    var ref = _firestore.collection(KUserCollection).doc(Uid).collection(KUserCartItems);
    for(int i=0;i<cartItems.length;i++){
      ref.add({
        KProductName: cartItems.values.elementAt(i).values.single.name,
        KProductPrice: cartItems.values.elementAt(i).values.single.price,
        KTotalPrice: cartItems.values.elementAt(i).values.single.totalprice,
        KProductQuantity: cartItems.values.elementAt(i).values.single.quantity,
        KProductSize: cartItems.values.elementAt(i).values.single.size,
        KProductLocation: cartItems.values.elementAt(i).values.single.location,
        //KProductKey: _firestore.collection(KUserCollection).doc(Uid).collection(KUserCartItems).,
      });
    }
  }

  cartScreenDeleteProduct(Uid,documentId)async{
    _firestore.collection(KUserCollection).doc(Uid).collection(KUserCartItems).doc(documentId).delete();
  }

  cartScreenUpdateQuantity(Uid,productKey,data){
    _firestore.collection(KUserCollection).doc(Uid).collection(KUserCartItems).doc(productKey).update(data);
  }

  cartScreenremoveCheckedMark(Map<int,Map<String,CartItemDetails>> cartItems) {
    for(int i=0;i<cartItems.length;i++){
      cartItems.values.elementAt(i).values.single.checkedincart=false;
    }
  }

  //check if user mark any product to appear the delete btn
  bool cartScreenOneOrMoreChecked(Map<int,Map<String,CartItemDetails>> cartItems) {
    for (int i=0;i<cartItems.length;i++) {
      if (cartItems.values.elementAt(i).values.single.checkedincart == true) {
        return true;
      }
    }
    return false;
  }

  //remove the checked products
  cartScreenremoveCheckedProducts(Uid,Map<int,Map<String,CartItemDetails>>cartItems) {
    List<String> _deletedProducts = [];
    for (int i=0;i<cartItems.length;i++) {
      if (cartItems.values.elementAt(i).values.single.checkedincart == true) {
        //cartItems.values.elementAt(i).values.single.checkedincart = false;
        _deletedProducts.add(cartItems.values.elementAt(i).values.single.docId);
        //print(i);
      }
    }
    for (int i=0;i<_deletedProducts.length;i++) {
      _firestore.collection(KUserCollection).doc(Uid).collection(KUserCartItems).doc(_deletedProducts[i]).delete();

    }
  }

  Future<Map<int,Map<String,CartItemDetails>>> cartScreengetproducts(Uid) async {
    QuerySnapshot doc = await _firestore.collection(KUserCollection).doc(Uid).collection(KUserCartItems).get();
    List<DocumentSnapshot> docs = doc.docs;
    Map<int,Map<String,CartItemDetails>> products={};
    int i=1;
    for(var doc in docs){
        products.addAll({
          i:{doc.data()[KProductName]:CartItemDetails(
            docId: doc.id,
            location: doc.data()[KProductLocation],
            name: doc.data()[KProductName],
            size: doc.data()[KProductSize],
            quantity: doc.data()[KProductQuantity],
            price: doc.data()[KProductPrice],
            totalprice: doc.data()[KTotalPrice],
          )}
        });
        print('i = $i');
        print('name in store: ${products.values.elementAt(i-1).values.single.name}');
        i++;
    }
    return products;
  }
}

import 'dart:async';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/provider/admin_mode.dart';
import 'package:e_commerce/provider/cart_item.dart';
import 'package:e_commerce/provider/favourite_products.dart';
import 'package:e_commerce/provider/model_hud.dart';
import 'package:e_commerce/provider/save_mode.dart';
import 'package:e_commerce/provider/user_provider.dart';
import 'package:e_commerce/screens/cart_screen.dart';
import 'package:e_commerce/screens/fav_products_screen.dart';
import 'package:e_commerce/screens/login_page.dart';
import 'package:e_commerce/screens/my_info.dart';
import 'package:e_commerce/screens/my_orders.dart';
import 'package:e_commerce/screens/order_details.dart';
import 'package:e_commerce/screens/product_info.dart';
import 'package:e_commerce/screens/sign_up.dart';
import 'package:e_commerce/screens/user_account.dart';
import 'package:e_commerce/screens/user_order_details.dart';
import 'package:e_commerce/screens/user_page.dart';
import 'package:e_commerce/screens/view_orders.dart';
import 'package:e_commerce/services/store.dart';
import 'package:e_commerce/widgets/product_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'file:///E:/kolya/projects/e_commerce/lib/screens/admin/add_product.dart';
import 'file:///E:/kolya/projects/e_commerce/lib/screens/admin/admin_page.dart';
import 'file:///E:/kolya/projects/e_commerce/lib/screens/admin/edit_products.dart';
import 'file:///E:/kolya/projects/e_commerce/lib/screens/admin/manage_products.dart';
import 'file:///E:/kolya/projects/e_commerce/lib/screens/admin/view_products.dart';
import 'package:flutter/services.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp();
  runApp(MyApp());
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
        Duration(seconds: 2),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => UserPage())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFeee7d5),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/logo.jpg'), fit: BoxFit.fitWidth)),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  bool isUserLoggedIn = false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        // if (!snapshot.hasData) {
        //   return MaterialApp(
        //     home: Scaffold(
        //       body: Center(
        //         child: Text('Loading...'),
        //       ),
        //     ),
        //   );
        // } else {
          //isUserLoggedIn = snapshot.data.getBool(KKeepMeLoggedIn) ?? false;
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<UserProvider>(
                create: (context) => UserProvider(),
              ),
              ChangeNotifierProvider<ModelHud>(
                create: (context) => ModelHud(),
              ),
              ChangeNotifierProvider<CartItem>(
                create: (context) => CartItem(),
              ),
              ChangeNotifierProvider<AdminMode>(
                create: (context) => AdminMode(),
              ),
              ChangeNotifierProvider<FavouriteProducts>(
                create: (context) => FavouriteProducts(),
              ),
              ChangeNotifierProvider<SaveProductMode>(
                create: (context) => SaveProductMode(),
              ),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              //initialRoute: UserPage.id,
              home: SplashScreen(),
              //isUserLoggedIn ? UserPage.id : loginPage.id,
              routes: {
                loginPage.id: (context) => loginPage(),
                SignUp.id: (context) => SignUp(),
                UserPage.id: (context) => UserPage(),
                AdminPage.id: (context) => AdminPage(),
                AddProduct.id: (context) => AddProduct(),
                ManageProducts.id: (context) => ManageProducts(),
                EditProduct.id: (context) => EditProduct(),
                ViewProducts.id: (context) => ViewProducts(),
                ProductInfo.id: (context) => ProductInfo(),
                CartScreen.id: (context) => CartScreen(),
                ViewOrders.id: (context) => ViewOrders(),
                OrderDetails.id: (context) => OrderDetails(),
                UserAccount.id: (context) => UserAccount(),
                MyOrders.id: (context) => MyOrders(),
                UserOrderDetails.id: (context) => UserOrderDetails(),
                ProductView.id: (context) => ProductView(),
                FavProducts.id: (context) => FavProducts(),
                MyInfo.id:(context)=>MyInfo(),
              },
            ),
          );
        }
    );
  }
}

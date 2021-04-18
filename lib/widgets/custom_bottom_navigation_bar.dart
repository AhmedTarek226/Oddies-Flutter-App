import 'package:e_commerce/screens/cart_screen.dart';
import 'package:e_commerce/screens/fav_products_screen.dart';
import 'package:e_commerce/screens/user_account.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget CustomBottomNavigationBar(BuildContext context) {
  double myHeight =
      MediaQuery.of(context).size.height * .047; //Your height HERE
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;
  double size = (height + width) / 2;

  return Container(
    color: Colors.white,
    height: myHeight,
    width: MediaQuery.of(context).size.width,
    child: DefaultTabController(
      length: 5,
      child: TabBar(
        onTap: (value) {
          //TODO
          if (value == 0) {
          } else if (value == 1) {
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
          } else if (value == 2) {
          } else if (value == 3) {
            Navigator.pushNamed(context, UserAccount.id);
          } else if (value == 4) {
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: CartScreen(),
                  ),
                ));
          }
        },
        tabs: [
          Tab(
              icon: Icon(
            Icons.search,
            size: size * .032,
            color: Colors.black,
          )),
          Tab(
              icon: Icon(
            FontAwesomeIcons.bookmark,
            size: size * .025,
            color: Colors.black,
          )),
          Tab(
            text: 'MENU',
          ),
          Tab(
              icon: Icon(
            Icons.perm_identity,
            size: size * .033,
            color: Colors.black,
          )),
          Tab(
              icon: Icon(
            Icons.add_shopping_cart,
            size: size * .031,
            color: Colors.black,
          )),
        ],
        labelStyle: TextStyle(
            fontSize: size * .025,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'Amiri'),
        labelColor: Colors.black,
        unselectedLabelColor: Colors.black,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: Colors.white,
      ),
    ),
  );
}

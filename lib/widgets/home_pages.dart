import 'package:e_commerce/constants.dart';
import 'package:e_commerce/widgets/product_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePages {
  List<Widget> get_man_pages(height, context) {
    return [
      Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft:  Radius.circular(30),topRight: Radius.circular(30)),
              image: DecorationImage(
                image: AssetImage('images/cover1.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            constraints: BoxConstraints.expand(),
          ),
          Positioned(
            right: 25,
            left: 25,
            top: height*.28,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'NEW IN',
                  style: TextStyle(
                      fontSize: height * .08,
                      color: Colors.blueGrey[100],
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Discover this week\'s pieces',
                  style: TextStyle(color: Colors.white, fontSize: height * .023),
                ),
                Text(
                  'from our summer collection',
                  style: TextStyle(color: Colors.white, fontSize: height * .023),
                ),
                SizedBox(
                  height: height * .01,
                ),
                RaisedButton(
                  color: Colors.transparent,
                  elevation: 0,
                  child: Text(
                    'View'.toUpperCase(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: height * .023,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 4),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, ProductView.id,
                        arguments: KManSummerCategory);
                    setCategoryName(KManSummerCategory);
                  },
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.white,
                      width: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft:  Radius.circular(30),topRight: Radius.circular(30)),
              image: DecorationImage(
                image: AssetImage('images/cover2.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            constraints: BoxConstraints.expand(),
          ),
          Positioned(
            right: 25,
            left: 25,
            top: height*.28,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Collection'.toUpperCase(),
                  style: TextStyle(
                      fontSize: height * .062,
                      color: Colors.white70,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Explore this week\'s latest menswear pieces',
                  style:
                      TextStyle(color: Colors.blueGrey, fontSize: height * .023),
                ),
                Text(
                  'of the season curated for you',
                  style:
                      TextStyle(color: Colors.blueGrey, fontSize: height * .023),
                ),
                Text(
                  'Autumn Winter Man Collection',
                  style:
                      TextStyle(color: Colors.blueGrey, fontSize: height * .023),
                ),
                SizedBox(
                  height: height * .01,
                ),
                RaisedButton(
                  color: Colors.transparent,
                  elevation: 0,
                  child: Text(
                    'View'.toUpperCase(),
                    style: TextStyle(
                        color: Colors.white54,
                        fontSize: height * .023,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 4),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, ProductView.id,
                        arguments: KManWinterCategory);
                    setCategoryName(KManWinterCategory);
                  },
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.white,
                      width: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft:  Radius.circular(30),topRight: Radius.circular(30)),
              image: DecorationImage(
                image: AssetImage('images/cover3.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            constraints: BoxConstraints.expand(),
          ),
          Positioned(
            right: 25,
            left: 25,
            top: height*.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'shoes & bags'.toUpperCase(),
                  style: TextStyle(
                      fontSize: height * .06,
                      color: Colors.brown[100],
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Explore the new collection',
                  style:
                      TextStyle(color: Colors.white, fontSize: height * .026),
                ),
                Text(
                  'of shoes & bags',
                  style:
                      TextStyle(color: Colors.white, fontSize: height * .026),
                ),
                SizedBox(
                  height: height * .01,
                ),
                RaisedButton(
                  color: Colors.transparent,
                  elevation: 0,
                  child: Text(
                    'View'.toUpperCase(),
                    style: TextStyle(
                        color: Colors.blueGrey[400],
                        fontSize: height * .023,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 4),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, ProductView.id,
                        arguments: KManShoesAndBagsCategory);
                    setCategoryName(KManShoesAndBagsCategory);
                  },
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.blueGrey[400],
                      width: 2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ];
  }

  List<Widget> get_woman_pages(height, context) {
    return [
      Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft:  Radius.circular(30),topRight: Radius.circular(30)),
              image: DecorationImage(
                image: AssetImage('images/cover4.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            constraints: BoxConstraints.expand(),
          ),
          Positioned(
            right: 25,
            left: 25,
            top: height*.28,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'NEW IN',
                  style: TextStyle(
                      fontSize: height * .08,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Discover this week\'s pieces',
                  style: TextStyle(color: Colors.blueGrey[100], fontSize: height * .023),
                ),
                Text(
                  'from our winter collection',
                  style: TextStyle(color: Colors.blueGrey[100], fontSize: height * .023),
                ),
                SizedBox(
                  height: height * .01,
                ),
                RaisedButton(
                  color: Colors.transparent,
                  elevation: 0,
                  child: Text(
                    'View'.toUpperCase(),
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: height * .023,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 4),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, ProductView.id,
                        arguments: KWomanWinterCategory);
                    setCategoryName(KWomanWinterCategory);
                  },
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.grey[400],
                      width: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft:  Radius.circular(30),topRight: Radius.circular(30)),
              image: DecorationImage(
                image: AssetImage('images/cover5.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            constraints: BoxConstraints.expand(),
          ),
          Positioned(
            right: 25,
            left: 25,
            top: height*.28,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'collection'.toUpperCase(),
                  style: TextStyle(
                      fontSize: height * .06,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Explore this week\'s pieces',
                  style: TextStyle(color: Colors.white, fontSize: height * .023),
                ),
                Text(
                  'from our summer collection',
                  style: TextStyle(color: Colors.white, fontSize: height * .023),
                ),
                SizedBox(
                  height: height * .01,
                ),
                RaisedButton(
                  color: Colors.transparent,
                  elevation: 0,
                  child: Text(
                    'View'.toUpperCase(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: height * .023,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 4),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, ProductView.id,
                        arguments: KWomanSummerCategory);
                    setCategoryName(KWomanSummerCategory);
                  },
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.white,
                      width: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft:  Radius.circular(30),topRight: Radius.circular(30)),
              image: DecorationImage(
                image: AssetImage('images/cover6.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            constraints: BoxConstraints.expand(),
          ),
          Positioned(
            right: 25,
            left: 25,
            top: height*.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'shoes & bags'.toUpperCase(),
                  style: TextStyle(
                      fontSize: height * .06,
                      color: Colors.red[100],
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Discover the new collection',
                  style:
                      TextStyle(color: Colors.orange[100], fontSize: height * .023),
                ),
                Text(
                  'of Shoes & Bags',
                  style:
                      TextStyle(color: Colors.orange[100], fontSize: height * .023),
                ),
                SizedBox(
                  height: height * .01,
                ),
                RaisedButton(
                  color: Colors.transparent,
                  elevation: 0,
                  child: Text(
                    'View'.toUpperCase(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: height * .023,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 4),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, ProductView.id,
                        arguments: KWomanShoesAndBagsCategory);
                    setCategoryName(KWomanShoesAndBagsCategory);
                  },
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.white,
                      width: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ];
  }

  List<Widget> get_kids_pages(height, context) {
    return [
      Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft:  Radius.circular(30),topRight: Radius.circular(30)),
              image: DecorationImage(
                image: AssetImage('images/cover7.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            constraints: BoxConstraints.expand(),
          ),
          Positioned(
            right: 25,
            left: 25,
            top: height*.28,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'NEW IN',
                  style: TextStyle(
                      fontSize: height * .08,
                      color: Colors.blueGrey[100],
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Discover this week\'s pieces',
                  style: TextStyle(
                      color: Colors.white60,
                      fontSize: height * .023,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  'from our winter collection',
                  style: TextStyle(
                      color: Colors.white60,
                      fontSize: height * .023,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: height * .01,
                ),
                RaisedButton(
                  color: Colors.transparent,
                  elevation: 0,
                  child: Text(
                    'View'.toUpperCase(),
                    style: TextStyle(
                        color: Colors.white54,
                        fontSize: height * .023,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 4),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, ProductView.id,
                        arguments: KKidsWinterCategory);
                    setCategoryName(KKidsWinterCategory);
                  },
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.white54,
                      width: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft:  Radius.circular(30),topRight: Radius.circular(30)),

              image: DecorationImage(
                image: AssetImage('images/cover8.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            constraints: BoxConstraints.expand(),
          ),
          Positioned(
            right: 10,
            left: 10,
            top: height*.32,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'collection'.toUpperCase(),
                  style: TextStyle(
                      fontSize: height * .06,
                      color: Colors.white54,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Explore this week\'s pieces',
                  style: TextStyle(color: Colors.black54, fontSize: height * .023),
                ),
                Text(
                  'from our summer collection',
                  style: TextStyle(color: Colors.black54, fontSize: height * .023),
                ),
                SizedBox(
                  height: height * .01,
                ),
                RaisedButton(
                  color: Colors.transparent,
                  elevation: 0,
                  child: Text(
                    'View'.toUpperCase(),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: height * .023,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 4),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, ProductView.id,
                        arguments: KKidsSummerCategory);
                    setCategoryName(KKidsSummerCategory);
                  },
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft:  Radius.circular(30),topRight: Radius.circular(30)),

              image: DecorationImage(
                image: AssetImage('images/cover9.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            constraints: BoxConstraints.expand(),
          ),
          Positioned(
            right: 10,
            left: 10,
            top: height*.28,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'shoes & bags'.toUpperCase(),
                  style: TextStyle(
                      fontSize: height * .07,
                      color: Colors.blueGrey[200],
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Discover the new collection',
                  style: TextStyle(color: Colors.grey[100], fontSize: height * .023),
                ),
                Text(
                  'of Shoes & Bags',
                  style: TextStyle(color: Colors.grey[100], fontSize: height * .023),
                ),
                SizedBox(
                  height: height * .01,
                ),
                RaisedButton(
                  color: Colors.transparent,
                  elevation: 0,
                  child: Text(
                    'View'.toUpperCase(),
                    style: TextStyle(
                        color: Colors.blueGrey[200],
                        fontSize: height * .023,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 4),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, ProductView.id,
                        arguments: KKidsShoesAndBagsCategory);
                    setCategoryName(KKidsShoesAndBagsCategory);
                  },
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.white,
                      width: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ];
  }

  setCategoryName(category) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(KCategory, category);
  }
}

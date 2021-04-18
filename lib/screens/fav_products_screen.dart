import 'package:circular_check_box/circular_check_box.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/provider/favourite_products.dart';
import 'package:e_commerce/screens/product_info.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class FavProducts extends StatefulWidget {
  static String id = 'FavProducts';
  @override
  _FavProductsState createState() => _FavProductsState();
}

class _FavProductsState extends State<FavProducts> {
  bool edit = false;
  bool isChecked = false;
  String _category;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double size = (height + width) / 2;
    double itemheight = (height - kToolbarHeight - 40) / 2;
    double itemwidth = width / 2;
    final favouriteProducts = Provider.of<FavouriteProducts>(context);
    return Container(
      height: height * .963,
      width: width,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
              backgroundColor: KMainColor,
              elevation: 0,
              title: Text(
                'mylist'.toUpperCase(),
                style: TextStyle(
                    fontSize: size * .032,
                    letterSpacing: 1,
                    fontFamily: 'Karla',
                    color: Colors.black),
              ),
              centerTitle: true,
              actions: favouriteProducts.products.length > 0
                  ? <Widget>[
                      Column(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          GestureDetector(
                            //todo
                            onTap: () {
                              setState(() {
                                edit = !edit;
                                if (edit == false) {
                                  favouriteProducts.removeCheckedMark();
                                }
                              });
                            },
                            child: Text(
                              edit == false
                                  ? 'edit   '.toUpperCase()
                                  : 'cancel  '.toUpperCase(),
                              style: TextStyle(
                                  fontFamily: 'Karla',
                                  color: Colors.black,
                                  fontSize: size * .027),
                            ),
                          ),
                        ],
                      )
                    ]
                  : null,
              leading: edit == true
                  ? null
                  : IconButton(
                      icon: Icon(
                        Icons.close,
                        color: Colors.black,
                        size: size * .05,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        //Navigator.pop(context);
                        // Navigator.pushNamed(context, UserPage.id);
                        // Navigator.pushNamed(context, ProductView.id,
                        //     arguments: _category);
                      },
                    )),
        ),
        body: favouriteProducts.products.length > 0
            ? edit == false
                //no edit in favourite list of items 'standard form'
                ? Padding(
                    padding: EdgeInsets.only(
                        left: width * .01,
                        right: width * .01,
                        top: height * .015,bottom: 0),
                    child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: (itemwidth / itemheight),
                          crossAxisSpacing: width * .01,
                          mainAxisSpacing: height*.005
                        ),
                        itemBuilder: (context, index) {
                          {
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, ProductInfo.id,
                                    arguments:
                                        favouriteProducts.products[index]);
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        child: Image.asset(
                                          "images/${favouriteProducts.products[index].Plocation}",
                                          fit: BoxFit.fill,
                                          width: width* .4,
                                          height: height*.275,
                                        ), //just for testing, will fill with image later
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        itemCount: favouriteProducts.products.length),
                  )
                //when editing the favourite list
                : Column(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                            padding: EdgeInsets.only(
                                left: width * .01,
                                right: width * .01,
                                top: height * .015),
                            child: GridView.builder(
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: (itemwidth / itemheight),
                                  crossAxisSpacing: width * .01,
                                      mainAxisSpacing: height*.005,
                                    ),
                                itemBuilder: (context, index) {
                                  {
                                    return GestureDetector(
                                      onTap: () {
                                        if (edit == true) {
                                          setState(() {
                                            favouriteProducts.products[index]
                                                .togglechecked();
                                          });
                                        } else {
                                          Navigator.pushNamed(
                                              context, ProductInfo.id,
                                              arguments: favouriteProducts
                                                  .products[index]);
                                        }
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Stack(
                                            children: [
                                              Container(
                                                child: Image.asset(
                                                  "images/${favouriteProducts.products[index].Plocation}",
                                                  fit: BoxFit.fill,
                                                  width: width* .4,
                                                  height: height*.275,
                                                ), //just for testing, will fill with image later
                                              ),
                                              CircularCheckBox(
                                                checkColor: Colors.white,
                                                activeColor: Colors.black,
                                                inactiveColor: Colors.white,
                                                disabledColor:
                                                    Colors.transparent,
                                                value: favouriteProducts
                                                    .products[index]
                                                    .checkedinfav,
                                                materialTapTargetSize:
                                                    MaterialTapTargetSize
                                                        .shrinkWrap,
                                                onChanged: (bool value) {
                                                  setState(() {
                                                    favouriteProducts
                                                        .products[index]
                                                        .togglechecked();
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                },
                                itemCount: favouriteProducts.products.length)),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: height * .02),
                        child: ButtonTheme(
                          minWidth: MediaQuery.of(context).size.width * .915,
                          height: MediaQuery.of(context).size.height * .07,
                          buttonColor: Colors.white,
                          child: Builder(
                            builder: (context) => RaisedButton(
                              onPressed:
                                  favouriteProducts.OneOrMoreChecked() == false
                                      ? null
                                      : () {
                                          // List<Product> _deleted = [];
                                          // for (var product
                                          //     in favouriteProducts.products) {
                                          //   if (product.checkedinfav == true) {
                                          //     print('deleteeeeeeeeeed');
                                          //     product.togglechecked();
                                          //     _deleted.add(product);
                                          //   }
                                          // }
                                          // for (var delete in _deleted) {
                                          //   Provider.of<SaveProductMode>(context,
                                          //           listen: false)
                                          //       .updateSaved(delete, context);
                                          // }
                                          setState(() {
                                            favouriteProducts
                                                .removeCheckedProducts(context);
                                            edit = false;
                                          });
                                        },
                              disabledColor: Colors.grey[200],
                              disabledTextColor: Colors.grey[500],
                              child: Text(
                                'delete'.toUpperCase(),
                                style: TextStyle(
                                    //color: Colors.black,
                                    fontFamily: 'Karla',
                                    fontSize: size * .027,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.7),
                              ),
                              elevation: 0,
                              shape:
                                  favouriteProducts.OneOrMoreChecked() == false
                                      ? null
                                      : RoundedRectangleBorder(
                                          side: BorderSide(
                                            color: Colors.black,
                                            width: 1.5,
                                          ),
                                        ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
            //no favourite items
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.listUl,
                    size: size * .05,
                  ),
                  SizedBox(
                    height: height * .023,
                  ),
                  Center(
                      child: Text(
                    'You have not yet placed favourite items',
                    style: TextStyle(
                        fontSize: size * .025, fontWeight: FontWeight.w500),
                  )),
                ],
              ),
      ),
    );
  }
}

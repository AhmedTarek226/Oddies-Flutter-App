import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/services/auth.dart';
import 'package:e_commerce/services/store.dart';
import 'package:e_commerce/widgets/custom_bottom_navigation_bar.dart';
import 'package:e_commerce/widgets/dots_indicator.dart';
import 'package:e_commerce/widgets/home_pages.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class UserPage extends StatefulWidget {
  static String id = 'User';

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage>
    with SingleTickerProviderStateMixin {
  int _tabindex = 0;
  final _store = Store();
  List<Product> _products = [];
  final _auth = Auth();
  int picnum = 1;
  PageController _woman_page_controller = new PageController();
  PageController _kids_page_controller = new PageController();
  PageController _man_page_controller = new PageController();
  TabController _tabController;
  HomePages homepages = HomePages();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
    _tabController.index=1;
  }

  @override
  void dispose() {
    _tabController.dispose();
    _man_page_controller.dispose();
    _woman_page_controller.dispose();
    _kids_page_controller.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    setState(() {
      _tabindex = _tabController.index;
      if (_tabController.index == 0) {
        picnum = 1;
      } else if (_tabController.index == 1) {
        picnum = 4;
      } else if (_tabController.index == 2) {
        picnum = 7;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    _store.loadUserss(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      bottomNavigationBar: CustomBottomNavigationBar(context),
      body: Stack(
        children: [
          // Container(
          //   decoration: BoxDecoration(
          //     image: DecorationImage(
          //       image: AssetImage('images/logooo.jpg'),
          //       fit: BoxFit.fitWidth,
          //     ),
          //   ),
          //   constraints: BoxConstraints.expand(),
          // ),
          Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              toolbarHeight: 50,
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: Colors.black,
              bottom: TabBar(
                  controller: _tabController,
                  indicatorWeight: 2,
                  indicatorSize: TabBarIndicatorSize.label,
                  isScrollable: true,
                  indicatorColor: Colors.grey[200],
                  onTap: (value) {
                    setState(() {
                      //TODO
                      _tabindex = value;
                      if (value == 0) {
                        if (_man_page_controller.hasClients) {
                          _man_page_controller.animateToPage(
                            0,
                            duration: KDuration,
                            curve: KCurve,
                          );
                        }
                        //picnum = 1;
                      } else if (value == 1) {
                        if (_woman_page_controller.hasClients) {
                          _woman_page_controller.animateToPage(
                            0,
                            duration: KDuration,
                            curve: KCurve,
                          );
                        }
                        //picnum = 4;
                      } else if (value == 2) {
                        if (_kids_page_controller.hasClients) {
                          _kids_page_controller.animateToPage(
                            0,
                            duration: KDuration,
                            curve: KCurve,
                          );
                        }
                        //picnum = 7;
                      }
                    });
                  },
                  tabs: [
                    Text(
                      'Man'.toUpperCase(),
                      style: TextStyle(
                          color: Colors.grey[200],
                          fontSize: _tabindex == 0 ? 17 : 14),
                    ),
                    Text(
                      'woman'.toUpperCase(),
                      style: TextStyle(
                          color: Colors.grey[200],
                          fontSize: _tabindex == 1 ? 17 : 14),
                    ),
                    Text(
                      'kids'.toUpperCase(),
                      style: TextStyle(
                          color: Colors.grey[200],
                          fontSize: _tabindex == 2 ? 17 : 14),
                    ),
                  ]),
            ),
            body: TabBarView(
              controller: _tabController,
              dragStartBehavior: DragStartBehavior.start,
              children: <Widget>[
                //man_page_view
                Stack(
                  children: [
                    new PageView(
                      onPageChanged: (i) {
                        setState(() {
                          i++;
                          //picnum = i;
                        });
                      },
                      controller: _man_page_controller,
                      physics: new AlwaysScrollableScrollPhysics(),
                      dragStartBehavior: DragStartBehavior.down,
                      scrollDirection: Axis.vertical,
                      children: homepages.get_man_pages(height, context),
                    ),
                    Positioned(
                      bottom: 0.0,
                      top: 0.0,
                      right: 0.0,
                      child: new Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.only(right: 10),
                        child: new Center(
                          child: new DotsIndicator(
                            controller: _man_page_controller,
                            itemCount: 3,
                            onPageSelected: (int page) {
                              setState(() {
                                _man_page_controller.animateToPage(
                                  page,
                                  duration: KDuration,
                                  curve: KCurve,
                                );
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                //woman_page_view
                Stack(
                  children: [
                    new PageView(
                      dragStartBehavior: DragStartBehavior.down,
                      //physics: NeverScrollableScrollPhysics(),
                      controller: _woman_page_controller,
                      scrollDirection: Axis.vertical,
                      physics: new AlwaysScrollableScrollPhysics(),
                      onPageChanged: (i) {
                        setState(() {
                          i += 4;
                          picnum = i;
                        });
                      },
                      children: homepages.get_woman_pages(height, context),
                    ),
                    Positioned(
                      bottom: 0.0,
                      top: 0.0,
                      right: 0.0,
                      child: new Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.only(right: 10),
                        child: new Center(
                          child: new DotsIndicator(
                            controller: _woman_page_controller,
                            itemCount: 3,
                            onPageSelected: (int page) {
                              setState(() {
                                _woman_page_controller.animateToPage(
                                  page,
                                  duration: KDuration,
                                  curve: KCurve,
                                );
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                //kids_page_view
                Stack(
                  children: [
                    new PageView(
                      allowImplicitScrolling: true,
                      onPageChanged: (i) {
                        setState(() {
                          i += 7;
                          picnum = i;
                        });
                      },
                      dragStartBehavior: DragStartBehavior.down,
                      physics: new AlwaysScrollableScrollPhysics(),
                      controller: _kids_page_controller,
                      scrollDirection: Axis.vertical,
                      children: homepages.get_kids_pages(height, context),
                    ),
                    Positioned(
                      bottom: 0.0,
                      top: 0.0,
                      right: 0.0,
                      child: new Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.only(right: 10),
                        child: new Center(
                          child: new DotsIndicator(
                            controller: _kids_page_controller,
                            itemCount: 3,
                            onPageSelected: (int page) {
                              setState(() {
                                _kids_page_controller.animateToPage(
                                  page,
                                  duration: KDuration,
                                  curve: KCurve,
                                );
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget jacketView() {
  //   return Scaffold(
  //     body: StreamBuilder<QuerySnapshot>(
  //       stream: _store.loadProducts(),
  //       builder: (context, snapshot) {
  //         if (snapshot.hasData) {
  //           List<Product> products = [];
  //           for (var doc in snapshot.data.docs) {
  //             var data = doc.data();
  //             products.add(Product(
  //               Pprice: data[KProductPrice],
  //               Pname: data[KProductName],
  //               Plocation: data[KProductLocation],
  //               Pcategory: data[KProductCategory],
  //               Pdescription: data[KProductDescription],
  //               Pid: doc.id,
  //             ));
  //           }
  //           _products = [...products];
  //           products.clear();
  //           products = getProductsByCategory(KjacketsCategory, _products);
  //           return GridView.builder(
  //             gridDelegate:
  //                 SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
  //             itemBuilder: (context, index) => Padding(
  //               padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
  //               child: GestureDetector(
  //                 onTap: () {
  //                   Navigator.pushNamed(context, ProductInfo.id,
  //                       arguments: products[index]);
  //                 },
  //                 child: Stack(
  //                   children: <Widget>[
  //                     Positioned.fill(
  //                       child: Image.asset(products[index].Plocation),
  //                     ),
  //                     Positioned(
  //                       bottom: 0,
  //                       child: Opacity(
  //                           opacity: .7,
  //                           child: Container(
  //                             color: Colors.white,
  //                             height: MediaQuery.of(context).size.height * .08,
  //                             width: MediaQuery.of(context).size.width,
  //                             child: Padding(
  //                               padding: EdgeInsets.symmetric(
  //                                   vertical: 5, horizontal: 5),
  //                               child: Column(
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: <Widget>[
  //                                   Text(
  //                                     products[index].Pname,
  //                                     style: TextStyle(
  //                                         fontWeight: FontWeight.bold,
  //                                         color: Colors.black,
  //                                         fontSize: 17),
  //                                   ),
  //                                   Text(
  //                                     '${products[index].Pprice} EGP',
  //                                     style: TextStyle(
  //                                         fontWeight: FontWeight.bold,
  //                                         color: Colors.black,
  //                                         fontSize: 15),
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                           )),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //             itemCount: products.length,
  //           );
  //         } else
  //           return Center(child: Text('Loading ...'));
  //       },
  //     ),
  //   );
  // }
}

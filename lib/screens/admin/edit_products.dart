import 'dart:io';

import 'package:e_commerce/constants.dart';
import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/services/store.dart';
import 'package:e_commerce/widgets/custom_text_field.dart';
import 'package:e_commerce/widgets/new_custom_text_field.dart';
import 'package:flutter/material.dart';

class EditProduct extends StatefulWidget {
  static String id = 'EditProduct';

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  String _name, _price, _description, _category, _location,_sizes;
  List<String> sizes = [];

  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final store = Store();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  File _image;

  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context).settings.arguments;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double size = (height + width) / 2;
    //downLoadImage(product.Plocation);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Form(
          key: _globalKey,
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: width*.05),
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: height * .14,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // CircleAvatar(
                    //   backgroundImage: Image.asset(),
                    //   radius: 70,
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: <Widget>[
                    //     CircleAvatar(
                    //       backgroundImage:
                    //           _image == null ? null : FileImage(_image),
                    //       radius: 70,
                    //     ),
                    //     Column(
                    //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //       children: <Widget>[
                    //         GestureDetector(
                    //           onTap: () {
                    //             pickImagefromCamera();
                    //           },
                    //           child: Icon(
                    //             Icons.camera_alt,
                    //             size: 30,
                    //           ),
                    //         ),
                    //         GestureDetector(
                    //           onTap: () {
                    //             pickImagefromGallery();
                    //           },
                    //           child: Icon(
                    //             Icons.edit,
                    //             size: 30,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ],
                    // ),
                    SizedBox(
                      height: height * .025,
                    ),
                    NewCustomTextField(
                      label: 'Product Name',
                      onClick: (value){
                        _name=value;
                      },
                    ),
                    SizedBox(
                      height: height * .025,
                    ),
                    NewCustomTextField(
                      label: 'Product Price',
                      onClick: (value) {
                        _price = value;
                      },
                    ),
                    SizedBox(
                      height: height * .025,
                    ),
                    NewCustomTextField(
                      label: 'Product Description',
                      onClick: (value) {
                        _description = value;
                      },
                    ),
                    SizedBox(
                      height: height * .025,
                    ),
                    NewCustomTextField(
                      label: 'Product Category',
                      onClick: (value) {
                        _category = value;
                      },
                    ),
                    SizedBox(
                      height: height * .025,
                    ),
                    NewCustomTextField(
                      label: 'Product Location',
                      onClick: (value) {
                        _location = value;
                      },
                    ),
                    SizedBox(
                      height: height * .025,
                    ),
                    NewCustomTextField(
                      label: 'Product Sizes',
                      onClick: (value) {
                        _sizes = value;
                        sizes = _sizes.split(",");
                      },
                    ),
                    SizedBox(
                      height: height * .04,
                    ),
                    ButtonTheme(
                      height: height * .065,
                      //minWidth: width * .35,
                      buttonColor: KMainColor,
                      child: Builder(
                        builder: (context) => RaisedButton(
                          elevation: 0,
                          onPressed: (){
                            if (_globalKey.currentState.validate()) {
                              _globalKey.currentState.save();
                              store.editProduct(
                                  ({
                                    KProductName: _name,
                                    KProductPrice: _price,
                                    KProductDescription: _description,
                                    KProductCategory: _category,
                                    KProductLocation: _location,
                                    KProductSizes: sizes
                                  }),
                                  product.Pid);
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text('Updated successfully'),
                              ));
                            } else {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text('Please complete the empty places'),
                              ));
                            }
                          },
                          child: Text('Update Product',
                              style: TextStyle(
                                  fontSize: size * .028,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700)),
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            // borderRadius: BorderRadius.circular(60),
                            side: BorderSide(
                              color: Colors.black,
                              width: 1.2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  // pickImagefromCamera() async {
  //   PickedFile pickedFile =
  //       await ImagePicker().getImage(source: ImageSource.camera);
  //   File image = File(pickedFile.path);
  //   setState(() {
  //     _image = image;
  //   });
  // }
  //
  // pickImagefromGallery() async {
  //   PickedFile pickedFile =
  //       await ImagePicker().getImage(source: ImageSource.gallery);
  //   File image = File(pickedFile.path);
  //   setState(() {
  //     _image = image;
  //   });
  // }
  //
  // downLoadImage(url) async {
  //   var imageId = await ImageDownloader.downloadImage(url);
  //   var path = await ImageDownloader.findPath(imageId);
  //   File image = File(path);
  //   setState(() {
  //     _image = image;
  //   });
  // }
}

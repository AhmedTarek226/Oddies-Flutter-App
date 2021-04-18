import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/services/store.dart';
import 'package:e_commerce/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewProducts extends StatelessWidget {
  static String id = 'ViewProducts';
  String _name, _price, _description, _category, _location;
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final store = Store();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    Product product = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white70,
      body: Form(
          key: _globalKey,
          child: ListView(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: height * .025,
                  ),
                  Image(
                    image: AssetImage(product.Plocation),
                  ),
                  SizedBox(
                    height: height * .025,
                  ),
                  CustomTextField(
                    hint: 'Product Name: ${product.Pname}',
                    onClick: (value) {
                      _name = value;
                    },
                    readonly: true,
                  ),
                  SizedBox(
                    height: height * .025,
                  ),
                  CustomTextField(
                    hint: 'Product Price: ${product.Pprice}',
                    onClick: (value) {
                      _price = value;
                    },
                    readonly: true,
                  ),
                  SizedBox(
                    height: height * .025,
                  ),
                  CustomTextField(
                    hint: 'Product Description: ${product.Pdescription}',
                    onClick: (value) {
                      _description = value;
                    },
                    readonly: true,
                  ),
                  SizedBox(
                    height: height * .025,
                  ),
                  CustomTextField(
                    hint: 'Product Category: ${product.Pcategory}',
                    onClick: (value) {
                      _category = value;
                    },
                    readonly: true,
                  ),
                  SizedBox(
                    height: height * .025,
                  ),
                  CustomTextField(
                    hint: 'Image location: ${product.Plocation}',
                    onClick: (value) {
                      _location = value;
                    },
                    readonly: true,
                  ),
                  SizedBox(
                    height: height * .04,
                  ),
                ],
              ),
            ],
          )),
    );
  }
}

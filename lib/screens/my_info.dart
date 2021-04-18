import 'package:e_commerce/models/user_info.dart';
import 'package:e_commerce/provider/model_hud.dart';
import 'package:e_commerce/provider/user_provider.dart';
import 'package:e_commerce/services/store.dart';
import 'package:e_commerce/widgets/new_custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
final GlobalKey<FormState> _globalKey =new GlobalKey<FormState>();

class MyInfo extends StatelessWidget {
  static String id='My Info';
  final _store = Store();
  String _name, _phoneNumber, _address, _addressDetails;
  @override
  Widget build(BuildContext context) {
    //UserInformation user = ModalRoute.of(context).settings.arguments;
    final user=Provider.of<UserProvider>(context,listen: true).currentUser;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double size = (height + width) / 2;
    return Scaffold(
      backgroundColor: KMainColor,
      appBar: AppBar(
        backgroundColor: KMainColor,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.clear,
            color: Colors.black,
          ),
        ),
        title: Text(
          'my information'.toUpperCase(),
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: size * .032,
              fontFamily: 'Karla'),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _globalKey,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * .04, vertical: height * .005),
          child: ListView.builder(itemBuilder: (context,index)=>
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * .08,
                ),
                Text(
                  'personal details'.toUpperCase(),
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Karla',
                      fontSize: size * .038),
                ),

                SizedBox(
                  height: height * .08,
                ),
                NewCustomTextField(
                  label: 'Name',
                  initvalue: user.name,
                  onClick: (value) {
                    _name = value;
                  },
                ),
                SizedBox(
                  height: height * .015,
                ),
                NewCustomTextField(
                  label: 'Phone Number',
                  initvalue: user.phoneNumber,
                  onClick: (value) {
                    _phoneNumber = value;
                  },
                ),
                SizedBox(
                  height: height * .015,
                ),
                NewCustomTextField(
                  label: 'Address',
                  initvalue: user.address,
                  onClick: (value) {
                    _address = value;
                  },
                ),
                SizedBox(
                  height: height * .015,
                ),
                NewCustomTextField(
                  label: 'Flat number (Address Details)',
                  initvalue: user.addressDetails,
                  onClick: (value) {
                    _addressDetails = value;
                  },
                ),
                SizedBox(
                  height: height * .08,
                ),
                ButtonTheme(
                  minWidth: MediaQuery.of(context).size.width * .927,
                  height: MediaQuery.of(context).size.height * .05,
                  buttonColor: Colors.black,
                  child: Builder(
                    builder: (context) => RaisedButton(
                      onPressed: () async {
                        final modalhud =
                        Provider.of<ModelHud>(context, listen: false);
                        modalhud.changeisloading(true);
                        if (_globalKey.currentState.validate()) {
                          try {
                            _globalKey.currentState.save();
                            //TODO
                            await updateUserInfo(user);
                            user.address = _address;
                            user.addressDetails = _addressDetails;
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'My information is updated successfully'),
                              duration: Duration(seconds: 1),
                              backgroundColor: Colors.black,
                              //animation
                            ));
                            modalhud.changeisloading(false);
                            //Navigator.pop(context);
                          } catch (e) {
                            modalhud.changeisloading(false);
                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text(e.message)));
                          }
                        }
                      },
                      child: Text(
                        'save'.toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: size * .025,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            itemCount: 1,
          ),
        ),
      ),
    );
  }

  Future<void> updateUserInfo(user) async {
    if (_globalKey.currentState.validate()) {
      _globalKey.currentState.save();
      await _store.updateUserInfo({
        KUserName: _name,
        KUserPhone: _phoneNumber,
        KUserEmail: user.email,
        KUserAddress: _address,
        KUserAddressDetails: _addressDetails
      }, user.Uid);
    }
  }
}

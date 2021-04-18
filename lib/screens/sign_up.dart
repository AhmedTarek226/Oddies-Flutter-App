import 'package:e_commerce/constants.dart';
import 'package:e_commerce/models/user_info.dart';
import 'package:e_commerce/provider/model_hud.dart';
import 'package:e_commerce/screens/user_page.dart';
import 'package:e_commerce/services/store.dart';
import 'package:e_commerce/widgets/new_custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class SignUp extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  final _store = Store();

  static String id = 'SignUp';
  String _email, _password, _name, _phoneNumber;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double size = (height + width) / 2;
    return Scaffold(
      backgroundColor: KMainColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.black,
            size: size * .045,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).isloading,
        child: Form(
          key: _globalKey,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width * .04, vertical: height * .025),
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: height * .12,
                ),
                Text(
                  'PERSONAL DETAILS',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: height * .029,
                      letterSpacing: .6,
                      fontFamily: 'Karla'),
                ),
                SizedBox(
                  height: height * .08,
                ),
                NewCustomTextField(
                  label: 'Email',
                  onClick: (value) {
                    _email = value;
                  },
                ),
                SizedBox(
                  height: height * .015,
                ),
                NewCustomTextField(
                  label: 'Password',
                  onClick: (value) {
                    _password = value;
                  },
                ),
                SizedBox(
                  height: height * .015,
                ),
                NewCustomTextField(
                  label: 'Name',
                  onClick: (value) {
                    _name = value;
                  },
                ),
                SizedBox(
                  height: height * .015,
                ),
                NewCustomTextField(
                  label: 'Phone Number',
                  onClick: (value) {
                    _phoneNumber = value;
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
                            final authResult =
                                await _auth.createUserWithEmailAndPassword(
                                    email: _email, password: _password);
                            await _store.addUser(UserInformation(
                              name: _name,
                              email: _email,
                              phoneNumber: _phoneNumber,
                            ));
                            modalhud.changeisloading(false);
                            Navigator.pushNamed(context, UserPage.id);
                          } catch (e) {
                            modalhud.changeisloading(false);
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(e.message),
                              backgroundColor: Colors.black,
                            ));
                          }
                        }
                        modalhud.changeisloading(false);
                      },
                      child: Text(
                        'Register'.toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

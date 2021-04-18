import 'package:e_commerce/constants.dart';
import 'package:e_commerce/provider/admin_mode.dart';
import 'package:e_commerce/provider/model_hud.dart';
import 'package:e_commerce/screens/sign_up.dart';
import 'package:e_commerce/screens/user_page.dart';
import 'package:e_commerce/services/auth.dart';
import 'package:e_commerce/widgets/new_custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'file:///E:/kolya/projects/e_commerce/lib/screens/admin/admin_page.dart';

class loginPage extends StatefulWidget {
  static String id = 'loginPage';
  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  final _auth = Auth();

  String _email, _password;

  final AdminPassword = 'admin123';

  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  bool isAdmin = false;

  bool keepMeLoggedIn = false;

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
            padding: EdgeInsets.symmetric(horizontal: width * .05),
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: height * .17,
                ),
                Center(
                    child: Text(
                  'Log in with your email address',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: size * .027,
                      fontFamily: 'Oswald'),
                )),
                SizedBox(
                  height: height * .02,
                ),
                NewCustomTextField(
                  label: 'Email',
                  onClick: (value) {
                    _email = value;
                  },
                ),
                SizedBox(
                  height: height * .01,
                ),
                NewCustomTextField(
                  label: 'Password',
                  onClick: (value) {
                    _password = value;
                  },
                ),
                SizedBox(
                  height: height * .03,
                ),
                ButtonTheme(
                  minWidth: width * .91,
                  height: height * .05,
                  buttonColor: Colors.black,
                  child: Builder(
                    builder: (context) => RaisedButton(
                      onPressed: () async {
                        Provider.of<AdminMode>(context, listen: false)
                            .changeisAdmin(false);
                        KeepUserLoggedIn();
                        _validate(context);
                      },
                      child: Text(
                        'log in'.toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: size * .025,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * .012,
                ),
                Row(
                  children: <Widget>[
                    Theme(
                      child: Checkbox(
                        checkColor: Colors.white,
                        activeColor: Colors.black,
                        value: keepMeLoggedIn,
                        onChanged: (value) {
                          setState(() {
                            keepMeLoggedIn = value;
                          });
                        },
                      ),
                      data: ThemeData(backgroundColor: Colors.white),
                    ),
                    Text(
                      'Remember Me',
                      style: TextStyle(
                          fontSize: size * .0255, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * .15,
                ),
                ButtonTheme(
                  height: height * .055,
                  buttonColor: KMainColor,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * .2),
                    child: Builder(
                      builder: (context) => RaisedButton(
                        elevation: 0,
                        onPressed: () {
                          Provider.of<AdminMode>(context, listen: false)
                              .changeisAdmin(true);
                          _validate(context);
                        },
                        child: Text('Log in as admin',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.black,
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * .012,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Don\'t have an account? ',
                      style:
                          TextStyle(color: Colors.black, fontSize: size * .025),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, SignUp.id);
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(
                            letterSpacing: .6,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                            fontSize: size * .026),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _validate(BuildContext context) async {
    final modelhud = Provider.of<ModelHud>(context, listen: false);
    modelhud.changeisloading(true);
    if (_globalKey.currentState.validate()) {
      _globalKey.currentState.save();
      if (Provider.of<AdminMode>(context, listen: false).isAdmin) {
        try {
          if (_password == AdminPassword) {
            await _auth.signin(_email.trim(), _password.trim());
            print(_email);
            modelhud.changeisloading(false);
            Navigator.pushNamed(context, AdminPage.id);
          } else {
            modelhud.changeisloading(false);
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('Something went wrong !'),
                backgroundColor: Colors.black,
              ),
            );
          }
        } catch (e) {
          modelhud.changeisloading(false);
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(e.message),
              backgroundColor: Colors.black,
            ),
          );
        }
      } else {
        try {
          await _auth.signin(_email.trim(), _password.trim());
          modelhud.changeisloading(false);
          Navigator.pushNamed(context, UserPage.id);
        } catch (e) {
          modelhud.changeisloading(false);
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(e.message),
              backgroundColor: Colors.black,
            ),
          );
        }
      }
    }
    modelhud.changeisloading(false);
  }

  KeepUserLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(KKeepMeLoggedIn, keepMeLoggedIn);
  }
}

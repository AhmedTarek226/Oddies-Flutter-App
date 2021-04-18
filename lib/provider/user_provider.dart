import 'package:e_commerce/models/user_info.dart';
import 'package:e_commerce/services/auth.dart';
import 'package:flutter/cupertino.dart';

final _auth = Auth();

class UserProvider extends ChangeNotifier {
  UserInformation currentUser;
  String currentEmail;
  List<int> ordersNum = [];

  clearlist() {
    ordersNum.clear();
    // notifyListeners();
  }

  setListOfOrders(List<int> ordersnumbers) {
    ordersNum = [...ordersnumbers];
    notifyListeners();
  }

  Future<bool> getCurrentUser(List<UserInformation> users) async{
    try {
      currentEmail =await _auth.getUserEmail();
      if (currentEmail != null) {
        for (var user in users) {
          if (user.email == currentEmail) {
            currentUser = user;
            return true;
            //notifyListeners();
          }
        }
      }
    } catch (e) {
      currentUser = null;
      currentEmail = null;
      print(e);
      return false;
    }
  }
}

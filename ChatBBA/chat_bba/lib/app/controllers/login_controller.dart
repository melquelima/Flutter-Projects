import 'package:flutter/cupertino.dart';

class LoginController extends ChangeNotifier {
  static LoginController instance = LoginController();

  bool isEmail = false;

  isEmailText(text) {
    isEmail = text.contains("@");
    notifyListeners();
  }
}

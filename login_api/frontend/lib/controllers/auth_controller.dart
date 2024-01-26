import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:login_api/controllers/account_controller.dart';
import 'package:login_api/controllers/transactions_controller.dart';
import 'package:login_api/pages/login/login.page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../models/user.model.dart';

class AuthController extends ChangeNotifier {
  static AuthController instance = AuthController();

  Auth auth = Auth.empty();

  Future<Map<String, dynamic>> Login(String user, String pwd) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    var url = Uri.parse("http://localhost:4000/login");

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'authorization': 'Basic ${base64Encode(utf8.encode('${user}:${pwd}'))}',
    };

    var resposta = await http.get(url, headers: requestHeaders);

    if (resposta.statusCode == 200) {
      var obj = jsonDecode(resposta.body);
      shared.setString("auth", resposta.body);
      print("OK");
      print(obj);
      auth = Auth.fromJson(jsonDecode(resposta.body));
      // shared.setString("user", jsonDecode(resposta.body)["user"]);
      return {"status": true, "message": resposta.body};
    } else {
      print("NOK");
      print(resposta.body);
      return {"status": false, "message": resposta.body};
    }
  }

  Future<void> logout(context) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    shared.remove("auth");
    TransactionController.instance.reset();
    AccountController.instance.reset();

    GoRouter.of(context).pushReplacement('/login');
    // Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  Future<bool> validaLogin() async {
    SharedPreferences shared = await SharedPreferences.getInstance();

    var jsonString = shared.getString("auth");
    if (jsonString == null) return false;

    auth = Auth.fromJson(jsonDecode(jsonString));

    return true;
  }
}

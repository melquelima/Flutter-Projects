import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:login_api/amplify/configure.dart';
import 'package:login_api/controllers/auth_controller.dart';
import 'package:login_api/pages/login/login.page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../models/acc_details.model.dart';
import '../models/accounts.model.dart';
import '../models/user.model.dart';

class AccountController extends ChangeNotifier {
  static AccountController instance = AccountController();

  //final String token = AuthController.instance.auth.token;

  String selected_account = "";

  List<Account> contas = [
    // Account("Checking", "1234567890", "U\$ 1,90", 'GUILHERME FERREIRA'),
    // Account("Savings", "4581265784", "U\$ 1.568.121,90",
    //     'MELQUISEDEQUE DE LIMA APOLINARIO'),
    // Account("Checking", "1005698935", "U\$ 1.4154,90", 'LUCCA FERREIRA'),
    // Account("CD", "1005698701", "U\$ 458,90", 'ZION MENEZES APOLINARIO'),
  ];
  AccDetails accDetail = AccDetails.empty();

  Account selected() {
    if (selected_account == "") {
      selected_account = contas[0].actnbr;
    }

    return contas.where((e) => e.actnbr == selected_account).toList()[0];
  }

  Future<String?> LoadPortfolio(context, AuthAmp user) async {
    if (contas.isNotEmpty) {
      return "OK";
    }

    return load_portfolio(context, user.cust_key).then((obj) {
      if (obj != null) {
        dynamic jsonObj = jsonDecode(obj);

        print(obj);
        var a = 1;
        contas = [
          for (final e in jsonObj["accounts"]) ...[Account.fromJson(e)]
        ];
        return "OK";
      }
    });
  }

  Future<List<Account>> LoadPortfolio_old(context) async {
    if (contas.isNotEmpty) {
      return contas;
    }

    var url = Uri.parse("http://localhost:4000/api/get_portfolio");

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'token': AuthController.instance.auth.token,
    };

    var resposta = await http
        .get(url, headers: requestHeaders)
        .timeout(const Duration(seconds: 2));

    if (resposta.statusCode == 200) {
      var obj = jsonDecode(resposta.body);

      var accts = [
        for (final e in obj) ...[
          Account(e["PRODUCT"], e["ACTNBR"], double.parse(e["AVAILBAL"]),
              e["SHORTNAME"], e["OFFICER"]),
        ]
      ];
      contas = accts;
      selected();
      return accts;
    } else if (resposta.body == "Session Expired") {
      AuthController.instance.logout(context);
    } else {
      print("NOK");
      // print(resposta.body);
      //return {"status": false, "message": resposta.body};
    }
    return [];
  }

  Future<List<Account>> LoadDetais_old(context) async {
    if (accDetail.addresses.length > 0) {
      return contas;
    }

    var url = Uri.parse("http://localhost:4000/api/customer_details");

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'token': AuthController.instance.auth.token,
    };

    var resposta = await http.get(url, headers: requestHeaders);

    if (resposta.statusCode == 200) {
      var obj = jsonDecode(resposta.body);

      accDetail = AccDetails.fromJson(obj);
    } else if (resposta.body == "Session Expired") {
      AuthController.instance.logout(context);
    } else {
      print("NOK: " + resposta.body);
      // print(resposta.body);
      //return {"status": false, "message": resposta.body};
    }
    return [];
  }

  Future<String?> LoadDetais(context, AuthAmp user) async {
    if (accDetail.addresses.length > 0) {
      return "OK";
    }

    return load_profile(context, user.cust_key).then((obj) {
      if (obj != null) {
        dynamic jsonObj = jsonDecode(obj);
        accDetail = AccDetails.fromJson(jsonObj);

        return "OK";
      }
    });
  }

  String initialProffileImage() {
    List<String> names = accDetail.full_name.split(" ");
    var name1 = names[0];
    var name2 = names[names.length - 1];
    if (name1.length == 0) return "";
    return name1[0] + name2[0];
  }

  reset() {
    instance = AccountController();
  }
}

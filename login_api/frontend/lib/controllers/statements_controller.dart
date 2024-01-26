import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:login_api/amplify/configure.dart';
import 'package:login_api/controllers/auth_controller.dart';
import 'package:login_api/models/statements.model.dart';
import 'package:login_api/pages/login/login.page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../models/acc_details.model.dart';
import '../models/accounts.model.dart';
import '../models/user.model.dart';

class StatementsController extends ChangeNotifier {
  static StatementsController instance = StatementsController();

  //final String token = AuthController.instance.auth.token;

 

  List<Statement> statements = [
    // Account("Checking", "1234567890", "U\$ 1,90", 'GUILHERME FERREIRA'),
    // Account("Savings", "4581265784", "U\$ 1.568.121,90",
    //     'MELQUISEDEQUE DE LIMA APOLINARIO'),
    // Account("Checking", "1005698935", "U\$ 1.4154,90", 'LUCCA FERREIRA'),
    // Account("CD", "1005698701", "U\$ 458,90", 'ZION MENEZES APOLINARIO'),
  ];

  Future<String?> LoadStatements(context, String account) async {
    if (statements.isNotEmpty) {
      return "OK";
    }

    return load_statements(context, account).then((obj) {
      if (obj != null) {
        dynamic jsonObj = jsonDecode(obj);

        print(obj);
        var a = 1;
        statements = [
          for (final e in jsonObj) ...[Statement.fromJson(e)]
        ];
        return "OK";
      }
    });
  }

  reset() {
    instance = StatementsController();
  }

}

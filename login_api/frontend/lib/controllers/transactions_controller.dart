import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:login_api/amplify/configure.dart';
import 'package:login_api/controllers/account_controller.dart';
import 'package:login_api/controllers/auth_controller.dart';
import 'package:login_api/controllers/transactions_test.dart';
import 'package:login_api/pages/login/login.page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../models/accounts.model.dart';
import '../models/transaction.model.dart';
import '../models/user.model.dart';
import '../pages/uteis/modal.dart';

class TransactionController extends ChangeNotifier {
  static TransactionController instance = TransactionController();

  //final String token = AuthController.instance.auth.token;

  String selected_account = "";

  List<Transaction> transactions = [
    // for (final e in mocTrans["DepAcctTrnInqRs"]["ResponseData"]
    //     ["TRANSACTION"]) ...[
    //   Transaction(e['TRANAMT'], e['TRANDESC'], e['TRANDESCS'], e['CURRBAL'],
    //       e['DRCRFLAG'], DateTime.parse(e['TRANDATE']))
    // ]
  ];

  Future<List<Transaction>> getList(context) async {
    if (transactions.isNotEmpty &&
        selected_account == AccountController.instance.selected_account) {
      return transactions;
    }
    selected_account = AccountController.instance.selected_account;
    print(AccountController.instance.selected_account);

    // await Future.delayed(const Duration(seconds: 2));
    return load_transactions(context, selected_account).then((value) {
      if (value != null) {
        var obj = jsonDecode(value);

        transactions = [
          for (final e in obj["transactions"]) ...[
            Transaction(e['TRANAMT'], e['TRANDESC'], e['TRANDESCS'],
                e['CURRBAL'], e['DRCRFLAG'], DateTime.parse(e['TRANDATE']))
          ]
        ];
        return transactions;
      }
      return [];
    });

    // selected_account = AccountController.instance.selected_account;
    // return transactions;
  }

  reset() {
    instance = TransactionController();
  }
}

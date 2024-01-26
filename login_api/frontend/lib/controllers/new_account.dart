import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:login_api/controllers/account_controller.dart';
import 'package:login_api/controllers/auth_controller.dart';
import 'package:login_api/controllers/transactions_test.dart';
import 'package:login_api/models/new_user_info.dart';
import 'package:login_api/pages/login/login.page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../models/accounts.model.dart';
import '../models/transaction.model.dart';
import '../models/user.model.dart';
import '../pages/uteis/modal.dart';

class NewAccountController extends ChangeNotifier {
  static NewAccountController instance = NewAccountController();

  NewUserInfo user = NewUserInfo.empty();
  String? userName = null;
  String? password = null;

  void reset() {
    instance = NewAccountController();
  }
}

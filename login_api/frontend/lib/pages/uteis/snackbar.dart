import 'package:flutter/material.dart';
import 'package:login_api/models/App.dart';

void displayError(context, String error, {bool fixed = false}) {
  final snackBar = SnackBar(
    duration: fixed ? Duration(minutes: 10000) : Duration(milliseconds: 10000),
    content: Text(
      error,
      textAlign: TextAlign.center,
    ),
    backgroundColor: Colors.redAccent,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void displaySuccess(context, String message, {bool fixed = false}) {
  final snackBar = SnackBar(
    duration: fixed ? Duration(minutes: 10000) : Duration(milliseconds: 10000),
    content: Text(
      message,
      textAlign: TextAlign.center,
    ),
    backgroundColor: Colors.green,
  );
  BuildContext? context = App.navigatorKey.currentContext;
  if (context != null) {
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

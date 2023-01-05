import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:dart_eval/dart_eval.dart';

class LangController extends ChangeNotifier {
  static LangController instance = LangController();

  String language = "us";
  Map<String, dynamic> labels = {};

  LangController() {
    readJson("us");
  }

  Future<void> readJson(lang) async {
    final String response =
        await rootBundle.loadString('assets/lang/${lang}.json');
    final data = await json.decode(response);
    labels = data;
    notifyListeners();
  }

  changeLang(lang) {
    language = lang;
    print(lang);
    readJson(lang);
    notifyListeners();
  }
}

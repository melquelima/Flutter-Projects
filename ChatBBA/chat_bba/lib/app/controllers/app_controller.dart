import 'dart:async';
import 'dart:convert';

import 'package:chat_bba/app/view/chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../view/login.dart';

class AppController extends ChangeNotifier {
  List<Widget> _list = [];
  String _user_name = "";

  firstOptions(context, value) {
    _list.add(ClientMessage(message: value));

    notifyListeners();

    getCardNumber(context);
  }

  login(context, username) {
    _user_name = username;

    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => const Chat()));

    Widget msg1 = const ChatMessage(
      message:
          "Attention: For security purposes, the debit card activation should only take place once your physical card is received. BB Americas Bank will never contact you via phone to request activation of a card that has not yet been received by you.",
      option: false,
    );
    Widget msg2 = ChatMessage(
      message: 'Hello $_user_name. What do you want to do?',
      option: true,
    );

    loadMessage(msg1, () => loadMessage(msg2, null));

    // _list.add(ChatMessage(
    //     message: 'Hello $_user_name. What do you want to do?', option: true));
  }

  logout(context) {
    _list = [];
    _user_name = "";
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Login()));
  }

  loadMessage(Widget wdgt, callback) {
    _list.add(const LoadingIcon());

    Timer(const Duration(seconds: 2), () {
      _list.removeLast();
      _list.add(wdgt);
      notifyListeners();
      if (callback != null) {
        callback();
      }
    });
  }

  getCardNumber(context) {
    _list.add(const LoadingIcon());

    Timer(const Duration(seconds: 2), () {
      _list.removeLast();
      _list.add(const ChatMessage(
          message: "Please enter your 16 digits Debit Card number:",
          option: false));
      notifyListeners();
      _dialogBuilder(context);
    });
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('BB Americas Bank'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Card Number:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'XXXXXXXXX1234',
                ),
                onChanged: (text) {},
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 226, 226, 230)),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Close',
                style: TextStyle(color: Colors.black),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 0, 10, 118)),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Send Information'),
            ),
          ],
        );
      },
    );
  }

  List<Widget> get messages => _list;
  String get username => _user_name;
}

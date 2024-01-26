import 'package:flutter/material.dart';

Function goTo(context, pageObject) {
  void func() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => pageObject,
      ),
    );
  }

  return func;
}

Function back(context) {
  void func() {
    Navigator.pop(context, false);
  }

  return func;
}

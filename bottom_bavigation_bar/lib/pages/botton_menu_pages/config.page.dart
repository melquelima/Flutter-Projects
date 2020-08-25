import 'package:bottom_bavigation_bar/pages/defaults/background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class configPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Text(
          "ConfigPage",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        decoration: bg2,
      ),
    );
  }
}

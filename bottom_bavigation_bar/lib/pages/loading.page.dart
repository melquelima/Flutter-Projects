import 'package:bottom_bavigation_bar/uteis.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main.page.dart';

class loading extends StatefulWidget {
  @override
  _loadingState createState() => _loadingState();
}

class _loadingState extends State<loading> {
  @override
  initState() {
    super.initState();
    submit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }

  Future<Function> submit() async {
    Future.delayed(const Duration(seconds: 4), goTo(context, mainPage()));
    print("asd");
  }
}

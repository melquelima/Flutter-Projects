import 'dart:io';
import 'package:flutter/material.dart';
import 'package:login_api/configs/palette.config..dart';
import 'package:login_api/pages/bottom.dart';
import 'package:login_api/pages/home/home.page.dart';
import 'package:login_api/pages/login/landing.page.dart';
import 'package:login_api/routes.dart';
import 'package:window_size/window_size.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
  //   setWindowTitle('BB Americas');
  //   setWindowMinSize(const Size(400, 700));
  //   //setWindowMaxSize(Size.infinite);
  //   setWindowMaxSize(const Size(400, 700));
  // }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      //title: 'Login API',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Palette.bbaBlue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: BottomNavBar(body: HomePage()),
      routerConfig: routes,
    );
  }
}

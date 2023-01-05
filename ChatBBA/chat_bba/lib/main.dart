// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:chat_bba/app/controllers/login_controller.dart';
import 'package:chat_bba/app/view/chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app/controllers/app_controller.dart';
import 'app/view/login.dart';
import 'package:provider/provider.dart';

main() {
  runApp(AppWidget(
    title: 'test',
  ));
}

class AppWidget extends StatelessWidget {
  final String title;

  const AppWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AppController(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
            scaffoldBackgroundColor: Color.fromARGB(255, 13, 82, 148)),
        home: Login(),
      ),
    );
  }
}

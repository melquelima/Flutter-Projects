import 'package:ello_ronda/app/views/home/bottom_menu.dart';
import 'package:ello_ronda/app/views/home/home.dart';
import 'package:ello_ronda/app/views/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ApWidget());
}

class ApWidget extends StatelessWidget {
  const ApWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: Color.fromARGB(255, 246, 247, 245)),
      home: const BottomNav(),
    );
  }
}

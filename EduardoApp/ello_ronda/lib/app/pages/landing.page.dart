import 'package:ello_ronda/app/config/Palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          //alignment: Alignment.center,
          children: [
            gradientBackgounnd(
              Stack(
                children: [
                  Center(
                    child: Container(
                      width: 200,
                      height: 200,
                      padding: EdgeInsets.all(12),
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      "assets/login/logo_p_white_min.png",
                      width: 100,
                      height: 100,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget gradientBackgounnd(Widget child) {
  return Container(
    decoration: BoxDecoration(
        gradient: LinearGradient(
      colors: [
        const Color.fromARGB(255, 253, 178, 77),
        PaletePatrol.shade800,
      ],
      stops: [0, 1],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    )),
    child: child,
  );
}

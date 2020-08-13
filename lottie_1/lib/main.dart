import 'package:flutter/material.dart';
import 'package:fluttie/fluttie.dart';
import 'package:lottie_1/widgets/form.widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SignUpPage(),
    );
  }
}

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var busy = false;
  var done = false;

  FluttieAnimationController animationCtrl;

  @override
  initState() {
    super.initState();
    prepareAnimation();
  }

  @override
  dispose() {
    super.dispose();
    animationCtrl?.dispose();
  }

  prepareAnimation() async {
    var instance = Fluttie();
    var checkAnimation =
        await instance.loadAnimationFromAsset("assets/loading.json");
    animationCtrl = await instance.prepareAnimation(
      checkAnimation,
      duration: const Duration(seconds: 2),
      repeatCount: const RepeatCount.infinite(),
      repeatMode: RepeatMode.START_OVER,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: double.infinity,
            alignment: Alignment.center,
          ),
          FluttieAnimation(animationCtrl),
          !done ? SubmitForm(busy: busy, func: submit) : Container()
        ],
      ),
    );
  }

  Future<Function> submit() async {
    setState(() {
      busy = true;
    });

    Future.delayed(
      const Duration(seconds: 2),
      () => setState(
        () {
          done = true;
          animationCtrl.start();
        },
      ),
    );
  }
}

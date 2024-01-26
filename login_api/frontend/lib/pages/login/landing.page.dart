import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:login_api/controllers/account_controller.dart';
import 'package:login_api/amplify/configure.dart';
import 'package:login_api/pages/uteis/snackbar.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
    //return;
    // AuthController.instance.validaLogin().then((v) {
    //   if (v) {
    //     AccountController.instance.LoadPortfolio(context).then((value) {
    //       if (mounted) {
    //         context.go("/accounts");
    //       }
    //     });
    //     // Navigator.pushReplacement(
    //     //     context, MaterialPageRoute(builder: (context) => HomePage()));
    //   } else {
    //     context.pushReplacement("/login");
    //     // Navigator.pushReplacement(
    //     //     context, MaterialPageRoute(builder: (context) => LoginPage()));
    //   }
    // });
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
    configureAmplify(context).then((isConfigured) {
      if (mounted && isConfigured) {
        getCurrentUserId(context).then((user) {
          if (user == null) return context.go("/login");
          load_portfolio(context, user.cust_key).then((value) {});
          AccountController.instance.LoadPortfolio(context, user).then((value) {
            if (mounted && value != null) {
              context.go("/accounts");
            }
            //logout(context).then((value) => null);
          }).catchError((err) {
            displayError(context, err.message, fixed: true);
            var a = 1;
          });
        });
      }
    });
  }

  void _onrender() {}

  @override
  Widget build(BuildContext context) {
    _onrender();
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

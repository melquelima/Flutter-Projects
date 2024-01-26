import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:login_api/configs/palette.config..dart';
import 'package:login_api/amplify/configure.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginForm = GlobalKey<FormState>();
  final _usuarioController = TextEditingController();
  final _senhaController = TextEditingController();
  bool hidden = true;
  bool isLoading = false;

  void _onrender() {}

  @override
  Widget build(BuildContext context) {
    _onrender();
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          Container(
            decoration: const BoxDecoration(
              //borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
              color: Color.fromRGBO(255, 255, 255, 1),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Image.asset(
                        "assets/logo2.png",
                        width: 250,
                        height: 50,
                      ),
                    ),
                  ),
                  Spacer(),
                  OpenAccontButton(),
                  // const Align(
                  //   alignment: Alignment.centerRight,
                  //   child: Padding(
                  //     padding: EdgeInsets.all(15.0),
                  //     child: Text(
                  //       "Create Account",
                  //       style: TextStyle(
                  //         fontWeight: FontWeight.w700,
                  //         color: Color.fromRGBO(0, 10, 118, 1),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ]),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: _loginForm,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "User",
                        style: TextStyle(
                          color: Color.fromRGBO(88, 88, 88, 1),
                        ),
                      ),
                    ),
                    TextFormField(
                      decoration: textStyleField('Type your user', false),
                      controller: _usuarioController,
                      validator: notEmptyValidator,
                      keyboardType: TextInputType.text,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Password",
                        style: TextStyle(
                          color: Color.fromRGBO(88, 88, 88, 1),
                        ),
                      ),
                    ),
                    TextFormField(
                      decoration: textStyleField('Type your password', true),
                      controller: _senhaController,
                      validator: notEmptyValidator,
                      keyboardType: TextInputType.text,
                      obscureText: hidden,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    LoginButton(),
                    const SizedBox(height: 10),
                    const Center(
                      child: Text(
                        "Forgot my password",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Color.fromRGBO(0, 10, 118, 1)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget LoginButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(40),
        backgroundColor: Palette.bbaBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // <-- Radius
        ),
      ),
      onPressed: () {
        //return modal(context);
        if (_loginForm.currentState!.validate()) {
          loading(true);
          onLogin(context, _usuarioController.text, _senhaController.text)
              .then((isSignedIn) {
            if (isSignedIn) {
              GoRouter.of(context).push('/');
            }
            loading(false);
          });
        }
        // AuthController.instance
        //     .Login(_usuarioController.text, _senhaController.text)
        //     .then((value) {
        //   if (value["status"]) {
        //     // GoRouter.of(context).push('/home');
        //     context.go("/home");
        //     // Navigator.pushReplacement(
        //     //     context, MaterialPageRoute(builder: (context) => HomePage()));
        //   } else
        //     // {ScaffoldMessenger.of(context).showSnackBar(snackBar)}
        //     modal_error(context, value["message"]);
        // });
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: isLoading
            ? circularLoading()
            : const Text(
                'Log in',
                style: TextStyle(
                    //color: Color.fromRGBO(122, 122, 122, 1),
                    fontWeight: FontWeight.w700),
              ),
      ),
    );
  }

  void loading(bool val) {
    setState(() {
      isLoading = val;
    });
  }

  Widget OpenAccontButton() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(40),
          backgroundColor: Palette.bbaBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5), // <-- Radius
          ),
        ),
        onPressed: () {
          GoRouter.of(context).push('/register');
          //return modal(context);
        },
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                'New user? Click to enroll.',
                style: TextStyle(
                    //color: Color.fromRGBO(122, 122, 122, 1),
                    fontWeight: FontWeight.w700),
              ),
              Spacer(),
              Icon(CupertinoIcons.arrow_right),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration textStyleField(String label, bool useIcon) {
    return InputDecoration(
      //labelText: label,
      hintText: label,
      hintStyle: const TextStyle(
        //fontWeight: FontWeight.bold,
        fontSize: 14,
        color: Color.fromARGB(255, 156, 156, 156),
      ),
      filled: true,
      fillColor: Color.fromARGB(255, 255, 255, 255),
      //suffixIcon: useIcon ? const Icon(Icons.remove_red_eye_outlined) : null,
      suffixIcon: useIcon
          ? IconButton(
              onPressed: () => setState(() {
                    hidden = !hidden;
                  }),
              icon: Icon(hidden
                  ? Icons.remove_red_eye_outlined
                  : Icons.remove_red_eye))
          : null,
      border: InputBorder.none,
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(
          color: Color.fromARGB(255, 230, 229, 229),
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(
          color: Color.fromARGB(255, 230, 229, 229),
        ),
      ),
    );
  }

  final snackBar = SnackBar(
    content: Text(
      "Email ou senha invalidos",
      textAlign: TextAlign.center,
    ),
    backgroundColor: Colors.redAccent,
  );

  void modal_error(context, String message) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * .25,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 100,
                      height: 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 168, 168, 168),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Center(
                    child: Icon(
                      CupertinoIcons.xmark_octagon_fill,
                      color: Color.fromARGB(255, 189, 32, 21),
                      size: 40,
                    ),
                  ),
                  Text("Ops! -  ${message}"),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(40),
                      backgroundColor: Color.fromRGBO(0, 10, 118, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // <-- Radius
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text('OK'),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

Widget circularLoading() {
  return Transform.scale(
    scale: 0.8,
    child: const CircularProgressIndicator(color: Colors.white),
  );
}

String? notEmptyValidator(String? text) {
  if (text == null || text.isEmpty) return 'Can\'t be empty';
}

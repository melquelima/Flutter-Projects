// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:chat_bba/app/controllers/app_controller.dart';
import 'package:chat_bba/app/view/chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/login_controller.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController username_controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final AppController appController = Provider.of(context, listen: true);

    return Scaffold(
        body: Container(
            width: double.infinity,
            height: double.infinity,
            // color: Colors.amber,
            alignment: Alignment.center,
            child: Container(
              constraints: BoxConstraints(
                minWidth: 100,
                maxWidth: 300,
                minHeight: 200,
                maxHeight: 400,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/logo.png",
                      width: 150,
                      height: 150,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Please enter a user name',
                      ),
                      onChanged: (text) {
                        setState(() {
                          LoginController.instance.isEmailText(text);
                        });
                        print(text);
                      },
                      controller: username_controller,
                    ),
                    Visibility(
                      visible: LoginController.instance.isEmail,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Please enter a password',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(40),
                          backgroundColor: Color.fromARGB(255, 0, 10, 118)),
                      onPressed: () {
                        appController.login(
                            context, username_controller.text.toString());
                      },
                      child: Text('Entrar'),
                    ),
                  ],
                ),
              ),
            )));
  }
}

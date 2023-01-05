// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ello_ronda/app/models/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../controllers/api.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Widget _body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      child: Container(
        constraints: const BoxConstraints(
          minWidth: 100,
          minHeight: 200,
          maxHeight: 400,
        ),
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(10),
        //   color: Colors.white,
        // ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                "assets/logo.png",
                width: 100,
                height: 100,
              ),
              SizedBox(height: 30),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      TextField(
                          decoration: InputDecoration(
                            hintText: 'Usuário',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (text) {
                            print(text);
                          }),
                      SizedBox(height: 10),
                      TextField(
                          decoration: InputDecoration(
                            hintText: 'Senha',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (text) {
                            print(text);
                          }),
                      SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size.fromHeight(40),
                            backgroundColor: Color.fromARGB(255, 212, 209, 21)),
                        onPressed: () {
                          Future<AuthApp> a = ApiController.loginApp("", "");
                          String b = "";
                        },
                        child: Text('Entrar'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'assets/login/fundo.jpg',
              fit: BoxFit.cover,
            )),
        _body(),
      ],
    ));
  }
}

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:chat_bba/app/controllers/app_controller.dart';
import 'package:chat_bba/app/view/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/language_controller.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    final AppController appController = Provider.of(context, listen: true);

    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Image.asset("assets/user_pic.png"),
            ),
            accountName: Text(appController.username),
            accountEmail: Text("asdasd@asdad.com"),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 13, 82, 148),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Início"),
            subtitle: Text("tela de inicio"),
          ),
          ListTile(
            leading: Image.asset(
                "assets/${LangController.instance.language}_flag.png"),
            title: Text("Idioma"),
            subtitle: Text("tela de inicio"),
            onTap: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Escolha um idioma'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      child: Row(
                        children: [
                          Image.asset("assets/us_flag.png"),
                          SizedBox(width: 10),
                          Text("Inglês"),
                        ],
                      ),
                      onTap: () {
                        setState(() {
                          LangController.instance.changeLang('us');
                        });
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      child: Row(
                        children: [
                          Image.asset("assets/pt_flag.png"),
                          SizedBox(width: 10),
                          Text("Português"),
                        ],
                      ),
                      onTap: () {
                        setState(() {
                          LangController.instance.changeLang('pt');
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
            subtitle: Text("Finalizar sessao"),
            onTap: () {
              appController.logout(context);
            },
          ),
        ],
      ),
    );
  }
}

import 'package:ello_ronda/app/config/Palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // titleSpacing: 0.0,
        elevation: 5.0,
        //backgroundColor: Color(0xff201F23),
        title: Image.asset(
          "assets/login/logo_sem_fundo.png",
          width: 30,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            indicators(),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  menu(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget indicators() {
  return Container(
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
      color: Palette_mtech.shade50,
      // boxShadow: [
      //   BoxShadow(
      //     color: Colors.grey.withOpacity(0.5),
      //     spreadRadius: 0.5,
      //     blurRadius: 10,
      //     offset: Offset(0, 5), // changes position of shadow
      //   ),
      // ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text("asdas"),
      ],
    ),
  );
}

Widget menu() {
  return Padding(
    padding: const EdgeInsets.only(left: 40.0, right: 40),
    child: Wrap(
      spacing: 24.0, // gap between adjacent chips
      runSpacing: 20.0, // gap between lines
      alignment: WrapAlignment.center,
      children: [
        roundedButton("Perfil", Icons.person_outlined),
        roundedButton("Prédios", CupertinoIcons.building_2_fill),
        roundedButton("Licensas", Icons.key_outlined),
        roundedButton("Dashboard", CupertinoIcons.chart_bar_square),
        roundedButton("Configuracoes", CupertinoIcons.gear_alt),
      ],
    ),
  );
}

Widget roundedButton(String label, IconData icon) {
  return Column(
    children: [
      Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Color.fromARGB(255, 255, 255, 255),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0.5,
              blurRadius: 10,
              offset: Offset(0, 5), // changes position of shadow
            ),
          ],
        ),
        child: IconButton(
          onPressed: () {},
          icon: Icon(
            icon,
            color: Palette_mtech,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Text(
          label,
          style: TextStyle(color: Palette_mtech, fontSize: 12),
        ),
      ),
    ],
  );
}

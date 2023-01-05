import 'package:ello_ronda/app/views/home/home.dart';
import 'package:ello_ronda/app/views/home/predios.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _current_Index = 0;

  List<List<Widget>> body = const [
    [Text("Home"), Home()],
    [Text("Predios"), Predios()],
    [Text("Configurações"), Icon(Icons.menu)],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: body[_current_Index][0],
          backgroundColor: Color.fromARGB(255, 248, 209, 23),
        ),
        body: Center(child: body[_current_Index][1]),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _current_Index,
          onTap: (int newIndex) {
            setState(() {
              _current_Index = newIndex;
            });
          },
          items: const [
            BottomNavigationBarItem(
              label: "Perfil",
              icon: Icon(Icons.person),
            ),
            BottomNavigationBarItem(
              label: "Prédios",
              icon: Icon(Icons.location_city),
            ),
            BottomNavigationBarItem(
              label: "Configurações",
              icon: Icon(Icons.settings),
            ),
          ],
        ));
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'botton_menu_pages/config.page.dart';
import 'botton_menu_pages/home.page.dart';

class mainPage extends StatefulWidget {
  @override
  _mainPageState createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  final pageViewController = PageController();

  @override
  void dispose() {
    super.dispose();
    pageViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageViewController,
        children: <Widget>[
          homePage(),
          configPage(),
          Container(),
          Container(),
        ],
      ),
      bottomNavigationBar: AnimatedBuilder(
          animation: pageViewController,
          builder: (context, snapshot) {
            return BottomNavigationBar(
              backgroundColor: Colors.grey,
              selectedItemColor: Color.fromRGBO(51, 9, 9, 1),
              unselectedItemColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              currentIndex: pageViewController?.page?.round() ?? 0,
              onTap: (index) {
                pageViewController.jumpToPage(index);
              },
              //backgroundColor: Colors.black12,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  title: Text("home"),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  title: Text("config"),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.subject),
                  title: Text("pedidos"),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  title: Text("perfil"),
                ),
              ],
            );
          }),
    );
  }
}

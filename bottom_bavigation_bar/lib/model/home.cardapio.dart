import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Cardapio extends StatelessWidget {
  final String image;

  Cardapio({this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 102,
      color: Colors.grey,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 7,
            child: Container(
              height: 100,
              //color: Colors.red,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      color: Colors.blue,
                      child: Text("teste"),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      color: Colors.green,
                      child: Text("teste"),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      color: Colors.red,
                      child: Text("teste"),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              height: 99,
              color: Colors.green,
              child: SizedBox(
                child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                  image: AssetImage("assets/" + image),
                  fit: BoxFit.fitWidth,
                ))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

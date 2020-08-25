import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Destaque {
  String image;
  String title;
  String desc;
  int valor;

  Destaque({this.image, this.title, this.desc, this.valor});

  Destaque.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    title = json['title'];
    desc = json['desc'];
    valor = json['valor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['title'] = this.title;
    data['desc'] = this.desc;
    data['valor'] = this.valor;
    return data;
  }
}

class DestaqueWgt extends StatelessWidget {
  final Destaque destaque;

  DestaqueWgt(this.destaque);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160.0,
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        decoration: BoxDecoration(
          //color: Color(0XFF3C5A99),
          border: Border.all(
            width: 1.0,
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: SizedBox.expand(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                  image: AssetImage("assets/" + destaque.image),
                  fit: BoxFit.fitWidth,
                ))),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  //color: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  alignment: Alignment.topCenter,
                  child: Text(destaque.desc.toString()),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  alignment: Alignment.centerLeft,
                  //color: Colors.green,
                  child: Text("R\$ " + destaque.valor.toString(),
                      style: TextStyle(fontWeight: FontWeight.w800)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

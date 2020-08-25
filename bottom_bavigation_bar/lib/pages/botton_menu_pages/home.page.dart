import 'package:bottom_bavigation_bar/model/home.cardapio.dart';
import 'package:bottom_bavigation_bar/model/home.destaques.dart';
import 'package:bottom_bavigation_bar/pages/defaults/background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class homePage extends StatefulWidget {
  var items = new List<Destaque>();
  var items2 = new List<Destaque>();

  homePage() {
    items = [];
    items2 = [];
    items.add(Destaque(
        image: 'image.png', title: "123", desc: "4564654asda1", valor: 33));
    items.add(Destaque(
        image: 'image2.png', title: "123", desc: "4564654asda1", valor: 33));
    items.add(Destaque(
        image: 'image3.png', title: "123", desc: "4564654asda1", valor: 33));
    items.add(Destaque(
        image: 'image.png', title: "123", desc: "4564654asda1", valor: 33));
    items2.add(Destaque(
        image: 'image.png', title: "123", desc: "4564654asda1", valor: 33));
    items2.add(Destaque(
        image: 'image2.png', title: "123", desc: "4564654asda1", valor: 33));
    items2.add(Destaque(
        image: 'image3.png', title: "123", desc: "4564654asda1", valor: 33));
    items2.add(Destaque(
        image: 'image.png', title: "123", desc: "4564654asda1", valor: 33));
  }

  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: ListView(
          children: <Widget>[
            //Text("Home", style: TextStyle(color: Colors.white)),
            Container(
                color: Colors.white,
                padding: EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "  Destaques",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20.0),
                      height: 220.0,
                      child: ListView.builder(
                        itemCount: widget.items.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (ctx, idx) {
                          final item = widget.items[idx];
                          return DestaqueWgt(item);
                        },
                      ),
                    ),
                  ],
                )),
            SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.white,
              //height: 50,
              padding: EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "  Cardápio",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20.0),
                    //height: 220.0,
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: widget.items2.length,
                      itemBuilder: (ctx, idx) {
                        final item = widget.items2[idx];
                        return Cardapio(image: item.image);
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        //decoration: bg3,
        color: Colors.grey[300],
      ),
    );
  }
}

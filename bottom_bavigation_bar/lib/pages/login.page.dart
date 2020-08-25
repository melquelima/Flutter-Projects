import 'package:bottom_bavigation_bar/pages/defaults/background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class loginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: bg2,
        padding: EdgeInsets.only(
          top: 60,
          left: 40,
          right: 40,
        ),
        //color: Colors.black,
        //alignment: Alignment.center,
        child: ListView(
          children: <Widget>[
            SizedBox(
              width: 228,
              height: 128,
              child: Image.asset("assets/logo3.png"),
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(fontSize: 20, color: Colors.white),
              decoration: InputDecoration(
                labelText: "E-mail",
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              obscureText: true,
              style: TextStyle(fontSize: 20, color: Colors.white),
              decoration: InputDecoration(
                labelText: "Senha",
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              height: 40,
              alignment: Alignment.centerRight,
              //color: Colors.blue,
              child: FlatButton(
                onPressed: () {},
                child: Text(
                  "Recuperar Senha",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              height: 60,
              decoration: bg1,
              child: SizedBox.expand(
                child: FlatButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        width: 28,
                        height: 28,
                        child: Image.asset("assets/hashi.png"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: Color(0XFF3C5A99),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: SizedBox.expand(
                child: FlatButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Login com Facebook",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        width: 28,
                        height: 28,
                        child: Image.asset("assets/fb-icon.png"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              child: FlatButton(
                child:
                    Text("Cadastre-se", style: TextStyle(color: Colors.white)),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

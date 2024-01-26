import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../config/Palette.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class Login2 extends StatefulWidget {
  const Login2({super.key});

  @override
  State<Login2> createState() => _Login2State();
}

class _Login2State extends State<Login2> {
  bool _admin = true;
  double logo_left = 0;
  double show_logo = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
          logo_left = -(MediaQuery.of(context).size.width / 3.5);
          show_logo = 1;
        }));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    logo_left = logo_left == 0 ? -size.width : logo_left;
    return Scaffold(
      //backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedPositioned(
              curve: Curves.easeInOut,
              duration: Duration(milliseconds: 1200),
              left: logo_left,
              width: size.width,
              top: 0,
              child: Image.asset("assets/login/logo_p.png"),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 50),
                AnimatedOpacity(
                  // If the widget is visible, animate to 0.0 (invisible).
                  // If the widget is hidden, animate to 1.0 (fully visible).
                  opacity: show_logo,
                  duration: const Duration(milliseconds: 2000),
                  // The green box must be a child of the AnimatedOpacity widget.
                  child: title(),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // title(),
                //title(),
                // SizedBox(height: 200),
                switch_user_type2(),
                textBox("Email", Icons.alternate_email),
                textBox("Senha", CupertinoIcons.padlock),
                SizedBox(height: 50),
                loginButton(),
                esqueci_a_senha(),
                divider(),
                googleButton(),
              ],
            ),
            register(),

            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.stretch,
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     title(),
            //   ],
            // )
          ],
        ),
      ),
    );
  }

  Widget switch_user_type2() {
    return Material(
      elevation: 18,
      borderRadius: BorderRadius.circular(50),
      shadowColor: Colors.black,
      child: Container(
        width: 160,
        decoration: BoxDecoration(
          color: PaletePatrol,
          border: Border.all(
            width: 3,
            color: Color.fromARGB(255, 230, 229, 229),
          ),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            AnimatedPositioned(
              curve: Curves.easeInOut,
              duration: Duration(milliseconds: 200),
              left: _admin ? 0 : 75,
              child: Container(
                width: 80,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(child: Text("")),
              ),
            ),

            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                setState(() {
                  _admin = !_admin;
                  print("foi");
                });
              },
              child: Container(
                padding: const EdgeInsets.only(
                    top: 8.0, left: 20, right: 20, bottom: 8),
                //decoration: BoxDecoration(color: Colors.red),
                child: Row(
                  children: [
                    Center(child: Text("Admin")),
                    Spacer(),
                    Center(child: Text("Colab")),
                  ],
                ),
              ),
            ),
            // Align(
            //   alignment: Alignment.topRight,
            //   child: Container(
            //     width: 80,
            //     padding: EdgeInsets.all(8),
            //     child: Center(child: Text("Colab")),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

Widget gradientBackgounnd(Widget child) {
  return Container(
    decoration: BoxDecoration(
        gradient: LinearGradient(
      colors: [Color(0xff6539b3), Color(0xff432677)],
      stops: [0, 1],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    )),
    child: child,
  );
}

Widget title() {
  return Center(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Patrol",
          style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Palette_mtech.shade900),
        ),
        SizedBox(width: 10),
        Image.asset(
          "assets/login/logo_p_rounded.png",
          width: 58,
          height: 58,
        ),
      ],
    ),
  );
}

Widget textBox(String label, IconData icon) {
  return Padding(
    padding: const EdgeInsets.only(left: 30.0, right: 30, top: 20),
    child: Material(
      elevation: 18,
      borderRadius: BorderRadius.circular(50),
      shadowColor: Colors.black,
      child: TextFormField(
        decoration: textStyleField(label, icon),
        //controller: _usuarioController,
        //validator: notEmptyValidator,
        keyboardType: TextInputType.text,
      ),
    ),
  );
}

InputDecoration textStyleField(String label, IconData icon) {
  return InputDecoration(
    //labelText: label,
    hintText: label,
    hintStyle: const TextStyle(
      //fontWeight: FontWeight.bold,
      fontSize: 14,
      color: Color.fromARGB(255, 156, 156, 156),
    ),
    filled: true,
    fillColor: Color.fromARGB(255, 255, 255, 255),
    //suffixIcon: useIcon ? const Icon(Icons.remove_red_eye_outlined) : null,
    prefixIcon: Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 10),
      child: Icon(icon),
    ),
    border: InputBorder.none,
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(50.0)),
      borderSide: BorderSide(
        color: Color.fromARGB(255, 230, 229, 229),
      ),
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(50.0)),
      borderSide: BorderSide(
        color: Color.fromARGB(255, 230, 229, 229),
      ),
    ),
  );
}

Widget loginButton() {
  return Padding(
    padding: const EdgeInsets.only(left: 30, right: 30),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(15),
          minimumSize: const Size.fromHeight(40),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50), // <-- Radius
          ),
          elevation: 18,
          shadowColor: Colors.black),
      onPressed: () {},
      child: const Text(
        "Entrar",
        style: TextStyle(color: Colors.black),
      ),
    ),
  );
}

Widget divider() {
  Widget div = Expanded(
    child: new Container(
        margin: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Divider(color: Colors.black, height: 36, thickness: 0.6)),
  );

  return Padding(
    padding: const EdgeInsets.only(left: 60.0, right: 60, top: 15),
    child: Row(children: <Widget>[
      div,
      Text("ou", style: TextStyle(fontSize: 12)),
      div,
    ]),
  );
}

Widget esqueci_a_senha() {
  return Padding(
    padding: const EdgeInsets.only(left: 60.0, right: 60, top: 15),
    child: Align(
      alignment: Alignment.topRight,
      child: Text("Esqueceu a senha?",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          )),
    ),
  );
}

Widget googleButton() {
  return SignInButton(
    Buttons.Google,
    text: "Entrar com o Google",
    onPressed: () {},
  );
}

Widget register() {
  return const Positioned(
    bottom: 0,
    child: Padding(
      padding: EdgeInsets.all(20.0),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Não tem uma conta?"),
            SizedBox(width: 10),
            Text("Registre-se",
                style: TextStyle(color: Color.fromARGB(255, 244, 130, 37))),
          ],
        ),
      ),
    ),
    //width: size.width,
  );
}

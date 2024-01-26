import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:login_api/amplify/configure.dart';

import '../../controllers/auth_controller.dart';

Widget header(context, Function setState) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 15.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 8,
          child: Image.asset(
            "assets/logo2.png",
            width: 70,
            height: 30,
          ),
        ),
        Expanded(
          flex: 1,
          child: Icon(Icons.search),
        ),
        Expanded(
          flex: 1,
          child: IconButton(
              onPressed: () => setState(() {
                    modal_menu_principal(context, "asdasdas");
                  }),
              icon: Icon(CupertinoIcons.ellipsis_vertical)),
        ),
      ],
    ),
  );
}

void modal_menu_principal(context, String message) {
  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * .25,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 80,
                    height: 4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 168, 168, 168),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Hello " + (AuthController.instance.auth.user.userName ?? ""),
                  style: TextStyle(
                      fontFamily: 'Eloquia', fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    menuRowItem("Profile", Icon(CupertinoIcons.person), () {
                      Navigator.pop(context);
                      GoRouter.of(context).push("/profile");
                      //context.pushReplacement("/profile");
                    }),
                    menuRowItem(
                        "Logout",
                        Icon(Icons.exit_to_app),
                        () => logout(context).then(
                            (value) => GoRouter.of(context).push("/login"))),
                  ],
                ),
              ],
            ),
          ),
        );
      });
}

Widget menuRowItem(String text, Icon icon, Function fnc) {
  return MaterialButton(
    onPressed: () {
      fnc();
    },
    child: Padding(
      padding: const EdgeInsets.only(bottom: 0.0),
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              // borderRadius: BorderRadius.circular(10),
              border: Border(
                bottom: BorderSide(width: 1.0, color: Colors.grey),
              ),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: icon,
                  ),
                  Expanded(
                    flex: 8,
                    child: Text(
                      text,
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Eloquia',
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Icon(CupertinoIcons.chevron_right),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}

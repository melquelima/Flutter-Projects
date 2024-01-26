import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:login_api/configs/palette.config..dart';
import 'package:login_api/controllers/account_controller.dart';
import 'package:login_api/controllers/auth_controller.dart';
import 'package:login_api/pages/contas.page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool hidden = false;

  final ScrollController listScrollController = ScrollController();
  final formatCurrency = new NumberFormat.simpleCurrency();
  List<Widget> wdgt = [];

  @override
  Widget build(BuildContext context) {
    wdgt = [
      header(),
      details(context),
      ballance(context),
      //ver_extrato(),
      //menu_central(),
      extrato(),
    ];

    return Stack(children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 4,
            child: Container(
              //height: MediaQuery.of(context).size.height * .35,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              //height: MediaQuery.of(context).size.height * .35,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 233, 230, 230),
              ),
            ),
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView.builder(
          controller: listScrollController,
          itemCount: wdgt.length,
          itemBuilder: (context, index) {
            return wdgt[index];
          },
        ),
      ),
    ]);
  }

  Widget extrato() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
            color: Palette.bbaBlue,
          ),
          child: const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              "Bank of Americas",
              style: TextStyle(
                // fontWeight: FontWeight.bold,
                fontFamily: 'Altone',
                fontSize: 17,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(10.0)),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.search),
          ),
        ),
      ],
    );
  }

  Widget header() {
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

  Widget details(context) {
    return Align(
      alignment: Alignment.topLeft,
      child: SizedBox(
        height: 40,
        child: Row(
          //mainAxisSize: MainAxisSize.max,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Account",
                    style: TextStyle(fontFamily: 'Eloquia'),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    AccountController.instance.selected().actnbr,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontFamily: 'Eloquia'),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 8,
              child: Padding(
                padding: const EdgeInsets.only(right: 15.0, left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Name",
                      style: TextStyle(fontFamily: 'Eloquia'),
                    ),
                    SizedBox(height: 5),
                    Flexible(
                      child: RichText(
                        overflow: TextOverflow.ellipsis,
                        strutStyle: const StrutStyle(fontSize: 12.0),
                        text: TextSpan(
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Eloquia'),
                            text: AccountController.instance
                                .selected()
                                .shortname),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    GoRouter.of(context).push("/contas");
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => ContasPage()));
                  },
                  child: const Text(
                    'Contas',
                    style: TextStyle(
                        //color: Color.fromRGBO(122, 122, 122, 1),
                        //fontFamily: 'Eloquia',
                        fontSize: 10,
                        fontWeight: FontWeight.w700),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget ballance(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: SizedBox(
            height: 40,
            child: Row(
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 0.0),
                  child: Text(
                    !hidden
                        ? formatCurrency.format(
                            AccountController.instance.selected().availbal)
                        : "U\$ ********",
                    style: const TextStyle(
                      fontFamily: 'Altone',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => setState(() {
                    hidden = !hidden;
                  }),
                  icon: Icon(hidden
                      ? Icons.remove_red_eye
                      : Icons.remove_red_eye_outlined),
                ),
              ],
            )),
      ),
    );
  }

  Widget ver_extrato() {
    return const Padding(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          "Ver extrato",
          style: TextStyle(
            fontFamily: 'Eloquia',
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Palette.bbaBlue,
          ),
        ),
      ),
    );
  }

  Widget menu_central() {
    return Wrap(
      spacing: 10.0,
      alignment: WrapAlignment.center,
      children: [
        item_menu(
          "Extrato",
          Icon(
            CupertinoIcons.doc_plaintext,
            color: Palette.bbaBlue,
          ),
        ),
        item_menu(
          "Cartoes",
          Icon(
            CupertinoIcons.creditcard,
            color: Palette.bbaBlue,
          ),
        ),
        item_menu(
          "Cartoes",
          Icon(
            CupertinoIcons.creditcard,
            color: Palette.bbaBlue,
          ),
        )
      ],
    );
  }

  Widget item_menu(String text, Icon icone) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Palette.bbaBlue),
        color: Colors.white,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: icone,
            ),
            Text(
              text,
              style: TextStyle(
                fontFamily: "Eloquia",
                fontWeight: FontWeight.w600,
                fontSize: 10,
              ),
            )
          ],
        ),
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
                  const Text(
                    "Ola Melquesedeque!",
                    style: TextStyle(
                        fontFamily: 'Eloquia', fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      menuRowItem("Perfil", Icon(CupertinoIcons.person),
                          () => print("123123123")),
                      menuRowItem("Sair do App", Icon(Icons.exit_to_app),
                          () => AuthController.instance.logout(context)),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget menuRowItem(String text, Icon icon, Function fnc) {
    return GestureDetector(
      onTap: () {
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
}

class BottomNavItem extends BottomNavigationBarItem {
  const BottomNavItem({required Widget icon, String? label})
      : super(icon: icon, label: label);
}

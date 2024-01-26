import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:login_api/configs/palette.config..dart';
import 'package:login_api/controllers/account_controller.dart';
import 'package:login_api/controllers/auth_controller.dart';
import 'package:login_api/pages/contas.page.dart';
import 'package:login_api/pages/uteis/header.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/accounts.model.dart';
import '../bottom.dart';

class HomePageTab extends StatefulWidget {
  const HomePageTab({super.key});

  @override
  State<HomePageTab> createState() => _HomePageTabState();
}

class _HomePageTabState extends State<HomePageTab>
    with SingleTickerProviderStateMixin {
  bool hidden = false;

  final ScrollController listScrollController = ScrollController();
  List<Widget> wdgt = [];

  late TabController _tabController;
  final formatCurrency = new NumberFormat.simpleCurrency();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 1);
    // AccountController.instance.LoadPortfolio(context).then((value) {
    //   if (mounted) {
    //     setState(() {
    //       isLoading = false;
    //       print("AGORA SIM");
    //     });
    //   }
    // });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                //height: MediaQuery.of(context).size.height * .35,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, top: 15.0, right: 15.0),
                      child: Column(
                        children: [
                          header(context, setState),
                          //details(context),
                          //ballance(context),
                        ],
                      ),
                    ),
                    TabBar(
                      unselectedLabelColor: Colors.black,
                      labelColor: Palette.bbaBlue,
                      tabs: [
                        Tab(
                          text: 'Accounts',
                        )
                      ],
                      controller: _tabController,
                      indicatorSize: TabBarIndicatorSize.tab,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  //height: MediaQuery.of(context).size.height * .35,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 243, 241, 241),
                  ),
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      isLoading ? loading() : contasTab(),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Padding(
          //   padding: const EdgeInsets.all(15.0),
          //   child: ListView.builder(
          //     controller: listScrollController,
          //     itemCount: wdgt.length,
          //     itemBuilder: (context, index) {
          //       return wdgt[index];
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget contasTab() {
    return ListView.builder(
      controller: listScrollController,
      itemCount: AccountController.instance.contas.length,
      itemBuilder: (context, index) {
        return account_card(AccountController.instance.contas[index]);
      },
    );
  }

  Widget account_card(Account acc) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Palette.bbaBlue),
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Radio(
                  value: acc.actnbr,
                  groupValue: AccountController.instance.selected_account,
                  onChanged: (String? value) {
                    setState(() {
                      if (value != null) {
                        print(value);
                        AccountController.instance.selected_account = value;
                        GoRouter.of(context).go("/transfers");
                        //context.go("/home");
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => HomePage()));
                      }
                    });
                  },
                ),
              ),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      acc.product,
                      style: const TextStyle(
                        fontFamily: 'Eloquia',
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          !acc.hidden
                              ? acc.actnbr
                              : "******" +
                                  acc.actnbr.substring(acc.actnbr.length - 4),
                          style: const TextStyle(
                              fontFamily: 'Eloquia', color: Colors.black),
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () => setState(() {
                            acc.hidden = !acc.hidden;
                          }),
                          icon: Icon(acc.hidden
                              ? Icons.remove_red_eye_outlined
                              : Icons.remove_red_eye),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Center(
                  child: Text(
                    formatCurrency.format(acc.availbal),
                    style:
                        TextStyle(fontFamily: 'Eloquia', color: Colors.black),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(40),
                    backgroundColor: Color.fromRGBO(255, 255, 255, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      // <-- Radius
                    ),
                  ),
                  onPressed: () {
                    //Navigator.pop(context);
                    AccountController.instance.selected_account = acc.actnbr;
                    GoRouter.of(context).go("/transfers");
                  },
                  child: Text(
                    'VIEW',
                    style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w700,
                        color: Palette.bbaBlue),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget loading() {
    return const Expanded(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget extrato() {
    return Expanded(
      flex: 10,
      child: Column(
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
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(10.0)),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.search),
            ),
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
              flex: 3,
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
              flex: 7,
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
}

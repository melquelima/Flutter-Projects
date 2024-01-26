import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:login_api/configs/palette.config..dart';
import 'package:login_api/controllers/account_controller.dart';
import 'package:login_api/controllers/auth_controller.dart';
import 'package:login_api/controllers/transactions_controller.dart';
import 'package:login_api/pages/contas.page.dart';
import 'package:login_api/pages/uteis/header.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/transactions_test.dart';
import '../../models/transaction.model.dart';

class ExtratoPage extends StatefulWidget {
  const ExtratoPage({super.key});

  @override
  State<ExtratoPage> createState() => _ExtratoPageState();
}

class _ExtratoPageState extends State<ExtratoPage>
    with SingleTickerProviderStateMixin {
  bool hidden = false;

  final ScrollController listScrollController = ScrollController();
  List<Widget> wdgt = [];

  late TabController _tabController;

  final formatCurrency = new NumberFormat.simpleCurrency();
  bool isLoading = true;

  List<Transaction> transactions = [
    // for (final e in mocTrans["DepAcctTrnInqRs"]["ResponseData"]
    //     ["TRANSACTION"]) ...[
    //   Transaction(e['TRANAMT'], e['TRANDESC'], e['TRANDESCS'], e['CURRBAL'],
    //       e['DRCRFLAG'], DateTime.parse(e['TRANDATE']))
    // ]
  ];

  // List<Transaction> transactions = [
  //   Transaction(
  //       -123.45,
  //       "LOREM IPSUM IS SIMPLY DUMMY TEXT OF THE PRINTING AND TYPESETTING INDUS",
  //       "04/07/2023"),
  //   Transaction(123.45, "Desc1", "04/07/2023"),
  //   Transaction(-78.85, "Desc1", "04/07/2023"),
  //   Transaction(78548.56, "Desc1", "04/07/2023"),
  //   Transaction(78548.56, "Desc1", "04/07/2023"),
  //   Transaction(78548.56, "Desc1", "04/07/2023"),
  // ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 1);
    TransactionController.instance.getList(context).then((value) {
      if (mounted) {
        setState(() {
          transactions = value;
          isLoading = false;
          print("AGORA SIM");
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15.0, top: 15.0, right: 15.0),
          child: Column(
            children: [
              header(context, setState),
            ],
          ),
        ),
        isLoading ? loading() : Text(""),
        !isLoading && transactions.length > 0 ? ballance() : const Text(""),
        !isLoading && transactions.length > 0 ? details() : Text(""),
      ],
    );
  }

  Widget ballance() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 10,
          child: Container(
            //height: MediaQuery.of(context).size.height * .35,
            decoration: const BoxDecoration(
              color: Palette.bbaBlue,
            ),
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        AccountController.instance.selected().product,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Altone',
                          //fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    Text(
                      formatCurrency.format(
                          AccountController.instance.selected().availbal),
                      //"U\$ 123,487",
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Altone',
                        //fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        "Available Balance",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Altone',
                          //fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget loading() {
    return const Expanded(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget details() {
    return Expanded(
      child: ListView.builder(
        controller: listScrollController,
        itemCount: transactions.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return registerItem(transactions[index]);
        },
      ),
    );
  }

  Widget registerItem(Transaction trans) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            //                    <--- top side
            color: Color.fromARGB(255, 170, 170, 170),
            width: 1.0,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            trans.DRCRFLAG == 'D'
                ? Icon(CupertinoIcons.minus_circle_fill)
                : Icon(CupertinoIcons.add_circled_solid),
            // RotatedBox(
            //   quarterTurns: trans.DRCRFLAG == 'D' ? 2 : 0,
            //   child: const Icon(CupertinoIcons.minus_circle_fill),
            // ),
            SizedBox(width: 10),
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      trans.TRANDESC + " " + (trans.TRANDESCS ?? ""),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    DateFormat("MM/dd/yyyy").format(trans.TRANDATE),
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Align(
              alignment: Alignment.topLeft,
              child: Wrap(
                spacing: 20.0,
                //runAlignment: WrapAlignment.spaceBetween,
                direction: Axis.vertical,
                alignment: WrapAlignment.spaceBetween,
                children: [
                  Text(
                    formatCurrency.format(trans.TRANAMT),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: trans.DRCRFLAG == 'D'
                          ? Color.fromARGB(255, 189, 99, 103)
                          : Colors.green,
                    ),
                  ),
                  Text(
                    formatCurrency.format(trans.CURRBAL),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

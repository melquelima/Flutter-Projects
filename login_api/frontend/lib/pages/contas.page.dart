import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:login_api/configs/palette.config..dart';
import 'package:login_api/controllers/account_controller.dart';
import 'package:login_api/models/accounts.model.dart';

import 'home/home.page.dart';

class ContasPage extends StatefulWidget {
  const ContasPage({super.key});

  @override
  State<ContasPage> createState() => _ContasPageState();
}

class _ContasPageState extends State<ContasPage> {
  final ScrollController listScrollController = ScrollController();
  final formatCurrency = new NumberFormat.simpleCurrency();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Portfolio",
            style: TextStyle(fontFamily: 'Eloquia', color: Colors.black),
          ),
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: ListView.builder(
          controller: listScrollController,
          itemCount: AccountController.instance.contas.length,
          itemBuilder: (context, index) {
            return account_card(AccountController.instance.contas[index]);
          },
        ));
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
                        GoRouter.of(context).go("/home");
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
                flex: 7,
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
            ],
          ),
        ),
      ),
    );
  }
}



// Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           for (final e in AccountController.instance.contas) ...[
//             account_card(e)
//           ],
//         ],
//       )
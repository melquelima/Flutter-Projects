import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:login_api/amplify/configure.dart';
import 'package:login_api/configs/palette.config..dart';
import 'package:login_api/controllers/account_controller.dart';
import 'package:login_api/controllers/auth_controller.dart';
import 'package:login_api/controllers/transactions_controller.dart';
import 'package:login_api/models/acc_details.model.dart';
import 'package:login_api/pages/contas.page.dart';
import 'package:login_api/pages/uteis/header.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/transactions_test.dart';
import '../../models/transaction.model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ScrollController listScrollController = ScrollController();

  List<Widget> widgets = [];
  var isLoading = true;

  @override
  void initState() {
    super.initState();
    getCurrentUserId(context).then((user) {
      if (user == null) return context.go("/login");
      AccountController.instance.LoadDetais(context, user).then((value) {
        if (mounted && value != null) {
          setState(() {
            isLoading = false;
          });
        }
        //logout(context).then((value) => null);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    widgets = [
      clientImage2(),
      clientName(),
      bankData(),
      addressData("Address", AccountController.instance.accDetail.addresses),
      addressData("Phones", AccountController.instance.accDetail.phones),
      addressData("Emails", AccountController.instance.accDetail.emails),
    ];

    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Color.fromARGB(255, 223, 82, 82),
        titleSpacing: 0,
        backgroundColor: Color(0xfafafa),
        iconTheme: IconThemeData(color: Palette.bbaBlue),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Profile",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        // bottom: PreferredSize(
        //   preferredSize: const Size.fromHeight(1.0),
        //   child: Container(
        //     color: Palette.bbaBlue,
        //     height: 2.0,
        //   ),
        // ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: !isLoading
            ? ListView.builder(
                controller: listScrollController,
                itemCount: widgets.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return widgets[index];
                },
              )
            : loading(),
      ),
    );
  }

  Widget loading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget clientImage() {
    return Center(
        child: Stack(
      children: [
        CircleAvatar(
          radius: 53,
          backgroundColor: Palette.bbaBlue,
          child: CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white,
            child: Text(
              AccountController.instance.initialProffileImage(),
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Palette.bbaBlue,
              ),
            ),
            //backgroundImage: AssetImage('assets/images/default.png'),
          ),
        ),
        Positioned(
          bottom: 1,
          right: 1,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Icon(Icons.edit, color: Colors.black),
            ),
            decoration: BoxDecoration(
                border: Border.all(
                  width: 3,
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    50,
                  ),
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(2, 4),
                    color: Colors.black.withOpacity(
                      0.3,
                    ),
                    blurRadius: 3,
                  ),
                ]),
          ),
        ),
      ],
    ));
  }

  Widget clientImage2() {
    return Center(
        child: Stack(
      children: [
        CircleAvatar(
          radius: 53,
          backgroundColor: Color.fromARGB(255, 219, 219, 221),
          child: CircleAvatar(
            radius: 50,
            backgroundColor: Palette.bbaBlue,
            child: Text(
              AccountController.instance.initialProffileImage(),
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            //backgroundImage: AssetImage('assets/images/default.png'),
          ),
        ),
        Positioned(
          bottom: 1,
          right: 1,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Icon(Icons.edit, color: Colors.black),
            ),
            decoration: BoxDecoration(
                border: Border.all(
                  width: 3,
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    50,
                  ),
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(2, 4),
                    color: Colors.black.withOpacity(
                      0.3,
                    ),
                    blurRadius: 3,
                  ),
                ]),
          ),
        ),
      ],
    ));
  }

  Widget clientName() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: RichText(
          overflow: TextOverflow.ellipsis,
          strutStyle: const StrutStyle(fontSize: 12.0),
          text: TextSpan(
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Eloquia'),
              text:
                  AccountController.instance.accDetail.full_name.toUpperCase()),
        ),
      ),
    );
  }

  Widget bankData() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 1,
                    color: const Color.fromARGB(255, 219, 219, 219),
                  ),
                  //color: Colors.red,
                ),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      //crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 2,
                          child: Column(
                            //mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text(
                                "Account Number",
                                style: TextStyle(
                                  fontFamily: 'Eloquia',
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, bottom: 15.0),
                                child: Text(
                                  AccountController.instance.selected().actnbr,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Eloquia',
                                  ),
                                ),
                              ),
                              const Text(
                                "Agency",
                                style: TextStyle(
                                  fontFamily: 'Eloquia',
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 8.0, bottom: 15),
                                child: Text(
                                  "00001",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Eloquia',
                                  ),
                                ),
                              ),
                              const Text(
                                "Officer",
                                style: TextStyle(
                                  fontFamily: 'Eloquia',
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Text(
                                  AccountController.instance
                                          .selected()
                                          .officer +
                                      "-BBAM",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Eloquia',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 1,
                          child: Icon(Icons.copy_all),
                        ),
                      ],
                    )),
              ),
            ),
            //Icon(Icons.copy_all),
          ],
        ),
      ),
    );
  }

  Widget addressData(String title, List values) {
    var keys = {
      "List<AddressDetail>": "address",
      "List<PhoneDetail>": "phone",
      "List<EmailDetail>": "email"
    };
    var key = keys[values.runtimeType.toString()];

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 1,
                    color: const Color.fromARGB(255, 219, 219, 219),
                  ),
                  //color: Colors.red,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          for (var i = 0; i < values.length; i += 2) ...[
                            rowField(
                                "${title} ${(i + 1).toString()}",
                                values[i].getProp(key),
                                "${title} ${(i + 2).toString()}",
                                (i + 1) == values.length
                                    ? ""
                                    : values[i + 1].getProp(key))
                          ]
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            //Icon(Icons.copy_all),
          ],
        ),
      ),
    );
  }

  Widget rowField(
    String title1,
    String value1,
    String title2,
    String value2,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        //mainAxisSize: MainAxisSize.max,
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          value1.trim().isNotEmpty ? field(title1, value1) : Container(),
          value2.trim().isNotEmpty ? dash() : Container(),
          value2.trim().isNotEmpty ? field(title2, value2) : Container(),
        ],
      ),
    );
  }

  Widget dash() {
    return Container(
      child: const Padding(
        padding: EdgeInsets.only(left: 8.0, right: 8),
        child: Align(
          alignment: Alignment.center,
          child: Dash(
            direction: Axis.vertical,
            length: 70,
            dashLength: 2,
            dashColor: Color.fromARGB(255, 190, 189, 189),
          ),
        ),
      ),
    );
  }

  Widget field(String title, String value) {
    return Flexible(
      fit: FlexFit.tight,
      flex: 1,
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Eloquia',
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text(
              value,
              style: const TextStyle(
                //fontWeight: FontWeight.bold,
                fontFamily: 'Eloquia',
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

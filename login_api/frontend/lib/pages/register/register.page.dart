import 'dart:convert';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_api/configs/palette.config..dart';
import 'package:login_api/controllers/new_account.dart';
import 'package:login_api/models/App.dart';
import 'package:login_api/pages/register/info.tab.dart';
import 'package:login_api/pages/register/userInfo.tab.dart';
import 'package:login_api/pages/register/validate.tab.dart';
import 'package:login_api/pages/uteis/validators.dart';
import 'package:login_api/pages/register/register.global.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<bool> _isDisabledTab = [false, true, true];
  List<bool> _isTabComplete = [false, false, false];
  List<Widget> _tabs = [];

  final _usuarioController = TextEditingController();
  final _senhaController = TextEditingController();
  List<bool> hidden = [true, true, true];
  bool isLoading = false;
  dynamic user_info;

  //RegisterPageGlobal registerGlobal = RegisterPageGlobal(hidden);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, length: 3, initialIndex: 0);
    _tabController.addListener(onTap);
    // registerGlobal.addListener(() {
    //   setState(() {});
    // });
    // _usuarioController.addListener(() {
    //   setState(() {
    //     print(_usuarioController.text);
    //   });
    // });
  }

  void on_render() {
    _tabs = [
      Tab(
          child: Text('Info',
              style: TextStyle(
                  color: _isDisabledTab[0]
                      ? const Color.fromARGB(255, 146, 146, 146)
                      : null))),
      Tab(
          child: Text('User Info',
              style: TextStyle(
                  color: _isDisabledTab[1]
                      ? const Color.fromARGB(255, 146, 146, 146)
                      : null))),
      Tab(
          child: Text('Validation',
              style: TextStyle(
                  color: _isDisabledTab[2]
                      ? const Color.fromARGB(255, 146, 146, 146)
                      : null))),
    ];
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    NewAccountController.instance.reset();
  }

  @override
  Widget build(BuildContext context) {
    on_render();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 240, 241),
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 1,
                child: TabBar(
                  unselectedLabelColor: Colors.black,
                  //indicatorColor: Colors.green,
                  labelColor: Palette.bbaBlue,
                  tabs: _tabs,
                  controller: _tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                ),
              ),
              Expanded(
                flex: 9,
                child: TabBarView(
                  controller: _tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    InfoTab(tabGoNext: tabGoNext),
                    UserInfoTab(tabGoNext: tabGoNext),
                    ValidateTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onTap() {
    if (_isDisabledTab[_tabController.index]) {
      int index = _tabController.previousIndex;
      setState(() {
        _tabController.index = index;
      });
    }
  }

  tabGoNext() {
    int index = _tabController.index + 1;
    if (index < _tabController.length) {
      _isDisabledTab[index] = false;
      _isTabComplete[index - 1] = true;
      setState(() {
        _tabController.index = index;
      });
    }
  }
}

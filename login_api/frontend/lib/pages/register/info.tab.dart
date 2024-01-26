import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login_api/controllers/new_account.dart';
import 'package:login_api/models/new_user_info.dart';
import 'package:login_api/pages/register/register.global.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../amplify/configure.dart';
import '../uteis/validators.dart';

class InfoTab extends StatefulWidget {
  Function tabGoNext;
  InfoTab({super.key, required this.tabGoNext});

  @override
  State<InfoTab> createState() => _InfoTabState(tabGoNext);
}

class _InfoTabState extends State<InfoTab> {
  Function tabGoNext;
  _InfoTabState(this.tabGoNext);

  final _taxIdController = TextEditingController();
  final _dobController = TextEditingController();
  final _formKeyInfo = GlobalKey<FormState>();

  bool _isTabComplete = false;
  bool isLoading = false;

  dynamic user_info;

  var maskFormatter = MaskTextInputFormatter(
      mask: '##/##/####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  @override
  void initState() {
    super.initState();
    _taxIdController.text = "149252955";
    _dobController.text = "01/31/1986";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Form(
        key: _formKeyInfo,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "TaxId",
                style: TextStyle(
                  color: Color.fromRGBO(88, 88, 88, 1),
                ),
              ),
            ),
            TextFormField(
              decoration: textStyleField('Type your taxId'),
              // decoration: InputDecoration(
              //   labelText: 'Type your taxId',
              //   errorText: _errorTaxId,
              // ),
              enabled: NewAccountController.instance.user.is_empty,
              validator: _errorTaxId,
              controller: _taxIdController,
              keyboardType: TextInputType.text,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Date of Birth",
                style: TextStyle(
                  color: Color.fromRGBO(88, 88, 88, 1),
                ),
              ),
            ),
            // InputDatePickerFormField(
            //     firstDate: DateTime.now(), lastDate: DateTime.now()),
            TextFormField(
                decoration: textStyleField('mm/dd/yyyy'),
                validator: _errorDob,
                controller: _dobController,
                keyboardType: TextInputType.text,
                enabled: NewAccountController.instance.user.is_empty,
                //obscureText: hidden,
                inputFormatters: [maskFormatter]),
            const SizedBox(height: 20),
            nextButton(
                next, isLoading, NewAccountController.instance.user.is_empty),
          ],
        ),
      ),
    );
  }

  void next() {
    if (isLoading || !NewAccountController.instance.user.is_empty) return;
    if (_formKeyInfo.currentState!.validate()) {
      loading(true);
      get_customer(context, _taxIdController.text, _dobController.text)
          .then((value) {
        if (value != null) {
          NewAccountController.instance.user = NewUserInfo.fromJson(value);
          tabGoNext();
        }
        loading(false);
      });
    }
  }

  InputDecoration textStyleField(String label) {
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
      border: InputBorder.none,
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(
          color: Color.fromARGB(255, 230, 229, 229),
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(
          color: Color.fromARGB(255, 230, 229, 229),
        ),
      ),
    );
  }

  String? _errorTaxId(String? text) {
    //final text = _usuarioController.value.text;
    if (text == null || text.isEmpty) return 'Can\'t be empty';
    if (text.length != 9) return 'invalid tax id';
    if (!isNumeric(text)) return 'only numbers';
    return null;
  }

  String? _errorDob(String? text) {
    //final text = _usuarioController.value.text;
    //if (text == null) return
    if (text == null || text.isEmpty) return 'Can\'t be empty';
    if (text.length != 10) return 'Invalid Date';
    if (!isDate(text, "MM/dd/yyyy")) {
      return 'Invalid Date';
      // DateTime date = DateTime.parse(text);
    }
  }

  void loading(bool val) {
    setState(() {
      isLoading = val;
    });
  }
}

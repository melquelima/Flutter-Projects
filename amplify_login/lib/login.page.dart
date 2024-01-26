import 'dart:convert';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_login/utteis/validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<bool> _isDisabledTab = [false, true, true];
  List<bool> _isTabComplete = [false, false, false];
  List<Widget> _tabs = [];

  final _formKeyInfo = GlobalKey<FormState>();
  final _formKeyUserInfo = GlobalKey<FormState>();
  final _formValidator = GlobalKey<FormState>();
  final _usuarioController = TextEditingController();
  final _taxIdController = TextEditingController();
  final _senhaController = TextEditingController();
  final _dobController = TextEditingController();
  final _senhaConfirmController = TextEditingController();
  final _confirmCodeController = TextEditingController();
  List<bool> hidden = [true, true, true];
  bool isLoading = false;
  dynamic user_info;

  var maskFormatter = MaskTextInputFormatter(
      mask: '##/##/####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, length: 3, initialIndex: 0);
    _tabController.addListener(onTap);
    // _usuarioController.addListener(() {
    //   setState(() {
    //     print(_usuarioController.text);
    //   });
    // });

    _taxIdController.text = "149252955";
    _dobController.text = "01/31/1986";
    _usuarioController.text = "gferreira6142654";
    _senhaConfirmController.text = "gferreira123nasd!@#";
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
  Widget build(BuildContext context) {
    on_render();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 240, 241),
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
                  //labelColor: Palette.bbaBlue,
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
                  children: [infoStep(), userInfoStep(), validationsStep()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //============================================================ TABS

  Widget infoStep() {
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
              decoration: textStyleField('Type your taxId', false, 0),
              // decoration: InputDecoration(
              //   labelText: 'Type your taxId',
              //   errorText: _errorTaxId,
              // ),
              enabled: !_isTabComplete[0],
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
                decoration: textStyleField('mm/dd/yyyy', false, 0),
                validator: _errorDob,
                controller: _dobController,
                keyboardType: TextInputType.text,
                enabled: !_isTabComplete[0],
                //obscureText: hidden,
                inputFormatters: [maskFormatter]),
            const SizedBox(height: 20),
            InfoStepButton(),
          ],
        ),
      ),
    );
  }

  Widget userInfoStep() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Form(
        key: _formKeyUserInfo,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "User",
                style: TextStyle(
                  color: Color.fromRGBO(88, 88, 88, 1),
                ),
              ),
            ),
            TextFormField(
              decoration: textStyleField('Type your user', false, 0),
              validator: _errorUser,
              controller: _usuarioController,
              keyboardType: TextInputType.text,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Password",
                style: TextStyle(
                  color: Color.fromRGBO(88, 88, 88, 1),
                ),
              ),
            ),
            TextFormField(
              decoration: textStyleField('...', true, 0),
              validator: _errorPassword,
              controller: _senhaController,
              keyboardType: TextInputType.text,
              obscureText: hidden[0],
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Confirm your Password",
                style: TextStyle(
                  color: Color.fromRGBO(88, 88, 88, 1),
                ),
              ),
            ),
            TextFormField(
              decoration: textStyleField('...', true, 1),
              validator: _errorConfirmPassword,
              controller: _senhaConfirmController,
              keyboardType: TextInputType.text,
              obscureText: hidden[1],
            ),
            const SizedBox(height: 20),
            UserInfoStepButton(),
          ],
        ),
      ),
    );
  }

  Widget validationsStep() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Form(
        key: _formValidator,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            TextFormField(
              decoration: textStyleField('Code Here', true, 2),
              validator: _errorCode,
              controller: _confirmCodeController,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 20),
            ValidationStepButton(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: MaterialButton(
                onPressed: () {
                  _onResent().then((value) => null);
                },
                child:
                    Text("Resend code", style: TextStyle(color: Colors.grey)),
              )),
            )
          ],
        ),
      ),
    );
  }

  //============================================================ BUTTONS

  Widget LoginButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(40),
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // <-- Radius
        ),
      ),
      onPressed: () {
        _onLogin().then((value) => null);
      },
      child: const Padding(
        padding: EdgeInsets.all(10.0),
        child: Text(
          'Log in',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  Widget SignUpButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(40),
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // <-- Radius
        ),
      ),
      onPressed: () {
        _onSignUp().then((value) => null);
      },
      child: const Padding(
        padding: EdgeInsets.all(10.0),
        child: Text(
          'Sign Up',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  Widget InfoStepButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(40),
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // <-- Radius
        ),
      ),
      onPressed: () {
        //postTodo().then((value) => null);
        if (_formKeyInfo.currentState!.validate()) {
          setState(() {
            isLoading = true;
          });
          get_customer(_taxIdController.text, _dobController.text)
              .then((value) {
            if (value != null) {
              user_info = jsonDecode(value);
              tabGoNext();
            }
            setState(() {
              isLoading = false;
            });
          });
        }
      },
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: isLoading
            ? circularLoading()
            : const Text(
                'Next',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
              ),
      ),
    );
  }

  Widget UserInfoStepButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(40),
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // <-- Radius
        ),
      ),
      onPressed: () {
        //postTodo().then((value) => null);
        if (_formKeyUserInfo.currentState!.validate()) {
          setState(() {
            isLoading = true;
          });
          _onSignUp().then((value) {
            if (value != null) {
              tabGoNext();
            }
            setState(() {
              isLoading = false;
            });
          });
        }
      },
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: isLoading
            ? circularLoading()
            : const Text(
                'Next',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
              ),
      ),
    );
  }

  Widget ValidationStepButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(40),
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // <-- Radius
        ),
      ),
      onPressed: () {
        //postTodo().then((value) => null);
        if (_formValidator.currentState!.validate()) {
          setState(() {
            isLoading = true;
          });

          _onValidate().then((value) {
            if (value != null) {
              var a = 1;
            }
            setState(() {
              isLoading = false;
            });
          });
        }
      },
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: isLoading
            ? circularLoading()
            : const Text(
                'Validate',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
              ),
      ),
    );
  }

  Widget circularLoading() {
    return Transform.scale(
      scale: 0.8,
      child: CircularProgressIndicator(color: Colors.white),
    );
  }

  //============================================================ FUNCTIONS

  Future<String?> get_customer(String taxId, String dob) async {
    try {
      dob = dateToStr(strToDate(dob, "MM/dd/yyyy"), "yyyyMMdd");
      final restOperation = Amplify.API.post(
        '/validateCustomer',
        body: HttpPayload.json({'taxId': taxId, 'dateOfBirth': dob}),
      );
      final response = await restOperation.response;
      print('POST call succeeded');
      return response.decodeBody();
    } on HttpStatusException catch (e) {
      displayError(e.message);
      //print('${e.message} - ${e..recoverySuggestion}');
      return null;
    }
  }

  Future<String> _onLogin() async {
    try {
      //final test = Amplify.API.get(restOptions: RestOptions(path: path))

      final res = await Amplify.Auth.signIn(
          username: _usuarioController.text, password: _senhaController.text);
      var a = 1;
    } on AuthException catch (e) {
      return '${e.message} - ${e..recoverySuggestion}';
    } catch (e) {
      var a = 1;
    }
    return "";
  }

  Future<String?> _onSignUp() async {
    try {
      final userAttributes = <AuthUserAttributeKey, String>{
        //AuthUserAttributeKey.email: user_info["email"],
        //uthUserAttributeKey.email: "melque_ex@yahoo.com.br",
        //_AuthUserAttributeKey("custom:taxid"): _taxIdController.text,
        _AuthUserAttributeKey("custom:custkey"): user_info["cust_key"]
      };

      //CognitoSignUpOptions

      final res = await Amplify.Auth.signUp(
        username: _usuarioController.text,
        password: _senhaController.text,
        options: SignUpOptions(userAttributes: userAttributes),
      );
      return "Ok";
    } on AuthException catch (e) {
      displayError(e.message);
      //return '${e.message} - ${e..recoverySuggestion}';
      return null;
    }
  }

  Future<String?> _onValidate() async {
    try {
      final res = await Amplify.Auth.confirmSignUp(
          username: _usuarioController.text,
          confirmationCode: _confirmCodeController.text);
      return "Ok";
    } on AuthException catch (e) {
      displayError(e.message);
      //return '${e.message} - ${e..recoverySuggestion}';
      return null;
    }
  }

  Future<String?> _onResent() async {
    try {
      final res = await Amplify.Auth.resendSignUpCode(
          username: _usuarioController.text);
      displaySuccess("Code sent successfuly!");
    } on AuthException catch (e) {
      displayError(e.message);
      //return '${e.message} - ${e..recoverySuggestion}';
      return null;
    }
  }

  InputDecoration textStyleField(String label, bool useIcon, int index_hidden) {
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
      suffixIcon: useIcon
          ? IconButton(
              onPressed: () => setState(() {
                    hidden[index_hidden] = !hidden[index_hidden];
                  }),
              icon: Icon(hidden[index_hidden]
                  ? Icons.remove_red_eye_outlined
                  : Icons.remove_red_eye))
          : null,
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

  //============================================================ SNACKBAK ERROR

  void displayError(String error) {
    final snackBar = SnackBar(
      content: Text(
        error,
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.redAccent,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void displaySuccess(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  //============================================================ VALIDATORS

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

  String? _errorUser(String? text) {
    if (text == null || text.isEmpty) return 'Can\'t be empty';
  }

  String? _errorCode(String? text) {
    if (text == null || text.isEmpty) return 'Can\'t be empty';
  }

  String? _errorPassword(String? text) {
    if (text == null || text.isEmpty) return 'Can\'t be empty';
  }

  String? _errorConfirmPassword(String? text) {
    if (text == null || text.isEmpty) return 'Can\'t be empty';
    if (text != _senhaController.text) return 'Passwords does not match';
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

class _AuthUserAttributeKey extends AuthUserAttributeKey {
  const _AuthUserAttributeKey(this.key);

  @override
  final String key;
}

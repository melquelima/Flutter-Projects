import 'package:flutter/material.dart';
import 'package:login_api/controllers/new_account.dart';
import 'package:login_api/amplify/configure.dart';
import 'package:login_api/pages/register/register.global.dart';

class UserInfoTab extends StatefulWidget {
  Function tabGoNext;
  UserInfoTab({super.key, required this.tabGoNext});

  @override
  State<UserInfoTab> createState() => _UserInfoTabState(tabGoNext);
}

class _UserInfoTabState extends State<UserInfoTab> {
  Function tabGoNext;
  _UserInfoTabState(this.tabGoNext);

  final _formKeyUserInfo = GlobalKey<FormState>();
  final _usuarioController = TextEditingController();
  final _senhaController = TextEditingController();
  final _senhaConfirmController = TextEditingController();

  List<bool> hidden = [true, true];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _usuarioController.text = NewAccountController.instance.userName ?? "";
    _senhaController.text = NewAccountController.instance.password ?? "";
    _senhaConfirmController.text = NewAccountController.instance.password ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Form(
        key: _formKeyUserInfo,
        child: SingleChildScrollView(
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
                validator: _errorNotEmpty,
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
                validator: _errorNotEmpty,
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
              nextButton(next, isLoading, true),
            ],
          ),
        ),
      ),
    );
  }

  void next() {
    if (_formKeyUserInfo.currentState!.validate()) {
      loading(true);
      onSignUp(context, _usuarioController.text, _senhaController.text)
          .then((value) {
        if (value != null) {
          NewAccountController.instance.userName = _usuarioController.text;
          NewAccountController.instance.password = _senhaController.text;
          tabGoNext();
        }
        loading(false);
      });
    }
  }

  void loading(bool val) {
    setState(() {
      isLoading = val;
    });
  }

  String? _errorNotEmpty(String? text) {
    if (text == null || text.isEmpty) return 'Can\'t be empty';
  }

  String? _errorConfirmPassword(String? text) {
    if (text == null || text.isEmpty) return 'Can\'t be empty';
    if (text != _senhaController.text) return 'Passwords does not match';
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
}

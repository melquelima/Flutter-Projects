import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:login_api/controllers/new_account.dart';
import 'package:login_api/amplify/configure.dart';
import 'package:login_api/pages/register/register.global.dart';

class ValidateTab extends StatefulWidget {
  const ValidateTab({super.key});

  @override
  State<ValidateTab> createState() => _ValidateTabState();
}

class _ValidateTabState extends State<ValidateTab> {
  final _formValidator = GlobalKey<FormState>();

  final _confirmCodeController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
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
              decoration: textStyleField('Code Here', true),
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
                  onResent(context, NewAccountController.instance.userName)
                      .then((value) => null);
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

  InputDecoration textStyleField(String label, bool useIcon) {
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
          loading(true);

          onValidate(context, NewAccountController.instance.userName,
                  _confirmCodeController.text)
              .then((value) {
            if (value != null) {
              NewAccountController.instance.reset();
              GoRouter.of(context).pushReplacement('/login');
            }
            loading(false);
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

  String? _errorCode(String? text) {
    if (text == null || text.isEmpty) return 'Can\'t be empty';
  }

  void loading(bool val) {
    setState(() {
      isLoading = val;
    });
  }
}

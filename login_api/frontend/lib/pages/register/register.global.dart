import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_api/configs/palette.config..dart';

class RegisterPageGlobal extends ChangeNotifier {
  List<bool> hidden;
  RegisterPageGlobal(this.hidden);

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
              onPressed: () {
                hidden[index_hidden] = !hidden[index_hidden];
                notifyListeners();
              },
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

Widget circularLoading() {
  return Transform.scale(
    scale: 0.8,
    child: CircularProgressIndicator(color: Colors.white),
  );
}

Widget nextButton(void Function()? onPressed, bool isLoading, bool isEnabled) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size.fromHeight(40),
      backgroundColor: isEnabled
          ? Palette.bbaBlue
          : const Color.fromARGB(255, 134, 134, 134),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // <-- Radius
      ),
    ),
    onPressed: onPressed,
    child: Padding(
      padding: const EdgeInsets.all(10.0),
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

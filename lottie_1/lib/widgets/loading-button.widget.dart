import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingButton extends StatelessWidget {
  final bool busy;
  final Function func;

  LoadingButton({@required this.busy, @required this.func});

  @override
  Widget build(BuildContext context) {
    if (!busy) {
      return FlatButton(
        color: Color(0xFFC767E7),
        child: Text(
          "CADASTRAR",
          style: TextStyle(color: Colors.white),
        ),
        onPressed: func,
      );
    } else {
      return CircularProgressIndicator();
    }
  }
}

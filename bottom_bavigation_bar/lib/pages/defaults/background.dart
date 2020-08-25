import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

BoxDecoration bg1 = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.3, 1],
    colors: [
      Color.fromRGBO(51, 9, 9, 1),
      Colors.black,
    ],
  ),
  borderRadius: BorderRadius.all(Radius.circular(10)),
  border: Border.all(
    width: 1.0,
    color: Colors.white,
  ),
);

BoxDecoration bg2 = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomRight,
    stops: [0.4, 1],
    colors: [
      Color.fromRGBO(51, 9, 9, 1),
      Colors.black,
    ],
  ),
);

BoxDecoration bg3 = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomRight,
    stops: [0.4, 1],
    colors: [
      Colors.grey[300],
      Colors.black,
    ],
  ),
);

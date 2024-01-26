import 'package:flutter/material.dart';

const MaterialColor Palette_mtech = MaterialColor(
  0xFF000A76, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
  <int, Color>{
    50: Color(0xFFE0E2EF),
    100: Color(0xFFB3B6D6),
    200: Color(0xFF8085BB),
    300: Color(0xFF4D549F),
    400: Color(0xFF262F8B),
    500: Color(0xFF000A76),
    600: Color(0xFF00096E),
    700: Color(0xFF000763),
    800: Color(0xFF000559),
    900: Color(0xFF000346),
  },
);

const MaterialColor PaletePatrol =
    MaterialColor(_PatrolPrimaryValue, <int, Color>{
  50: Color(0xFFFEF0E5),
  100: Color(0xFFFCDABE),
  200: Color(0xFFFAC192),
  300: Color(0xFFF7A866),
  400: Color(0xFFF69546),
  500: Color(_PatrolPrimaryValue),
  600: Color(0xFFF37A21),
  700: Color(0xFFF16F1B),
  800: Color(0xFFEF6516),
  900: Color(0xFFEC520D),
});
const int _PatrolPrimaryValue = 0xFFF48225;

const MaterialColor PatrolAccent =
    MaterialColor(_PatrolAccentValue, <int, Color>{
  100: Color(0xFFFFFFFF),
  200: Color(_PatrolAccentValue),
  400: Color(0xFFFFC6B1),
  700: Color(0xFFFFB397),
});
const int _PatrolAccentValue = 0xFFFFEBE4;

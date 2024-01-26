import 'package:flutter/material.dart'; 
class Palette { 
  static const MaterialColor bbaBlue = MaterialColor( 
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
}
import 'package:flutter/material.dart';

class ColorPallet {
// color constants
  static final MaterialColor mainColor = _createMaterialColor(Color(0xFF81D9B4));
  static final MaterialColor backgroundColor = _createMaterialColor(Color(0xFFF8F8F8));
  static final MaterialColor mainTextColor = _createMaterialColor(Color(0xFF181818));
  static final MaterialColor placeholderColor = _createMaterialColor(Color(0xFFC7C7C7));
  static final MaterialColor subsidiaryTextColor = _createMaterialColor(Color(0xFF878787));
  static final MaterialColor lightGreyColor = _createMaterialColor(Color(0xFFE9E9E9));
  static final MaterialColor lightBlueColor = _createMaterialColor(Color(0xFF00D1FF));
  static final MaterialColor darkGreenColor = _createMaterialColor(Color(0xFF6FBE9D));

// blocks colors
  static final MaterialColor blueBlockColor = _createMaterialColor(Color(0xFF769CFF));
  static final MaterialColor redBlockColor = _createMaterialColor(Color(0xFFED7676));
  static final MaterialColor yellowBlockColor = _createMaterialColor(Color(0xFFFFFACD));


// creates new MaterialColor from Color
  static MaterialColor _createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map swatch = <int, Color>{};
    final int r = color.red,
        g = color.green,
        b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }
}
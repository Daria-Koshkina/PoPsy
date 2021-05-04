import 'package:flutter/material.dart';
import 'package:po_psy/constants/UIConstants/ColorPallet.dart';

class Logo extends StatelessWidget {
  final Shader linearGradient = LinearGradient(
    colors: <Color>[ColorPallet.mainColor, ColorPallet.lightBlueColor,],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ).createShader(Rect.fromLTWH(0.0, 0.0, 299, 131));

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        'PoPsy',
        style: new TextStyle(
            fontSize: 144,
            fontFamily: 'Qwigley',
            foreground: Paint()..shader = linearGradient),
      ),
    );
  }
  
}
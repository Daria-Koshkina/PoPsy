import 'package:flutter/material.dart';
import 'package:po_psy/constants/UIConstants/ColorPallet.dart';

class Logo extends StatelessWidget {
  final Shader linearGradient = LinearGradient(
    colors: <Color>[ColorPallet.mainColor, ColorPallet.lightBlueColor,],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ).createShader(Rect.fromLTWH(0.0, 0.0, 299, 189));

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('PoPsy',
        style: new TextStyle(
            shadows: [
              Shadow(
                blurRadius: 5.0,
                color: Colors.white,
                offset: Offset(0.0, 0.0),
              ),
              Shadow(
                blurRadius: 2.0,
                color: Colors.white,
                offset: Offset(-1.0, -1.0),
              ),
              Shadow(
                blurRadius: 2.0,
                color: Colors.white,
                offset: Offset(1.0, -1.0),
              ),
              Shadow(
                blurRadius: 2.0,
                color: Colors.white,
                offset: Offset(1.0, 1.0),
              ),
              Shadow(
                blurRadius: 2.0,
                color: Colors.white,
                offset: Offset(-1.0, 1.0),
              )
            ],
            fontSize: 150,
            fontFamily: 'Qwigley',
            foreground: Paint()..shader = linearGradient),
      ),
    );
  }
  
}
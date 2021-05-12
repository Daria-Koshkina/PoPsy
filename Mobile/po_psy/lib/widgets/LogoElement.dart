import 'package:flutter/material.dart';
import 'package:po_psy/constants/UIConstants/ColorPallet.dart';
import 'package:po_psy/widgets/Logo.dart';

class LogoElement extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            height: 150,
            margin: EdgeInsets.only(left: 20, right: 20),
            decoration: new BoxDecoration(
              borderRadius:
              BorderRadius.only(bottomLeft: Radius.circular(35.0),
                bottomRight: Radius.circular(35.0),
                topRight: Radius.circular(35.0,),
                topLeft: Radius.circular(35.0)),
              color: ColorPallet.mainColor,
            ),
          ),
          Container(
            height: 100,
            margin: EdgeInsets.only(left: 20, right: 200, top: 80),
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.elliptical(150, 70),
              ),
              color: ColorPallet.mainColor,
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Logo(),
          ),
        ]
      )
    );
  }
}
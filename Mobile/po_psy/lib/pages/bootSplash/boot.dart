import 'package:flutter/material.dart';
import 'package:po_psy/constants/UIConstants/ColorPallet.dart';
import 'package:po_psy/constants/UIConstants/TextStyles.dart';
import 'package:po_psy/widgets/Logo.dart';
import 'package:po_psy/widgets/MainButton.dart';


class BootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0, 1],
            colors: [ColorPallet.mainColor, ColorPallet.lightBlueColor,],
          ),
        ),
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 20),
          child: Logo(),
        ),
      )
    );
  }
}
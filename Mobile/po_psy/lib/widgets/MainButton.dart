import 'package:flutter/material.dart';
import 'package:po_psy/constants/UIConstants/ColorPallet.dart';
import 'package:po_psy/constants/UIConstants/TextStyles.dart';

class MyButton extends StatelessWidget {
  MyButton({this.text, onPressed});
  String text;
  
  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [ColorPallet.mainColor, ColorPallet.lightBlueColor]
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      width: 200.0,
      child: TextButton(
        child: Text(text, style: TextStyles.lightHeader2TextStyle),
        onPressed: (){},
      )
    );
  }
}
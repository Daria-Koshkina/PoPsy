import 'package:flutter/material.dart';
import 'package:po_psy/constants/UIConstants/ColorPallet.dart';
import 'package:po_psy/constants/UIConstants/TextStyles.dart';
import 'package:po_psy/widgets/Logo.dart';
import 'package:po_psy/widgets/MainButton.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hello world!',
          style: TextStyles.headerTextStyle,
        ),
        backgroundColor: ColorPallet.backgroundColor,
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Logo(),
            MyButton(text: 'Button'),
          ],
        )
      ),
    );
  }

}

import 'package:flutter/material.dart';
import 'package:po_psy/constants/UIConstants/ColorPallet.dart';
import 'dart:async';
import 'package:po_psy/constants/UIConstants/TextStyles.dart';
import 'package:po_psy/widgets/Logo.dart';
import 'package:po_psy/pages/authorization/login/login.dart';
import 'package:po_psy/widgets/MainButton.dart';


class BootPage extends StatefulWidget {

  @override
  _BootPageState createState() => _BootPageState();
}

class _BootPageState extends State<BootPage> {
  @override
  void initState() {
    super.initState();
    // Timer(
    //     Duration(seconds: 3),
    //         () => Navigator.of(context).pushReplacement(MaterialPageRoute(
    //         builder: (BuildContext context) => LoginPage())));
  }

  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 3),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => LoginPage())));
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0, 1],
            colors: [ColorPallet.lightBlueColor, ColorPallet.mainColor,],
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
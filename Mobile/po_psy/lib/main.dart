import 'package:flutter/material.dart';
import 'package:po_psy/pages/authorization/login/login.dart';
import 'package:po_psy/constants/UIConstants/ColorPallet.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PoPsy',
      theme: ThemeData(
        primarySwatch: ColorPallet.mainColor,
      ),
      home: LoginPage(),
    );
  }
}

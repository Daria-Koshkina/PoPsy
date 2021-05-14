import 'package:flutter/material.dart';
import 'package:po_psy/models/UserHandler.dart';
import 'package:po_psy/pages/authorization/bootSplash/boot.dart';
import 'package:po_psy/constants/UIConstants/ColorPallet.dart';
import 'package:po_psy/pages/homeScreen/diary/editor.dart';
import 'package:po_psy/models/Record.dart';
import 'package:po_psy/pages/homeScreen/diary/diary.dart';
import 'package:po_psy/pages/homeScreen/homePage.dart';

import 'models/Record.dart';


void main() {
  runApp(MyApp());
}
var now = DateTime.now();
var sixtyDaysFromNow = now.add(const Duration(days: 60));
Record record = Record(sixtyDaysFromNow, "qwertyuiop");
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PoPsy',
      theme: ThemeData(
        primarySwatch: ColorPallet.mainColor,
      ),
      home: BootPage(),
      //home: HomePage(),
    );
  }
}
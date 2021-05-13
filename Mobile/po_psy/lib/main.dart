import 'package:flutter/material.dart';
import 'package:po_psy/pages/authorization/bootSplash/boot.dart';
import 'package:po_psy/constants/UIConstants/ColorPallet.dart';
import 'package:po_psy/pages/homeScreen/diary/TextEditor.dart';
import 'package:po_psy/pages/homeScreen/diary/diary.dart';


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
      home: EditorPage(),
    );
  }
}


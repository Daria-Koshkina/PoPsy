import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:po_psy/blocs/authBlock.dart';
import 'package:po_psy/models/UserHandler.dart';
import 'package:po_psy/pages/authorization/bootSplash/boot.dart';
import 'package:po_psy/constants/UIConstants/ColorPallet.dart';
import 'package:po_psy/pages/homeScreen/diary/editor.dart';
import 'package:po_psy/models/Record.dart';
import 'package:po_psy/pages/homeScreen/diary/diary.dart';
import 'package:po_psy/pages/homeScreen/homePage.dart';
import 'package:provider/provider.dart';

import 'models/Record.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return Provider(
        create: (context) => AuthBlock(),
        child: MaterialApp(
          title: 'PoPsy',
          theme: ThemeData(
            primarySwatch: ColorPallet.mainColor,
          ),
          home: EditorPage(),
        ));
  }
}

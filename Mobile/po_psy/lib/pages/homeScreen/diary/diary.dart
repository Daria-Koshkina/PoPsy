import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:po_psy/api/api.dart';
import 'package:po_psy/constants/UIConstants/ColorPallet.dart';
import 'package:po_psy/constants/UIConstants/TextStyles.dart';
import 'package:po_psy/widgets/LogoElement.dart';
import 'package:po_psy/pages/authorization/registration/registration.dart';
import 'package:po_psy/models/User.dart';
import 'dart:async';


class DiaryPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new _DiaryPageState();
  }
}

class _DiaryPageState extends State<DiaryPage> {
 DateTime x = DateTime.now();
  String _text = "";
  String _audio = "";
 List<String> months = ['January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'];
 List<String> week = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday',
    'Saturday', 'Sunday'];
 List<String> _current = ['14', '16', '18', '20', '22', '24'];
 String _currentSelectedValue = '14';
  final textControler = TextEditingController();
  @override
  void initState() {
    textControler.addListener(_saveText);
    super.initState();
  }
  _saveText(){
    _text = textControler.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPallet.backgroundColor,
      body: Container(
        child: Center(
          child: new ListView(
            children: <Widget>[
              ]
          )
        )
      )
    );
  }
}

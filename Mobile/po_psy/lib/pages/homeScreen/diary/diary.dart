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
              Stack(
                children: <Widget>[
                  Container(
                    height: 15,
                    margin: EdgeInsets.only(left: 20, right: 20),
                    decoration: new BoxDecoration(color: ColorPallet.mainColor,),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: MaterialButton(
                      onPressed: () {
                      //  Navigator.of(context).push(
                     //     MaterialPageRoute(builder: (context) => LoginPage()));
                      },
                      textColor: Colors.white,
                      child: Icon(
                        Icons.arrow_back,
                        size: 30,
                      ),
                    )
                  )
               ]
              )
            ]
          )
        )
      )
    );
  }
}

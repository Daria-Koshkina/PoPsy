import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:po_psy/api/api.dart';
import 'package:po_psy/constants/UIConstants/ColorPallet.dart';
import 'package:po_psy/constants/UIConstants/TextStyles.dart';
import 'package:po_psy/widgets/LogoElement.dart';
import 'package:po_psy/pages/authorization/registration/registration.dart';
import 'package:po_psy/models/User.dart';
import 'dart:async';


class EditorPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new _EditorPageState();
  }
}

class _EditorPageState extends State<EditorPage> {
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
  bool _italic = false;
  bool _underline = false;
  bool _bold = false;
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
                              height: 45,
                              decoration: new BoxDecoration(color: ColorPallet.mainColor,),
                            ),
                            Container(
                                child: MaterialButton(
                                  onPressed: () {
                                    //  Navigator.of(context).push(
                                    //     MaterialPageRoute(builder: (context) => LoginPage()));
                                  },
                                  textColor: Colors.white,
                                  child: Icon(
                                    Icons.arrow_back,
                                    size: 25,
                                  ),
                                )
                            ),
                            Container(
                              alignment: Alignment.topCenter,
                              margin: EdgeInsets.only(top: 15),
                              child: Text(
                                  "${week[x.weekday]}, ${months[x.month]} ${x.day}, ${x.year}",
                                  style: TextStyles.lightHeader2TextStyle
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 15, right: 30),
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                child: Text('Done',
                                    style: TextStyles.lightHeader2TextStyle),
                                onTap: () {
                                  //TO DO-----------------------------------------------
                                },
                              ),
                            )
                          ]
                      ),
                      Container(
                          height: 240.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("assets/image/defolt_diary.jpg")),
                          )
                      ),
                      Container(
                          child: new ConstrainedBox(
                              constraints: BoxConstraints(
                                maxHeight: 350.0,
                              ),
                              child: new Scrollbar(
                                  child: new SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      reverse: true,
                                      child: TextField(
                                        style: TextStyle(color: ColorPallet.mainTextColor,
                                            fontSize: double.tryParse(_currentSelectedValue),
                                            decoration: _underline ? TextDecoration.underline : TextDecoration.none,
                                            fontStyle: _italic ? FontStyle.italic : FontStyle.normal,
                                          fontWeight: _bold ? FontWeight.bold : FontWeight.normal,
                                        ),
                                        maxLines: null,
                                      )
                                  )
                              )
                          )
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children:[
                            Container(
                              width: 50,
                                child: MaterialButton(
                                  onPressed: () {
                                    //  Navigator.of(context).push(
                                    //     MaterialPageRoute(builder: (context) => LoginPage()));
                                  },
                                  textColor: ColorPallet.mainColor,
                                  child: Icon(
                                    Icons.mic,
                                    size: 35,
                                  ),
                                )
                            ),
                            Container(
                                margin: EdgeInsets.only(right: 15),
                              width: 50,
                                child: MaterialButton(
                                  onPressed: () {
                                    //  Navigator.of(context).push(
                                    //     MaterialPageRoute(builder: (context) => LoginPage()));
                                  },
                                  textColor: ColorPallet.mainColor,
                                  child: Icon(
                                    Icons.attach_file,
                                    size: 35,
                                  ),
                                )
                            ),
                          ]
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                                child: IconButton(
                                    iconSize: 50.0,
                                    icon: Image.asset(
                                      "assets/image/underline_letter.png",
                                      color: ColorPallet.mainColor,
                                      fit: BoxFit.fill,),
                                    onPressed: () {
                                      setState(() {
                                        _underline = !_underline;
                                      });
                                    }
                                )
                            ),
                            Container(
                                child: IconButton(
                                    iconSize: 50.0,
                                    icon: Image.asset(
                                      "assets/image/bold_letter.png",
                                      color: ColorPallet.mainColor,
                                      fit: BoxFit.fill,),
                                    onPressed: () {
                                      setState(() {

                                      _bold =  !_bold;
                                       });
                                    }
                                )
                            ),
                            Container(
                                child: IconButton(
                                    iconSize: 50.0,
                                    icon: Image.asset(
                                      "assets/image/italic_letter.png",
                                      color: ColorPallet.mainColor,
                                      fit: BoxFit.fill,),
                                    onPressed: () {
                                      setState(() {
                                        _italic = !_italic;
                                      });
                                    }
                                )
                            ),
                            Container(
                                width: 100,
                                child: FormField<String>(
                                  builder: (FormFieldState<String> state) {
                                    return InputDecorator(
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                                      isEmpty: _current == '14',
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          value: _currentSelectedValue,
                                          isDense: true,
                                          onChanged: (String newValue) {
                                            setState(() {
                                              _currentSelectedValue = newValue;
                                              state.didChange(newValue);
                                            });
                                          },
                                          items: _current.map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    );
                                  },
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

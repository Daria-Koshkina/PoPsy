import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:po_psy/api/api.dart';
import 'package:po_psy/constants/UIConstants/ColorPallet.dart';
import 'package:po_psy/constants/UIConstants/TextStyles.dart';
import 'package:po_psy/models/UserHandler.dart';
import 'package:po_psy/pages/homeScreen/homePage.dart';
import 'package:po_psy/widgets/LogoElement.dart';
import 'package:po_psy/pages/authorization/registration/registration.dart';
import 'package:po_psy/models/User.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';



class LoginPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {

  String _email = "";
  String _pass = "";
  bool _obscureText = true;
  final emailControler = TextEditingController();
  final passwordControler = TextEditingController();
  Future<User> _currentUser = null;
  Text text;

  @override
  void initState() {
    passwordControler.addListener(_savePassword);
    emailControler.addListener(_saveEmail);
    super.initState();
  }

  _savePassword() {
    _pass = passwordControler.text;
  }

  _saveEmail() {
    _email = emailControler.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorPallet.backgroundColor,
        body: Container(
            child: FutureBuilder(
                future: _currentUser,
                builder: (context, snapshot) {
                  return Center(
                      child:
                      new ListView(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              child: LogoElement(),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: 50, left: 20, right: 20),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: ColorPallet.placeholderColor,
                                    blurRadius: 30,
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                controller: emailControler,
                                autofocus: false,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'Email',
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white),
                                      borderRadius: BorderRadius.circular(
                                          32.0)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: ColorPallet.mainColor),
                                      borderRadius: BorderRadius.circular(
                                          32.0)),
                                ),
                                onSaved: (String value) {
                                  _email = value;
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: 20, left: 20, right: 20),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: ColorPallet.placeholderColor,
                                    blurRadius: 30,
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                autofocus: false,
                                controller: passwordControler,
                                obscureText: _obscureText,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'Password',
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white),
                                      borderRadius: BorderRadius.circular(
                                          32.0)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: ColorPallet.mainColor),
                                      borderRadius: BorderRadius.circular(
                                          32.0)),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                    child: Icon(
                                      _obscureText ? Icons.visibility : Icons
                                          .visibility_off,
                                      semanticLabel:
                                      _obscureText
                                          ? 'show password'
                                          : 'hide password',
                                    ),
                                  ),
                                ),
                                onSaved: (String value) {
                                  _pass = value;
                                },
                              ),
                            ),
                            Container(
                              alignment: Alignment.bottomRight,
                              margin: EdgeInsets.only(top: 20, right: 20),
                              child: InkWell(
                                child: Text("Forgot your Password?",
                                    textAlign: TextAlign.right,
                                    style: TextStyles.linkTextStyle
                                ),
                                onTap: () {
                                  text = Text(
                                      "If you entered the correct email, you will recieve an email with a new password",
                                      style: TextStyles.articleTitleTextStyle);
                                  _showDialog(text);
                                  //TO DO-----------------------------------------------------------------------
                                },
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.only(
                                    top: 60, left: 80, right: 80),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        ColorPallet.mainColor,
                                        ColorPallet.lightBlueColor
                                      ]
                                  ),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: TextButton(
                                  child: Text("Sign in",
                                      style: TextStyles.lightHeader2TextStyle),
                                  onPressed: () {
                                    setState(() {
                                      ApiManager().signIn(_email, _pass).then((value){
                                        if (value.statusCode == 200) {
                                          var data = json.decode(value.body);
                                          User user = User.fromJson(data);
                                          UserHandler(user);
                                          SharedPreferences.getInstance().then((prefs) {
                                            prefs.setString('userId', user.ID.toString());
                                          });
                                          Navigator.of(context).push(
                                              MaterialPageRoute(builder: (context) => HomePage()));
                                          print("Success"); //вот тут должно перебрасывать на домашнюю страницу
                                        }
                                        else {
                                          text = Text(
                                              "Please, check the data again",
                                              style: TextStyles
                                                  .articleTitleTextStyle);
                                          _showDialog(text);
                                          print("Error"); //пользователь не найден
                                        }
                                      });
                                    });
                                  },
                                )
                            ),
                            Container(
                              alignment: Alignment.bottomCenter,
                              margin: EdgeInsets.only(
                                  top: 30, left: 80, right: 80),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  IconButton(iconSize: 60.0,
                                      icon: Image.asset(
                                          "assets/image/google-logo.png"),
                                      onPressed: () {
                                        //To Doo------------------------------------------------------------------------
                                      }
                                  ),
                                  IconButton(
                                      iconSize: 60.0,
                                      icon: Image.asset(
                                        "assets/image/facebook-logo.png",
                                        fit: BoxFit.fill,),
                                      onPressed: () {
                                        //To Doo----------------------------------------------------------------------
                                      }
                                  )
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.bottomCenter,
                              margin: EdgeInsets.only(top: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text('Don’t have account? ',
                                      style: TextStyles.linkTextStyle),
                                  InkWell(
                                    child: Text('Create',
                                        style: TextStyles.linkTextStyle2),
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RegistrationPage()));
                                    },
                                  )
                                ],
                              ),
                            )
                          ]
                      )
                  );
                }
            )
        )
    );
  }

  Future<Null> _showDialog(Text x) async {
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            backgroundColor: ColorPallet.backgroundColor,
            title: x,
            contentPadding: EdgeInsets.all(5.0),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Ok",
                    style: TextStyle(fontFamily: 'Roboto',
                        fontSize: 22,
                        fontWeight: FontWeight.w600)),
                onPressed: () async {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

}

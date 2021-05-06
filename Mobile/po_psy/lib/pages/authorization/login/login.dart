import 'package:flutter/material.dart';
import 'package:po_psy/constants/UIConstants/ColorPallet.dart';
import 'package:po_psy/constants/UIConstants/TextStyles.dart';
import 'package:po_psy/widgets/Logo.dart';
import 'package:po_psy/widgets/MainButton.dart';


class LoginPage extends StatelessWidget {

  String _email = "";
  String _pass = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/image/background_login.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child:
            new ListView(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 20),
                  child: Logo(),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 50, left: 50, right: 50),
                  child: new TextFormField(
                    onChanged: (text) {
                      _email = text;
                    },
                    validator: (value){},
                    decoration: new InputDecoration(labelText: "Email"),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 10, left: 50, right: 50),
                  child: new TextFormField(
                    validator: (value){},
                    decoration: new InputDecoration(labelText: "Password"),
                    obscureText: true,
                    onChanged: (text) {
                      _pass = text;
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  margin: EdgeInsets.only(top: 20, right: 50),
                  child: InkWell(
                    child: Text("Forgot your Password?",
                      textAlign: TextAlign.right,
                      style: TextStyles.linkTextStyle
                    ),
                    onTap: () {//TO DO
                    },
                  ),
                ),
                Padding(
                  padding: new EdgeInsets.only(top: 80),
                  child: MyButton(text: 'Sign in'),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(top: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        iconSize: 50.0,
                        icon: Image.asset("assets/image/facebook-logo.png"),
                        onPressed: (){
                          //To Doo
                        }
                      ),
                      IconButton(
                        iconSize: 50.0,
                        icon: Image.asset("assets/image/google-logo.png",fit:BoxFit.fill,),
                        onPressed: (){
                          //To Doo
                        }
                      )
                    ],
                  ),
                  width: 200.0,
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(top: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('Don’t have account? ',
                        style: TextStyles.linkTextStyle),
                      InkWell(
                        child: Text('Create',
                          style: TextStyles.linkTextStyle2),
                        onTap: () {//TO DO
                        },
                      )
                    ],
                  ),
                )
              ]
            )
        ),
      )
    );
  }
}

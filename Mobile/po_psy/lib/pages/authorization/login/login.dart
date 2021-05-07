import 'package:flutter/material.dart';
import 'package:po_psy/constants/UIConstants/ColorPallet.dart';
import 'package:po_psy/constants/UIConstants/TextStyles.dart';
import 'package:po_psy/widgets/LogoElement.dart';
import 'package:po_psy/pages/authorization/registration/registration.dart';


class LoginPage extends StatelessWidget {

  String _email = "";
  String _pass = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPallet.backgroundColor,
    body: Container(
      child: Center(
        child:
          new ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 20),
                child: LogoElement(),
              ),
              Container(
                margin: EdgeInsets.only(top: 80, left: 20, right: 20),
                height: 50,
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
                  autofocus: false,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Email',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                      color: Colors.white),
                      borderRadius: BorderRadius.circular(32.0)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                      color: ColorPallet.mainColor),
                      borderRadius: BorderRadius.circular(32.0)),
                  ),
                  onSaved: (String value) {
                    _email = value;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                height: 50,
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
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Password',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.white),
                        borderRadius: BorderRadius.circular(32.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: ColorPallet.mainColor),
                        borderRadius: BorderRadius.circular(32.0)),
                  ),
                  obscureText: true,
                  onSaved: (String value) {
                    _pass = value;
                  },
                ),
              ),
              Container(
                alignment: Alignment.bottomRight,
                margin: EdgeInsets.only(top: 20, right: 20),
                child: InkWell(
                  child: Text("Forgot your Password?", textAlign: TextAlign.right,
                      style: TextStyles.linkTextStyle
                  ),
                  onTap: () {//TO DO-----------------------------------------------------------------------
                    },
                ),
              ),
              Container(
                height: 50,
                  margin: EdgeInsets.only(top: 60, left: 80, right: 80),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [ColorPallet.mainColor, ColorPallet.lightBlueColor]
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: TextButton(
                    child: Text("Sign in", style: TextStyles.lightHeader2TextStyle),
                    onPressed: (){
                      //TO DO -------------------------------------------------------------------------
                    },
                  )
              ),
              Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(top: 30, left: 80, right: 80),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    IconButton(iconSize: 60.0,
                      icon: Image.asset("assets/image/google-logo.png"),
                      onPressed: (){
                          //To Doo------------------------------------------------------------------------
                      }
                    ),
                    IconButton(
                      iconSize: 60.0,
                      icon: Image.asset("assets/image/facebook-logo.png",fit:BoxFit.fill,),
                      onPressed: (){
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
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegistrationPage()));
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

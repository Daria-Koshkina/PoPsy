import 'package:flutter/material.dart';
import 'package:po_psy/constants/UIConstants/ColorPallet.dart';
import 'package:po_psy/constants/UIConstants/TextStyles.dart';
import 'package:po_psy/pages/authorization/login/login.dart';
import 'package:po_psy/widgets/Logo.dart';
import 'package:po_psy/widgets/MainButton.dart';


class RegistrationPage extends StatelessWidget {

  String _name = "";
  String _email = "";
  String _pass = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPallet.backgroundColor,
      body: Container(
          child: Center(
            child: ListView(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      height: 150,
                      margin: EdgeInsets.only(left: 20, right: 20),
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(35.0),
                          bottomRight: Radius.circular(35.0),
                          topRight: Radius.circular(35.0,),
                          topLeft: Radius.circular(35.0)),
                          color: ColorPallet.mainColor,
                        ),
                      ),
                      Container(
                        height: 100,
                        margin: EdgeInsets.only(left: 20, right: 200, top: 80),
                        decoration: new BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.elliptical(150, 70),
                          ),
                          color: ColorPallet.mainColor,
                        ),
                      ),
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 20),
                          alignment: Alignment.center,
                          width: 180.0,
                          height: 180.0,
                          decoration:  BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: ColorPallet.placeholderColor,
                                blurRadius: 20.0, // soften the shadow
                                spreadRadius: 5.0, //extend the shadow
                                offset: Offset( 0.0, 5.0,),
                              )
                            ],
                            shape: BoxShape.circle, image: DecorationImage(
                              fit: BoxFit.fitHeight,
                              image:  AssetImage("assets/image/defolt_user.jpg")
                            )
                          )
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 130, top: 140),
                        alignment: Alignment.center,
                        decoration:  BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: ColorPallet.mainColor,
                              blurRadius: 1.0, // soften the shadow
                              spreadRadius: 2.0, //exten
                            )
                          ],
                          shape: BoxShape.circle,
                        ),
                        child: MaterialButton(
                          onPressed: () {
                          //ToDoo-------------------------------------------------------------
                          },
                          color: Colors.white,
                          textColor: ColorPallet.mainColor,
                          child: Icon(
                            Icons.add,
                            size: 40,
                          ),
                          padding: EdgeInsets.all(4),
                          shape: CircleBorder(),
                        )
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
                            },
                            textColor: Colors.white,
                            child: Icon(
                              Icons.arrow_back,
                              size: 30,
                            ),
                          )
                        )
                      ]
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30, left: 20, right: 20),
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
                        keyboardType: TextInputType.name,
                        autofocus: false,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'Name',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(32.0)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorPallet.mainColor),
                            borderRadius: BorderRadius.circular(32.0)),
                        ),
                        onSaved: (String value) {
                          _name = value;
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
                        keyboardType: TextInputType.emailAddress,
                        autofocus: false,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'Email',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(32.0)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorPallet.mainColor),
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
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(32.0)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorPallet.mainColor),
                            borderRadius: BorderRadius.circular(32.0)),
                        ),
                        obscureText: true,
                        onSaved: (String value) {
                          _pass = value;
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
                          hintText: 'Repeat password',
                          enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(32.0)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: ColorPallet.mainColor),
                          borderRadius: BorderRadius.circular(32.0)),
                        ),
                      obscureText: true,
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    margin: EdgeInsets.only(top: 20),
                    child: Text("✓ I agree with Privacy Policy",
                      style: TextStyles.articleTextTextStyle
                    ),
                  ),
                  Container(
                    height: 50,
                    margin: EdgeInsets.only(top: 30, left: 80, right: 80),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [ColorPallet.mainColor, ColorPallet.lightBlueColor]
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextButton(
                      child: Text("Create account", style: TextStyles.lightHeader2TextStyle),
                      onPressed: (){
                        //TO DO -------------------------------------------------------------------------
                      },
                    )
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    margin: EdgeInsets.only(top: 40),
                    child: Text("Or create account using social media",
                      style: TextStyles.articleTextTextStyle
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    margin: EdgeInsets.only(top: 10, left: 80, right: 80),
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
              ]
            )
          )
        )
    );
  }
}

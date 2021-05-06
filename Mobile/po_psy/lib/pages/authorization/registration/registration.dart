import 'package:flutter/material.dart';
import 'package:po_psy/constants/UIConstants/ColorPallet.dart';
import 'package:po_psy/constants/UIConstants/TextStyles.dart';
import 'package:po_psy/widgets/Logo.dart';
import 'package:po_psy/widgets/MainButton.dart';


class RegistrationPage extends StatelessWidget {
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
          child: ListView(
            children: <Widget>[
              new Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    width: 150.0,
                    height: 150.0,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 60),
                      decoration:  BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                           color: ColorPallet.placeholderColor,
                           blurRadius: 20.0, // soften the shadow
                           spreadRadius: 5.0, //extend the shadow
                           offset: Offset( 0.0, 5.0,),
                        )
                      ],
                      shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.fitHeight,
                          image:  AssetImage("assets/image/defolt_user.jpg")
                        )
                      )
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 30, left: 50, right: 50),
                      child: new TextFormField(
                        validator: (value){},
                        decoration: new InputDecoration(labelText: "Name"),
                        keyboardType: TextInputType.name,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 10, left: 50, right: 50),
                      child: new TextFormField(
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
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 10, left: 50, right: 50),
                      child: new TextFormField(
                        validator: (value){},
                        decoration: new InputDecoration(labelText: "Repeat password"),
                        obscureText: true,
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      margin: EdgeInsets.only(top: 20),
                      child: InkWell(
                        child: Text("✓ I agree with Privacy Policy",
                            style: TextStyles.articleTextTextStyle
                        ),
                        onTap: () {//TO DO
                        },
                      ),
                    ),
                    Padding(
                      padding: new EdgeInsets.only(top: 20),
                      child: MyButton(text: 'Create account'),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      margin: EdgeInsets.only(top: 50),
                      child: InkWell(
                        child: Text("Or create account using social media",
                          style: TextStyles.articleTextTextStyle
                        ),
                        onTap: () {//TO DO
                        },
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      //margin: EdgeInsets.only(top: 50),
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
                  ]
              )
            ],
          ),
        )
    );
  }
}

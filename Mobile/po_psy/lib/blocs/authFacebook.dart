import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:path/path.dart';
import 'package:po_psy/Services/googleAuthService.dart';
import 'package:po_psy/api/api.dart';
import 'package:po_psy/blocs/passwordGenerator.dart';
import 'package:po_psy/models/User.dart' as myUser;
import 'package:po_psy/models/UserHandler.dart';
import 'package:po_psy/pages/homeScreen/homePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthFacebook{
  final authService = AuthService();
  final fb = FacebookLogin();

  Stream<User> get currentUser => authService.currentUser;

  loginFacebook(context) async{
    print('Starting Facebook login');
    final res = await fb.logIn(
      permissions: [
        FacebookPermission.publicProfile,
        FacebookPermission.email
      ]
    );
    switch(res.status){
      case FacebookLoginStatus.success:
        print("login success");

        final FacebookAccessToken fbToken = res.accessToken;

        final AuthCredential credential = FacebookAuthProvider.credential(fbToken.token);

        final result = await authService.signInWithCredential(credential);
        String email = result.user.email;
        final responce = await ApiManager().getUserByEmail(email);
        if (responce.statusCode == 200){
          var data = json.decode(responce.body);
          myUser.User user = myUser.User.fromJson(data);
          UserHandler(user);
          SharedPreferences.getInstance().then((prefs) {
            prefs.setString('userId', user.ID.toString());
          });
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => HomePage()));
        }
        else{
          final displayedName = result.user.displayName.split(' ');
          String name = displayedName[0];
          String surname = displayedName[1];
          myUser.User newUser = new myUser.User(0, name, surname, result.user.photoURL, email, result.user.phoneNumber, null, generatePassword(true, true, true, true, 17), null);
          ApiManager().register(newUser).then((value) {
            if (value.statusCode == 200) {
              var data = json.decode(value.body);
              newUser.ID = data;
              UserHandler(newUser);
              SharedPreferences.getInstance().then((prefs) {
                prefs.setString('userId', newUser.ID.toString());
              });
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => HomePage()));
            }
          });
        }
        print('${result.user.displayName}');
        break;
      case FacebookLoginStatus.cancel:
        print("login canceled");
        break;
      case FacebookLoginStatus.error:
        print("login error");
        break;
    }
  }
}
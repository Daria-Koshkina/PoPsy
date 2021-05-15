import 'dart:convert';
//import 'dart:js';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:po_psy/Services/googleAuthService.dart';
import 'package:po_psy/api/api.dart';
import 'package:po_psy/blocs/passwordGenerator.dart';
import 'package:po_psy/models/User.dart' as myUser;
import 'package:po_psy/models/UserHandler.dart';
import 'package:po_psy/pages/homeScreen/homePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBlock{
  final authService = AuthService();
  final googleSignIn = GoogleSignIn(scopes: ['email','profile']);

  Stream<User> get currentUser => authService.currentUser;
  loginGoogle(context) async{
    try{
      final GoogleSignInAccount googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken
      );
      //Firebase SignIn
      final result = await authService.signInWithCredentioal(credential);
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

    }
    catch(e){
      print(e);
    }


    logout() {
      authService.logout();
    }
  }

}
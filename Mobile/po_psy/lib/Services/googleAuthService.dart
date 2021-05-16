import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final _auth = FirebaseAuth.instance;

  Future<UserCredential> signInWithCredentioal(AuthCredential credential) => _auth.signInWithCredential(credential);
  Future<void> logout() => _auth.signOut();
  Stream<User> get currentUser => _auth.authStateChanges();
}
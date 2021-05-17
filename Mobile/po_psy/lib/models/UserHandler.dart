import 'package:po_psy/models/User.dart';
import 'package:po_psy/models/testsModels/TestSessions.dart';

class UserHandler {
  User _user;

  static final UserHandler instance = UserHandler._internal();
  UserHandler._internal() {}

  factory UserHandler(User user) {
    instance._user = user;
    return instance;
  }

  int getUserId() {
    return _user.ID;
  }

  User getUser() {
    return _user;
  }

  void setUser(User user) {
    _user = null;
    _user = user;
  }

  void resetUser(){
    _user = null;
  }
}
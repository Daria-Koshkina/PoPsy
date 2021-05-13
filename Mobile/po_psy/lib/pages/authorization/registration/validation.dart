class FormValidator {
  static FormValidator _instance;

  factory FormValidator() => _instance ??= new FormValidator._();

  FormValidator._();

  String password = '';

  String validatePassword(String value) {
    password = value;
    String patttern = r'(^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{6,}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.isEmpty) {
      return "Password is Required";
    } else if (value.length < 8) {
      return "Password must minimum eight characters";
    } else if (!regExp.hasMatch(value)) {
      return "Password at least one uppercase letter, one lowercase letter and one number";
    }
    return null;
  }

  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.isEmpty) {
      return "Email is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Invalid Email";
    } else {
      return null;
    }
  }

  String validateName(String value) {
    if (value.isEmpty) {
      return "Name is Required";
    } else if (value.length < 4) {
      return "Name must minimum tree characters";
    }
    return null;
  }

  String validatePhone(String value) {
    if (value.isEmpty) {
      return null;
    } else if (value.length == 10) {
      return null;
    }
    return "Incorect phone";
  }

  String validateAge(String value) {
    if (value.isEmpty) {
      return null;
    }var numValue = int.tryParse(value);
    if(numValue > 5 && numValue < 100) {
      return null;
    }
    return "Incorect age";
  }
}
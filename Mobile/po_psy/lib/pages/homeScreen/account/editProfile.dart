import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:po_psy/constants/UIConstants/ColorPallet.dart';
import 'package:po_psy/constants/UIConstants/TextStyles.dart';
import 'package:po_psy/models/User.dart';
import 'package:po_psy/models/UserHandler.dart';
import 'package:po_psy/pages/homeScreen/account/profile.dart';
import 'package:image_picker/image_picker.dart';


class EditAccountPage extends StatefulWidget{
  final User user = UserHandler.instance.getUser();
  @override
  State<StatefulWidget> createState() => _MyFirstAppState();
}

class _MyFirstAppState extends State<EditAccountPage> {
  User _user;
  final _picker = ImagePicker();
  File _image;
  String _name;
  String _surname;
  String _imageURL;
  String _email;
  String _phone;
  int _age;
  String _password;
  String _oldPassword;
  String _repeatedPassword;
  @override
  void initState() {
    super.initState();
    _user = widget.user;
    _imageURL = widget.user.imageURL;
    _name = widget.user.name;
    _surname = widget.user.surname;
    _email = widget.user.email;
    _phone = widget.user.phone;
    _age = widget.user.age;
    _password = widget.user.password;
    _oldPassword = '';
    _repeatedPassword = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ColorPallet.placeholderColor,
        appBar: _appBar(_user, context),
        body: _editprofilePage(_user, _image)
    );
  }


  Widget _appBar(User user, BuildContext context) {
    return AppBar(
      backgroundColor: ColorPallet.backgroundColor,
      actions: [
        TextButton(
          onPressed: () {
            var newUser = new User(
                UserHandler.instance.getUserId(),
                _name,
                _surname,
                _imageURL,
                _email,
                _phone,
                _age,
                _password,
                []
            );
            bool emailValid = newUser.email.isValidEmail();
            bool fieldsAreValid = !newUser.name.isEmpty && newUser.age != null && emailValid;
            if (fieldsAreValid) {
              UserHandler.instance.setUser(newUser);
              Navigator.pop(context);
            }
            //Navigator.pop(context);
          },
          child: Text('Save changes',
              style: TextStyles.greenHeaderTextStyle
          ),
        ),
        Spacer(),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel',
            style: TextStyles.headerTextStyle,
          ),
        ),
      ],
    );
  }

  Widget _editprofilePage(User user, File _image) {
    return SafeArea(
        child: ListView(
          children: [
            _avatar(null, _image),
            _changeAvatarButton(),
            _editUserData(user),
            SizedBox(height: 7,
              child: Container(
                color: ColorPallet.subsidiaryTextColor,
              ),
            ),
            _editPassword(user),
          ],
        )
    );
  }

  Widget _avatar(String imageURL, File _image) {
    if (imageURL == null) {
      return new Container(
        padding: const EdgeInsets.only(top: 7.0, bottom: 7.0),
        color: ColorPallet.mainColor,
        width: double.infinity,
        child: CircleAvatar(
          backgroundColor: ColorPallet.placeholderColor,
          radius: 70,
          child: Icon(Icons.person,
            size: 50,
            color: ColorPallet.lightGreyColor,
          ),
        ),
      );
    } else {
      return new Container(
        padding: const EdgeInsets.only(top: 7.0, bottom: 7.0),
        color: ColorPallet.mainColor,
        width: double.infinity,
        /*child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(imageURL),
      ),*/
        child: CircleAvatar(
          radius: 70,
          backgroundColor: ColorPallet.lightGreyColor,
          backgroundImage: NetworkImage(imageURL),
        ),
      );
    }
  }

  Widget _changeAvatarButton() {
    return Container(
      color: ColorPallet.mainColor,
      width: double.infinity,
      child: TextButton(
        onPressed: () {}, //getImage,
        child: Text(
            'Change photo',
            style: TextStyles.lightHeader2TextStyle
        ),
      ),
    );
  }

  Widget _editUserData(User user) {
    return Column(
      children: [
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter name';
            }
            return null;
          },
          initialValue: user.name,
          keyboardType: TextInputType.name,
          onChanged: (newText) {
            _name = newText;
          },
          cursorColor: ColorPallet.mainColor,
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(left: 10),
              hintText: 'Name',
              hintStyle: TextStyles.greyHeader2TextStyle
          ),

        ),
        _line(),
        TextFormField(
          initialValue: user.surname != null ? user.surname : "",
          keyboardType: TextInputType.text,
          onChanged: (newText) {
            _surname = newText;
          },
          cursorColor: ColorPallet.mainColor,
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(left: 10),
              hintText: 'Surname',
              hintStyle: TextStyles.greyHeader2TextStyle
          ),
        ),
        _line(),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter age';
            }
            return null;
          },
          initialValue: user.age.toString(),
          maxLength: 3,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            WhitelistingTextInputFormatter.digitsOnly
          ],
          onChanged: (newText) {
            _age = int.parse(newText);
          },
          cursorColor: ColorPallet.mainColor,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: const EdgeInsets.only(left: 10),
            hintText: 'Age',
            hintStyle: TextStyles.greyHeader2TextStyle,
            counterText: '',
            counterStyle: TextStyle(fontSize: 0),
          ),
        ),
        _line(),
        TextFormField(
          initialValue: user.phone != null ? user.phone.toString() : "",
          maxLength: 10,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            WhitelistingTextInputFormatter.digitsOnly
          ],
          onChanged: (newText) {
            _age = int.parse(newText);
          },
          cursorColor: ColorPallet.mainColor,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: const EdgeInsets.only(left: 10),
            hintText: 'Phone number',
            hintStyle: TextStyles.greyHeader2TextStyle,
            counterText: '',
            counterStyle: TextStyle(fontSize: 0),
          ),
        ),
        _line(),
        TextFormField(
          initialValue: user.email != null ? user.email : '',
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (input) =>
          input.isValidEmail()
              ? null
              : "Check your email",
          maxLength: 30,
          onChanged: (newText) {
            _email = newText;
          },
          keyboardType: TextInputType.emailAddress,
          cursorColor: ColorPallet.mainColor,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: const EdgeInsets.only(left: 10),
            hintText: 'Email',
            hintStyle: TextStyles.greyHeader2TextStyle,
            counterText: '',
            counterStyle: TextStyle(fontSize: 0),
          ),
        ),
      ],
    );
  }

  Widget _editPassword(User user) {
    return Column(
      children: [
        TextField(
          onChanged: (newText) {
            _password = newText;
          },
          cursorColor: ColorPallet.mainColor,
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(left: 10),
              hintText: 'New password',
              hintStyle: TextStyles.greyHeader2TextStyle
          ),
        ),
        _line(),
        TextField(
          onChanged: (newText) {
            _repeatedPassword = newText;
          },
          cursorColor: ColorPallet.mainColor,
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(left: 10),
              hintText: 'Repead password',
              hintStyle: TextStyles.greyHeader2TextStyle
          ),
        ),
        _line(),
        TextField(
          onChanged: (newText) {
            _oldPassword = newText;
          },
          cursorColor: ColorPallet.mainColor,
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(left: 10),
              hintText: 'Old password',
              hintStyle: TextStyles.greyHeader2TextStyle
          ),
        ),
      ],
    );
  }

  bool _validatePasswords() {
    if (!_repeatedPassword.isEmpty && _repeatedPassword == _password) {
      if (_oldPassword == _user.password) {
        return true;
      }
    }
    return false;
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

Widget _line(){
  return const Divider(
    height: 0,
    thickness: 1,
    indent: 10,
    endIndent: 10,
  );
}

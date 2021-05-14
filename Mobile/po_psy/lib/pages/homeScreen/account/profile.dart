import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:po_psy/constants/UIConstants/ColorPallet.dart';
import 'package:po_psy/constants/UIConstants/TextStyles.dart';
import 'package:po_psy/models/User.dart';
import 'package:po_psy/models/UserHandler.dart';
import 'package:po_psy/pages/homeScreen/account/editProfile.dart';


class AccountPage extends StatelessWidget {
  final User user = UserHandler.instance.getUser();

  AccountPage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPallet.placeholderColor,
        body:  _profilePage(user,context)
    );
  }
}


Widget _profilePage(User user,BuildContext context) {
  return ListView(
    children: <Widget>[
      _editIcon(user,context),
      _avatar(user.imageURL),
      SizedBox(
        height: 22,
        child: Container(
          color: ColorPallet.mainColor,
        ),
      ),
      _usernameTitle(user.name),
      _line(),
      _userSurnameTitle(user.surname),
      _line(),
      _usersAge(user.age),
      _line(),
      _phoneNumber(user.phone),
      _line(),
      _useremail(user.email),
      SizedBox(height: 7,),
      _profileButtons(),
      SizedBox(
        height: 31,
        child: Center(
          child: Text(
            'PoPsy for Android v0.0.1',
            style: TextStyles.lightSubHeaderTextStyle,
          ),
        ),
      ),
    ],
  );
}


Widget _editIcon(User user,BuildContext context){
  return Container(
    height: 27,
    alignment: Alignment.topRight,
    color: ColorPallet.mainColor,
    width: double.infinity,
    child: IconButton(
      icon: Icon(
        Icons.account_balance_outlined,
        color: Colors.white,
      ),
      onPressed: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EditAccountPage()),
        );
      },
    ),
  );
}

Widget _avatar(String imageURL) {
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
      child: CircleAvatar(
        radius: 70,
        backgroundColor: ColorPallet.lightGreyColor,
        backgroundImage: NetworkImage(imageURL),
      ),
    );
  }
}




Widget _usernameTitle(String name) {
  return ListTile(
    tileColor: ColorPallet.backgroundColor,
    title: Text(
      name,
      style: TextStyles.header2TextStyle,
    ),
  );
}

Widget _userSurnameTitle(String surname) {
  if(surname == null){
    return ListTile(
      tileColor: ColorPallet.backgroundColor,
      title: Text(
        'Surname',
        style: TextStyles.greyHeader2TextStyle,
      ),
    );
  } else {
    return ListTile(
      tileColor: ColorPallet.backgroundColor,
      title: Text(
        surname,
        style: TextStyles.header2TextStyle,
      ),
    );
  }
}

Widget _usersAge(int age) {
  if(age == null){
    return ListTile(
      tileColor: ColorPallet.backgroundColor,
      title: Text(
        'Age',
        style: TextStyles.greyHeader2TextStyle,
      ),
    );
  } else {
    return ListTile(
      tileColor: ColorPallet.backgroundColor,
      title: Text(
        '$age y.o.',
        style: TextStyles.header2TextStyle,
      ),
    );
  }
}

Widget _phoneNumber(String phone) {
  if(phone == null){
    return ListTile(
      tileColor: ColorPallet.backgroundColor,
      title: Text(
        'Phone number',
        style: TextStyles.greyHeader2TextStyle,
      ),
    );
  } else {
    return ListTile(
      tileColor: ColorPallet.backgroundColor,
      title: Text(
        phone,
        style: TextStyles.header2TextStyle,
      ),
    );
  }
}

Widget _useremail(String email) {
  if(email == null || email == ''){
    return ListTile(
      tileColor: ColorPallet.backgroundColor,
      title: Text(
        'Email',
        style: TextStyles.greyHeader2TextStyle,
      ),
    );
  } else {
    return ListTile(
      tileColor: ColorPallet.backgroundColor,
      title: Text(
        email,
        style: TextStyles.header2TextStyle,
      ),
    );
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

Widget _profileButtons() {
  return Container(
    color: ColorPallet.backgroundColor,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton.icon(
          onPressed: () {},
          label: Text(
            'Setting',
            style: TextStyles.header2TextStyle,
          ),
          icon: Icon(
            Icons.settings_outlined,
            color: ColorPallet.mainColor,
            size: 19,
          ),
        ),
        _line(),

        TextButton.icon(
          onPressed: () {},
          label: Text(
            'FAQ',
            style: TextStyles.header2TextStyle,
          ),
          icon: Icon(
            Icons.lightbulb_outline,
            color: ColorPallet.mainColor,
            size: 19,
          ),
        ),
        _line(),

        TextButton.icon(
          onPressed: () {},

          label: Text(
            'Contact us',
            style: TextStyles.header2TextStyle,
          ),
          icon: Icon(
            Icons.comment_outlined,
            color: ColorPallet.mainColor,
            size: 19,
          ),
        ),
        _line(),

        TextButton.icon(
          onPressed: () {},
          label: Text(
            'Private policy',
            style: TextStyles.header2TextStyle,
          ),
          icon: Icon(
            Icons.verified_user_outlined,
            color: ColorPallet.mainColor,
            size: 19,
          ),
        ),
        _line(),

        TextButton.icon(
          label: Text(
            'Log out',
            style: TextStyles.header2TextStyle,
          ),
          icon: Icon(
            Icons.logout,
            color: ColorPallet.redBlockColor,
            size: 19,
          ),
          onPressed: () {},
        ),
      ],
    ),
  );
}



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:po_psy/api/api.dart';
import 'package:po_psy/constants/UIConstants/ColorPallet.dart';
import 'package:po_psy/constants/UIConstants/TextStyles.dart';
import 'package:po_psy/models/GalaryItem.dart';
import 'package:po_psy/models/User.dart';
import 'package:po_psy/models/UserHandler.dart';
import 'dart:io' show File, Platform;
import 'package:path/path.dart' as path;
import 'package:po_psy/widgets/CustomDialog.dart';
import 'package:uuid/uuid.dart';



class EditAccountPage extends StatefulWidget{
  final User user = UserHandler.instance.getUser();
  @override
  State<StatefulWidget> createState() => _MyFirstAppState();
}

enum PhotoSource { FILE, NETWORK }

class _MyFirstAppState extends State<EditAccountPage> {
  User _user;
  String _name;
  String _surname;
  String _imageURL;
  String _email;
  String _phone;
  int _age;
  String _password;
  String _oldPassword;
  String _repeatedPassword;

  File _photo = null;
  //String _photoUrl = '';
  String _photoExtension = null;
  PhotoSource _photoSource = null;
  GalleryItem _galleryItem = null;

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
    _password = '';
    _oldPassword = '';
    _repeatedPassword = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ColorPallet.placeholderColor,
        appBar: _appBar(_user, context),
        body: _editprofilePage()
    );
  }


  Widget _appBar(User user, BuildContext context) {
    return AppBar(
      backgroundColor: ColorPallet.backgroundColor,
      automaticallyImplyLeading: false,
      actions: [
        TextButton(
          onPressed: () {
            if (_photo != null) {
              setState(() {
                ApiManager()
                    .uploadImage(context, _photoExtension, _photo)
                    .then((value) {
                  if (value != null){
                    _imageURL = value;
                    bool passwordsAreValid = _validatePasswords();
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
                    if (fieldsAreValid && passwordsAreValid) {
                      ApiManager().updateUser(newUser).then((value){
                        if (value.statusCode == 200){
                          UserHandler.instance.setUser(newUser);
                        }
                      });
                      print('Success');
                      Navigator.pop(context);
                    }
                  }
                });
              });
            }
            else{
            bool passwordsAreValid = _validatePasswords();
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
            if (fieldsAreValid && passwordsAreValid) {
              ApiManager().updateUser(newUser).then((value){
                if (value.statusCode == 200){
                  UserHandler.instance.setUser(newUser);
                }
              });
              print('Success');
              Navigator.pop(context);
            }
            //Navigator.pop(context);
          }},
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

  Widget _editprofilePage() {
    return SafeArea(
        child: ListView(
          children: [
            Container(
                color: ColorPallet.mainColor,
                width: double.infinity,
                child: Column(
                    children: [
                      _avatar(_imageURL),
                      _changeAvatarButton(),
                    ]
                )
            ),
            _editUserData(_user),
            SizedBox(height: 7,
              child: Container(
                color: ColorPallet.subsidiaryTextColor,
              ),
            ),
            _editPassword(_user),
          ],
        )
    );
  }

  Widget _avatar(String imageURL) {
    // if (imageURL == null) {
    //   return new Container(
    //     padding: const EdgeInsets.only(top: 7.0, bottom: 7.0),
    //     color: ColorPallet.mainColor,
    //     width: double.infinity,
    //     child: CircleAvatar(
    //       backgroundColor: ColorPallet.placeholderColor,
    //       radius: 70,
    //       child: Icon(Icons.person,
    //         size: 50,
    //         color: ColorPallet.lightGreyColor,
    //       ),
    //     ),
    //   );
    // } else {
    //   return new Container(
    //     padding: const EdgeInsets.only(top: 7.0, bottom: 7.0),
    //     color: ColorPallet.mainColor,
    //     width: double.infinity,
    //     /*child: ClipRRect(
    //     borderRadius: BorderRadius.circular(20),
    //     child: Image.network(imageURL),
    //   ),*/
    //     child: CircleAvatar(
    //       radius: 70,
    //       backgroundColor: ColorPallet.lightGreyColor,
    //       backgroundImage: NetworkImage(imageURL),
    //     ),
    //   );
    // }
    return Center(
      child: InkWell(
        child: Container(
          margin: EdgeInsets.all(5),
          height: 180,
          width: 180,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ColorPallet.placeholderColor,
          ),
          child: _getImage(),
        ),
      ),
    );
  }

  Widget _changeAvatarButton() {
    return TextButton(
      onPressed: () {
        _onAddPhotoClicked(context);
      }, //getImage,
      child: Text(
          'Change photo',
          style: TextStyles.lightHeader2TextStyle
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
          initialValue: user.age != null ? user.age.toString() : "",
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
    if (_repeatedPassword == '' && _oldPassword == '' && _password == '') {
        _password = _user.password;
      return true;
    }
    else if (!_repeatedPassword.isEmpty && _repeatedPassword == _password) {
      if (_oldPassword == _user.password) {
        return true;
      }
    }
    _showDialog(Text('Please check password and try again'));
    return false;
  }

  Widget _getImage() {
    if (_photoSource == PhotoSource.FILE) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image.file(_photo, fit: BoxFit.fill),
      );
    } else {
      // return ClipRRect(
      //     borderRadius: BorderRadius.circular(100),
      //     child: Image.asset(
      //       _photoUrl,
      //       fit: BoxFit.fill,
      //     ));
      return new Container(
        padding: const EdgeInsets.only(top: 7.0, bottom: 7.0),
        child: CircleAvatar(
          backgroundColor: ColorPallet.placeholderColor,
          radius: 70,
          child: Icon(Icons.person,
            size: 50,
            color: ColorPallet.lightGreyColor,
          ),
        ),
      );
    }
  }

  _onAddPhotoClicked(context) async {
    Permission permission;

    if (Platform.isIOS) {
      permission = Permission.photos;
    } else {
      permission = Permission.storage;
    }

    PermissionStatus permissionStatus = await permission.status;

    print(permissionStatus);

    if (permissionStatus == PermissionStatus.restricted) {
      _showOpenAppSettingsDialog(context);

      permissionStatus = await permission.status;

      if (permissionStatus != PermissionStatus.granted) {
        //Only continue if permission granted
        return;
      }
    }

    if (permissionStatus == PermissionStatus.permanentlyDenied) {
      _showOpenAppSettingsDialog(context);

      permissionStatus = await permission.status;

      if (permissionStatus != PermissionStatus.granted) {
        //Only continue if permission granted
        return;
      }
    }

    if (permissionStatus == PermissionStatus.denied) {
      if (Platform.isIOS) {
        _showOpenAppSettingsDialog(context);
      } else {
        permissionStatus = await permission.request();
      }

      if (permissionStatus != PermissionStatus.granted) {
        //Only continue if permission granted
        return;
      }
    }

    if (permissionStatus == PermissionStatus.granted) {
      print('Permission granted');
      File image = await ImagePicker.pickImage(
        source: ImageSource.gallery,
      );

      if (image != null) {
        String fileExtension = path.extension(image.path);

        _galleryItem = GalleryItem(
          id: Uuid().v1(),
          resource: image.path,
          isSvg: fileExtension.toLowerCase() == ".svg",
        );

        setState(() {
          _photo = image;
          _photoSource = PhotoSource.FILE;
          _photoExtension = fileExtension;
        });
      }
    }
  }

  Future<Null> _showDialog(Text x) async {
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            backgroundColor: ColorPallet.backgroundColor,
            title: x,
            contentPadding: EdgeInsets.all(5.0),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Ok",
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 22,
                        fontWeight: FontWeight.w600)),
                onPressed: () async {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
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

_showOpenAppSettingsDialog(context) {
  return CustomDialog.show(
    context,
    'Permission needed',
    'Photos permission is needed to select photos',
    'Open settings',
    openAppSettings,
  );
}

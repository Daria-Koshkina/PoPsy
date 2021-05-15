import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:po_psy/api/GenerateImageUrl.dart';
import 'package:po_psy/api/UploadFile.dart';
import 'package:po_psy/constants/UIConstants/ColorPallet.dart';
import 'package:po_psy/constants/UIConstants/TextStyles.dart';
import 'package:po_psy/models/UserHandler.dart';
import 'package:po_psy/models/GalaryItem.dart';
import 'package:po_psy/pages/authorization/login/login.dart';
import 'package:po_psy/pages/homeScreen/homePage.dart';
import 'package:po_psy/pages/homeScreen/recommendations/recommendationsPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:po_psy/widgets/CustomDialog.dart';
import 'package:uuid/uuid.dart';
import 'RegistrationRequestData.dart';
import 'validation.dart';
import 'package:po_psy/models/User.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:po_psy/api/api.dart';
import 'dart:io' show File, Platform;
import 'package:path/path.dart' as path;

class RegistrationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _RegistrationPageState();
  }
}

bool _obscureText1 = true;
bool _obscureText2 = true;

enum PhotoSource { FILE, NETWORK }

class _RegistrationPageState extends State<RegistrationPage> {
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  RegistrationRequestData _registrationData = RegistrationRequestData();
  final passwordControler = TextEditingController();
  String _pass = '';

  File _photo = null;
  String _photoUrl = "assets/image/defolt_user.jpg";
  String _photoExtension = null;
  PhotoSource _photoSource = null;
  GalleryItem _galleryItem = null;

  void initState() {
    passwordControler.addListener(_savePassword);
    super.initState();
  }

  _savePassword() {
    _pass = passwordControler.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorPallet.backgroundColor,
        body: Container(
            child: Center(
                child: ListView(children: <Widget>[
          Stack(children: <Widget>[
            Container(
              height: 150,
              margin: EdgeInsets.only(left: 20, right: 20),
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(35.0),
                    bottomRight: Radius.circular(35.0),
                    topRight: Radius.circular(
                      35.0,
                    ),
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
              child: InkWell(
                child: Container(
                  margin: EdgeInsets.all(5),
                  height: 180,
                  width: 180,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: ColorPallet.placeholderColor,
                        blurRadius: 20.0, // soften the shadow
                        spreadRadius: 5.0, //extend the shadow
                        offset: Offset(
                          0.0,
                          5.0,
                        ),
                      )
                    ],
                    shape: BoxShape.circle,
                    color: ColorPallet.placeholderColor,
                  ),
                  child: _getImage(),
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.only(left: 130, top: 140),
                alignment: Alignment.center,
                decoration: BoxDecoration(
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
                    _onAddPhotoClicked(context);
                  },
                  color: Colors.white,
                  textColor: ColorPallet.mainColor,
                  child: Icon(
                    Icons.add,
                    size: 40,
                  ),
                  padding: EdgeInsets.all(4),
                  shape: CircleBorder(),
                )),
            Container(
                margin: EdgeInsets.only(left: 10),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  textColor: Colors.white,
                  child: Icon(
                    Icons.arrow_back,
                    size: 30,
                  ),
                ))
          ]),
          new Form(
            key: _key,
            autovalidate: _validate,
            child: _getFormUI(),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.only(top: 20),
            child: Text("Or create account using social media",
                style: TextStyles.articleTextTextStyle),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.only(top: 10, left: 80, right: 80),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                    iconSize: 60.0,
                    icon: Image.asset("assets/image/google-logo.png"),
                    onPressed: () {
                      //To Doo------------------------------------------------------------------------
                    }),
                IconButton(
                    iconSize: 60.0,
                    icon: Image.asset(
                      "assets/image/facebook-logo.png",
                      fit: BoxFit.fill,
                    ),
                    onPressed: () {
                      //To Doo----------------------------------------------------------------------
                    })
              ],
            ),
          ),
        ]))));
  }

  Widget _getFormUI() {
    return new Column(children: <Widget>[
      Container(
        margin: EdgeInsets.only(top: 20, left: 20, right: 20),
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
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(32.0)),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(32.0)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(32.0)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ColorPallet.mainColor),
                borderRadius: BorderRadius.circular(32.0)),
          ),
          validator: FormValidator().validateName,
          onSaved: (String value) {
            _registrationData.name = value;
          },
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 20, left: 20, right: 20),
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
            hintText: 'Surname',
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(32.0)),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(32.0)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(32.0)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ColorPallet.mainColor),
                borderRadius: BorderRadius.circular(32.0)),
          ),
          validator: FormValidator().validateSurname,
          onSaved: (String value) {
            _registrationData.surname = value;
          },
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 20, left: 20, right: 20),
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
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(32.0)),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(32.0)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(32.0)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ColorPallet.mainColor),
                borderRadius: BorderRadius.circular(32.0)),
          ),
          validator: FormValidator().validateEmail,
          onSaved: (String value) {
            _registrationData.email = value;
          },
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 20, left: 20, right: 20),
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
            obscureText: _obscureText1,
            controller: passwordControler,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: 'Password',
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(32.0)),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(32.0)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(32.0)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorPallet.mainColor),
                  borderRadius: BorderRadius.circular(32.0)),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText1 = !_obscureText1;
                  });
                },
                child: Icon(
                  _obscureText1 ? Icons.visibility : Icons.visibility_off,
                  semanticLabel:
                      _obscureText1 ? 'show password' : 'hide password',
                ),
              ),
            ),
            validator: FormValidator().validatePassword,
            onSaved: (String value) {
              setState(() {
                _registrationData.password = value;
              });
            }),
      ),
      Container(
        margin: EdgeInsets.only(top: 20, left: 20, right: 20),
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
            obscureText: _obscureText2,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: 'Repeat password',
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(32.0)),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(32.0)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(32.0)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorPallet.mainColor),
                  borderRadius: BorderRadius.circular(32.0)),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText2 = !_obscureText2;
                  });
                },
                child: Icon(
                  _obscureText2 ? Icons.visibility : Icons.visibility_off,
                  semanticLabel:
                      _obscureText2 ? 'show password' : 'hide password',
                ),
              ),
            ),
            validator: (value) {
              print(value);
              print(_pass);
              print(identical(_pass, value));
              if (value.isEmpty) {
                return "Reapeted password is Required";
              } else if (0 != _pass.compareTo(value)) {
                return "Paswords must be the same";
              }
              return null;
            }),
      ),
      Container(
        margin: EdgeInsets.only(top: 20, left: 20, right: 20),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: ColorPallet.placeholderColor,
              blurRadius: 30,
            ),
          ],
        ),
        child: TextFormField(
          keyboardType: TextInputType.phone,
          autofocus: false,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: 'Phone',
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(32.0)),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(32.0)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(32.0)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ColorPallet.mainColor),
                borderRadius: BorderRadius.circular(32.0)),
          ),
          validator: FormValidator().validatePhone,
          onSaved: (String value) {
            _registrationData.phone = value;
          },
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 20, left: 20, right: 20),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: ColorPallet.placeholderColor,
              blurRadius: 30,
            ),
          ],
        ),
        child: TextFormField(
          keyboardType: TextInputType.number,
          autofocus: false,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: 'Age',
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(32.0)),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(32.0)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(32.0)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ColorPallet.mainColor),
                borderRadius: BorderRadius.circular(32.0)),
          ),
          validator: FormValidator().validateAge,
          onSaved: (String value) {
            _registrationData.age = int.tryParse(value);
          },
        ),
      ),
      Container(
        alignment: Alignment.bottomCenter,
        margin: EdgeInsets.only(top: 10),
        child: Text("✓ I agree with Privacy Policy",
            style: TextStyles.articleTextTextStyle),
      ),
      Container(
          height: 50,
          margin: EdgeInsets.only(top: 20, left: 80, right: 80),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [ColorPallet.mainColor, ColorPallet.lightBlueColor]),
            borderRadius: BorderRadius.circular(25),
          ),
          child: TextButton(
            child:
                Text("Create account", style: TextStyles.lightHeader2TextStyle),
            onPressed: () {
              if (_key.currentState.validate()) {
                if (_photo != null) {
                  setState(() {
                    ApiManager()
                        .uploadImage(context, _photoExtension, _photo)
                        .then((value) {
                          if (value != null){
                            _photoUrl = value;
                            register();
                          }
                        });
                  });
                }
                else{
                  register();
                }
              } else {
                setState(() {
                  _validate = true;
                });
              }
            },
          )),
    ]);
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

    if (permissionStatus == PermissionStatus.undetermined) {
      permissionStatus = await permission.request();

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

  register(){
    _key.currentState.save();
    User newUser = User(
        0,
        _registrationData.name,
        _registrationData.surname,
        _photoUrl,
        _registrationData.email,
        _registrationData.phone,
        _registrationData.age,
        _registrationData.password,
        []);
    ApiManager().register(newUser).then((value) {
      if (value.statusCode == 200) {
        var data = json.decode(value.body);
        newUser.ID = data;
        UserHandler(newUser);
        SharedPreferences.getInstance().then((prefs) {
          prefs.setString('userId', newUser.ID.toString());
        });
        Text x = Text("You successfully registered",
            style: TextStyles.articleTitleTextStyle);
        _showDialog(x);
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        Text x = Text(
            "You are not registered. Check all fields again",
            style: TextStyles.articleTitleTextStyle);
        _showDialog(x);
      }
    });
  }

  Widget _getImage() {
    if (_photoSource == PhotoSource.FILE) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image.file(_photo, fit: BoxFit.fill),
      );
    } else {
      return ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.asset(
            _photoUrl,
            fit: BoxFit.fill,
          ));
    }
  }
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

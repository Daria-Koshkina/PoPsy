import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:po_psy/assets/my_icons_icons.dart';
import 'package:po_psy/constants/UIConstants/ColorPallet.dart';
import 'package:po_psy/constants/UIConstants/TextStyles.dart';


class SettingsPage extends StatefulWidget {

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isSwitched = true;

  List<String> current = ['English', 'Ukrainian'];
  String currentSelectedValue = 'English';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorPallet.lightGreyColor,
        body:  ListView(
          children: <Widget>[
        Stack(
        children: <Widget>[
          Container(
          height: 45,
          decoration: new BoxDecoration(color: ColorPallet.mainColor,),
        ),
        Container(
            child: MaterialButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              textColor: Colors.white,
              child: Icon(
                Icons.arrow_back,
                size: 25,
              ),
            )
        ),
        Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.only(top: 15),
          child: Text(
              "Settings",
              style: TextStyles.lightHeader2TextStyle
          ),
        ),
        ]
    ),
            Container(
                margin: EdgeInsets.only(top: 15, left: 20, bottom: 5),
                child: Text("Account",
                    style: TextStyles.articleAuthorTextStyle)
            ),
            _line(),
            _premium(),
            _line(),
            Container(
                margin: EdgeInsets.only(top: 15, left: 20, bottom: 5),
                child: Text("Main",
                    style: TextStyles.articleAuthorTextStyle)
            ),
            _line(),
            ListTile(
              tileColor: ColorPallet.backgroundColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Language", style: TextStyles.header2TextStyle,),
                  Container(
                    width: 110,
                    child: FormField<String>(
                      builder: (FormFieldState<String> state) {
                       return InputDecorator(
                         decoration: InputDecoration(border: InputBorder.none,),
                         isEmpty: current == 'English',
                         child: DropdownButtonHideUnderline(
                           child: DropdownButton<String>(
                             value: currentSelectedValue,
                             isDense: true,
                             onChanged: (String newValue) {
                               setState(() {
                                 currentSelectedValue = newValue;
                                 state.didChange(newValue);
                               });
                             },
                             items: current.map((String value) {
                               return DropdownMenuItem<String>(
                                 value: value,
                                 child: Text(value,
                                 style: TextStyles.articleTextTextStyle,
                                 ),
                               );
                             }).toList(),
                         ),
                       ),
                    );
                  }
                  )
                 )
                ]
              ),
           ),
            _line(),
            ListTile(
              tileColor: ColorPallet.backgroundColor,
              title: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
               Text("Get notifications",
                style: TextStyles.header2TextStyle,
               ),
               Switch(
                value: isSwitched,
                onChanged: (value) {
                  setState(() {
                   isSwitched = value;
                   print(isSwitched);
                  });
                 },
                 activeTrackColor: ColorPallet.mainColor,
                 activeColor: Colors.white,
                 ),
               ]
              ),
            ),
            _line(),
            _sound(),
            _line()
          ],
        )
    );
  }
}

Widget _premium() {
  return ListTile(
    tileColor: ColorPallet.backgroundColor,
    title: InkWell(
        child: Text("Premium",
          style: TextStyles.header2TextStyle,
        ),
      onTap: (){

      }
    ),
  );
}

Widget _sound() {
  return ListTile(
    tileColor: ColorPallet.backgroundColor,
    title: InkWell(
        child: Text("Sound",
          style: TextStyles.header2TextStyle,
        ),
        onTap: (){

        }
    ),
  );
}

Widget _line(){
  return const Divider(
    height: 0,
    thickness: 1,
    indent: 10,
    endIndent: 10,
  );
}




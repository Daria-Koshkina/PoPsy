import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:po_psy/assets/my_icons_icons.dart';
import 'package:po_psy/constants/UIConstants/ColorPallet.dart';
import 'package:po_psy/constants/UIConstants/TextStyles.dart';
import 'package:po_psy/models/consultationsModels/Psychologist.dart';

class PsychologistPage extends StatelessWidget {
  final Psychologist _psychologist;

  const PsychologistPage(this._psychologist);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                "Psychologist", style: TextStyles.lightHeaderTextStyle,),
            ),
          body: Container(
            width: double.infinity,
              height: double.infinity,
              color: ColorPallet.backgroundColor,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.all(5),
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorPallet.placeholderColor,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(_psychologist.imageURL, fit: BoxFit.fill),
                          ),
                        ),
                      ),
                      SizedBox(height: 15,),
                      Text(_psychologist.name, style: TextStyles.headerTextStyle,),
                      SizedBox(height: 5,),
                      Text(_psychologist.age.toString() + ' y.o.', style: TextStyles.headerTextStyle,),
                      SizedBox(height: 15,),
                      Text(_psychologist.prof, style: TextStyles.header2TextStyle,),
                      SizedBox(height: 20,),
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.email, color: ColorPallet.mainColor,),
                            SizedBox(width: 7,),
                            Text(_psychologist.email, style: TextStyles.header2TextStyle,)
                          ]
                      ),
                      SizedBox(height: 20,),
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(MyIcons.telegram, color: ColorPallet.mainColor,),
                            SizedBox(width: 7,),
                            Text(_psychologist.telegram, style: TextStyles.header2TextStyle,)
                          ]
                      ),
                      SizedBox(height: 20,),
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.blue.shade600,
                              child: IconButton(
                                icon: Icon(
                                  MyIcons.video2,
                                  color: Colors.white,
                                ),
                                onPressed: () {},
                              ),
                            ),
                            SizedBox(width: 7,),
                            Text('Send your Zoom data', style: TextStyles.header2TextStyle,)
                          ]
                      )
                    ],
                  ),
                ),
              )
          ),
        )
    );
  }

}
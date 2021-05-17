import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:po_psy/assets/my_icons_icons.dart';
import 'package:po_psy/constants/UIConstants/ColorPallet.dart';
import 'package:po_psy/constants/UIConstants/TextStyles.dart';
import 'package:po_psy/models/Record.dart';
import 'package:share/share.dart';

import 'editor.dart';

class DayWidget extends StatelessWidget {
  final Record record;

  DayWidget({this.record});

  @override
  Widget build(BuildContext context) {
    return new Stack(
        children: [
          Container(
            height: 60,
            margin: EdgeInsets.only(right: 15, left: 40),
            decoration: new BoxDecoration(
              color: ColorPallet.darkGreenColor,
              borderRadius:
              BorderRadius.only(bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                  topRight: Radius.circular(20.0,),
                  topLeft: Radius.circular(20.0)),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: 30, left: 80),
             padding: EdgeInsets.symmetric(horizontal: 15),
             child: InkWell(
              child: Text(
                record.type,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                style: TextStyles.lightHeader2TextStyle,
              ),
            onTap: (){
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => EditorPage(record: record)));
            }
    )
          ),
         Container(
             height: 60.0,
             margin: EdgeInsets.only(right: 270),
             decoration: BoxDecoration(
               shape: BoxShape.circle,
               image: DecorationImage(
                   fit: BoxFit.fitHeight,
                   image: AssetImage("assets/image/defolt_diary.jpg")),
             )
         )
        ]
    );
  }
}
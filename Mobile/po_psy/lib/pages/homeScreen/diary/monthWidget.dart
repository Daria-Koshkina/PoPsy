import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:po_psy/assets/my_icons_icons.dart';
import 'package:po_psy/constants/UIConstants/ColorPallet.dart';
import 'package:po_psy/constants/UIConstants/TextStyles.dart';
import 'package:po_psy/models/Record.dart';
import 'package:share/share.dart';

class MonthWidget extends StatelessWidget {
  final DateTime date;
  final int number;

  MonthWidget({this.date, this.number});

  @override
  Widget build(BuildContext context) {
    return new Stack(
       children: [
         Container(
           height: 44,
           width: 44,
           decoration: new BoxDecoration(
             color: ColorPallet.darkGreenColor,
             borderRadius:
             BorderRadius.only(bottomLeft: Radius.circular(10.0),
                 bottomRight: Radius.circular(10.0),
                 topRight: Radius.circular(10.0,),
                 topLeft: Radius.circular(10.0)),
           ),
         ),
         Container(
           margin: EdgeInsets.only(top: 12, left: 12),
           child: Text(
             date.day.toString(),
             textAlign: TextAlign.center,
             style: TextStyles.lightHeader2TextStyle,
           )
         ),
         number == null ? Container()  : _getCircle(),
         number == null ? Container()  : _getNumber(number),
       ]
    );
  }
  Widget _getCircle() {
      return Container(
        margin: EdgeInsets.only(left: 35, top: 1),
        height: 10,
        width: 10,
        decoration : new BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      );
     }
  Widget _getNumber(int num) {
    return Container(
        margin: EdgeInsets.only(left: 36.5),
        child: Text(
          num.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: ColorPallet.darkGreenColor,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        )
    );
  }
}
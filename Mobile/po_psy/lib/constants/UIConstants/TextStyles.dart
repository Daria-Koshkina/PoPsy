import 'package:flutter/material.dart';
import 'package:po_psy/constants/UIConstants/ColorPallet.dart';

class TextStyles {
  static TextStyle headerTextStyle = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: ColorPallet.mainTextColor,
  );

  static TextStyle lightHeaderTextStyle = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static TextStyle header2TextStyle = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: ColorPallet.mainTextColor,
  );

  static TextStyle lightHeader2TextStyle = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static TextStyle lightSubHeaderTextStyle = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static TextStyle subHeaderTextStyle = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: ColorPallet.mainTextColor,
  );

  static TextStyle lightCommonTextStyle = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: Colors.white,
  );

  static TextStyle commonTextStyle = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: ColorPallet.mainTextColor,
  );
}
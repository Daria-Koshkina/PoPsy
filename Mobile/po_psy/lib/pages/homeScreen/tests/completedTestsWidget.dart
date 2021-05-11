import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:po_psy/constants/UIConstants/ColorPallet.dart';
import 'package:po_psy/constants/UIConstants/TextStyles.dart';
import 'package:po_psy/models/testsModels/Test.dart';

class CompletedTestsWidget extends StatefulWidget {
  final List<Test> tests;
  CompletedTestsWidget({this.tests});

  CompletedTestsWidgetState createState() => CompletedTestsWidgetState();
}

class CompletedTestsWidgetState extends State<CompletedTestsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
          color: ColorPallet.backgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ]
      ),
      child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: widget.tests.map<Widget>((Test test) {
                  return Padding(padding: EdgeInsets.symmetric(vertical: 5),
                      child: _completedTestWidget(test: test)
                  );
                }).toList(),
              )
          )
      ),
    );
  }
}

class _completedTestWidget extends StatelessWidget {
  final Test test;

  _completedTestWidget({this.test});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorPallet.placeholderColor,
        borderRadius: BorderRadius.circular(20),
      ),
      height: 45,
      child: Row(
        children: [
          SizedBox(width: 10,),
          Text(
            test.title,
            style: TextStyles.lightCommonTextStyle,
          ),
          Spacer(),
          Text(
            _getDateString(test.date),
            style: TextStyles.songTitleTextStyle,
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward, color: Colors.white,),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

String _getDateString(DateTime date) {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formatted = formatter.format(date);
  return formatted;
}
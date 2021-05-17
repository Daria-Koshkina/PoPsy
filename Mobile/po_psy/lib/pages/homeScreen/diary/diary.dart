import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:po_psy/api/api.dart';
import 'package:po_psy/constants/UIConstants/ColorPallet.dart';
import 'package:po_psy/constants/UIConstants/TextStyles.dart';
import 'package:po_psy/models/Record.dart';
import 'package:po_psy/models/UserHandler.dart';
import 'package:po_psy/pages/homeScreen/diary/dayWidget.dart';
import 'package:po_psy/widgets/LogoElement.dart';

import 'editor.dart';

class DiaryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _DiaryPageState();
  }
}

List<String> months = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'
];
var now = DateTime.now();
var sixtyDaysFromNow = now.add(const Duration(days: 60));
var fiftyDaysFromNow = now.add(const Duration(days: 50));

// List<Record> records = [Record(sixtyDaysFromNow, "qqqqqqqqwertyuiopqqqqqqqqwertyuiopqqqqqqqqwertyuiop"), Record(now, "qwertyuioddddddpnow"),
//   Record(sixtyDaysFromNow, "qwwwwwertyuiop"), Record(sixtyDaysFromNow, "qwwwwwertyuiop"),
//   Record(fiftyDaysFromNow, "qwwwwwertyuioppppppppppppp"), Record(fiftyDaysFromNow, "qeeeeeewwwwwertyuiop")];

class _DiaryPageState extends State<DiaryPage> {
  Future<List<Record>> records;

  @override
  initState() {
    records =
        ApiManager().prepareDiary(UserHandler.instance.getUserId().toString());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: records,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
                backgroundColor: ColorPallet.backgroundColor,
                body: Container(
                    child: Center(
                        child: new Stack(children: <Widget>[
                  ListView(children: <Widget>[
                    _sort(snapshot.data),
                    for (var i = 0;
                        i < snapshot.data.length;
                        i += _number(snapshot.data, i))
                      _oneDay(snapshot.data, i, _number(snapshot.data, i)),
                  ]),
                  Container(
                      alignment: Alignment.bottomRight,
                      margin: EdgeInsets.only(right: 15, bottom: 50),
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => EditorPage()));
                        },
                        color: Colors.white,
                        textColor: ColorPallet.mainColor,
                        child: Icon(
                          Icons.add,
                          size: 40,
                        ),
                        padding: EdgeInsets.all(4),
                        shape: CircleBorder(),
                      ))
                ]))));
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  Widget _sort(List<Record> records) {
    records.sort((a, b) => a.Date.compareTo(b.Date));
    return Container();
  }

  int _number(List<Record> recs, int i) {
    int n = 0;
    int j = i;
    for (int j = i; j < recs.length; j++) {
      if (recs[j].isSameDate(recs[i]))
        n++;
      else
        return n;
    }

    return n;
  }

  Widget _oneDay(List<Record> recs, int i, int n) {
    return Container(
        height: n * 100.0,
        margin: EdgeInsets.only(top: 30, right: 20, left: 20),
        decoration: new BoxDecoration(
          color: ColorPallet.mainColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
              topRight: Radius.circular(
                20.0,
              ),
              topLeft: Radius.circular(20.0)),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                  alignment: Alignment.topRight,
                  margin: EdgeInsets.only(right: 20),
                  child: Text(
                    "${recs[i].Date.day} ${months[recs[i].Date.month]}",
                    style: TextStyles.lightHeader2TextStyle,
                  )),
              for (int k = 0; k < n; k++) DayWidget(record: recs[i + k])
            ]));
  }
}

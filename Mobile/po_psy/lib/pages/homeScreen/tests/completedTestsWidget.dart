import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:po_psy/api/api.dart';
import 'package:po_psy/constants/UIConstants/ColorPallet.dart';
import 'package:po_psy/constants/UIConstants/TextStyles.dart';
import 'package:po_psy/models/UserHandler.dart';
import 'package:po_psy/models/testsModels/Test.dart';
import 'package:po_psy/models/testsModels/TestSessions.dart';
import 'package:po_psy/pages/homeScreen/tests/startTestPage.dart';

class CompletedTestsWidget extends StatefulWidget {
  final List<Test> tests;
  // final List<TestSessions> sessions;

  CompletedTestsWidget({this.tests});

  CompletedTestsWidgetState createState() => CompletedTestsWidgetState();
}

class CompletedTestsWidgetState extends State<CompletedTestsWidget> {
  Future<List<TestSessions>> sessions;

  @override
  void initState() {
    sessions = ApiManager().prepareSession(UserHandler.instance.getUserId().toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Container(
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
                        return Padding(padding: EdgeInsets.symmetric(
                            vertical: 5),
                            child: _completedTestWidget(
                              test: test, session: _getTestSessions(
                                snapshot.data, test),)
                        );
                      }).toList(),
                    )
                )
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      }
    );
  }
}

class _completedTestWidget extends StatelessWidget {
  final Test test;
  final TestSessions session;

  _completedTestWidget({this.test, this.session});

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
            _getDateString(session.results[session.results.length - 1].date),
            style: TextStyles.songTitleTextStyle,
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward, color: Colors.white,),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                  new StartTestPage(test, session))
              );
            },
          ),
        ],
      ),
    );
  }
}

TestSessions _getTestSessions(List<TestSessions> sessions, Test test) {
  for (int i = 0; i < sessions.length; i++) {
    if (sessions[i].testId == test.id) {
      return sessions[i];
    }
  }
  return new TestSessions(test.id, []);
}

String _getDateString(DateTime date) {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formatted = formatter.format(date);
  return formatted;
}
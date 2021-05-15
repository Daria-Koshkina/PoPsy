import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:po_psy/constants/UIConstants/ColorPallet.dart';
import 'package:po_psy/constants/UIConstants/TextStyles.dart';
import 'package:po_psy/models/testsModels/Category.dart';
import 'package:po_psy/models/testsModels/Test.dart';
import 'package:po_psy/models/testsModels/TestHandler.dart';
import 'package:po_psy/models/testsModels/TestSessions.dart';
import 'package:po_psy/models/testsModels/TestStep.dart';
import 'package:po_psy/models/testsModels/data.dart';
import 'package:po_psy/pages/homeScreen/tests/categoryWidget.dart';
import 'package:po_psy/pages/homeScreen/tests/testIcon.dart';

import 'completedTestsWidget.dart';

class TestsPage extends StatefulWidget {
  final List<Category> categories = TestData().getCategories();
  final List<Test> tests = TestData().getTests();
  final List<Test> completed = TestData().getCompletedTest();
  final List<TestSessions> sessions = TestData().getSessions();
  //final List<TestSessions> sessions = [];

  TestsPageState createState() => TestsPageState();
}

class TestsPageState extends State<TestsPage> {
  List<Category> categories;
  List<Test> tests;
  List<Test> completed;
  CompletedTestsWidget bottomSheetWidget;

  @override
  void initState() {
    categories = widget.categories;
    tests = widget.tests;
    completed = widget.completed;
    bottomSheetWidget = new CompletedTestsWidget(tests: completed, sessions: widget.sessions,);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Scaffold(
            body: Container(
              color: ColorPallet.backgroundColor,
              child: ListView(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: _categoriesWidget(categories)
                  ),
                  _testsWidget(tests, widget.sessions),
                ],
              ),
            ),
          bottomSheet: _getBottomSheetWidget(),
        )
    );
  }

  CompletedTestsWidget _getBottomSheetWidget() {
    setState(() {
      if (bottomSheetWidget == null) {
        bottomSheetWidget = new CompletedTestsWidget(
          tests: completed,
          sessions: widget.sessions,
        );
      }
    });
    return bottomSheetWidget;
  }
}

Widget _categoriesWidget(List<Category> categories) {
  return Container(
      height: 100,
      child:
      GridView.count(
        physics: new NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        childAspectRatio: (90 / 25),
        padding: const EdgeInsets.all(4.0),
        mainAxisSpacing: 6.0,
        crossAxisSpacing: 6.0,
        children: categories.map((Category category) {
          return GridTile(
              child: CategoryWidget(category: category, isEditing: true,)
          );
        }).toList(),
      )
  );
}

Widget _testsWidget(List<Test> tests, List<TestSessions> sessions) {
  return Column(
    children: tests.map<Widget>((Test test) {
    return Padding(
        padding: new EdgeInsets.symmetric(vertical: 6, horizontal: 20),
        child: TestIconWidget(test, _getTestSessions(sessions, test))
    );
    }).toList()
  );
}

TestSessions _getTestSessions(List<TestSessions> sessions, Test test) {
  for (int i = 0; i < sessions.length; i++) {
    if (sessions[i].testId == test.id) {
      return sessions[i];
    }
  }
  return new TestSessions(test.id, []);
}


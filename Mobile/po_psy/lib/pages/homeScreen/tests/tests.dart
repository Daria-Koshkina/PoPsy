import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:po_psy/api/api.dart';
import 'package:po_psy/constants/UIConstants/ColorPallet.dart';
import 'package:po_psy/constants/UIConstants/TextStyles.dart';
import 'package:po_psy/models/UserHandler.dart';
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
  // final List<Category> categories = TestData().getCategories();
  // final List<Test> tests = TestData().getTests();
  // final List<Test> completed = TestData().getCompletedTest();
  //final Future<List<TestSessions>> sessions = ApiManager().prepareSession(UserHandler.instance.getUserId().toString());
  //List<TestSessions> sessions = [];
  List<Category> chosenCategories = [];

  @override
  TestsPageState createState() => TestsPageState();
}

class TestsPageState extends State<TestsPage> {
  // List<Category> categories;
  // List<Test> tests;
  // List<Test> completed;
  Widget bottomSheetWidget;
  Future<List<Category>> categories;
  Future<List<Test>> tests;
  Future<List<Test>> completed;
  Future<List<TestSessions>> sessions;
  List<Category> chosenCategories;

  @override
  void initState() {
    // ApiManager().getCategories().then((value) {
    //   categories = value;
    // });
    // ApiManager().allTests().then((value) {
    //   tests = value;
    // });
    // ApiManager().usedTests(UserHandler.instance.getUserId().toString()).then((value) {
    //   completed = value;
    // });
    // ApiManager().prepareSession(UserHandler.instance.getUserId().toString()).then((value) {
    //   widget.sessions = value;
    //   bottomSheetWidget = new CompletedTestsWidget(tests: completed, sessions: value,);
    // });
    //chosenCategories = [];
    categories = ApiManager().getCategories();
    tests = ApiManager().allTests(widget.chosenCategories);
    completed =
        ApiManager().usedTests(UserHandler.instance.getUserId().toString());
    sessions = ApiManager()
        .prepareSession(UserHandler.instance.getUserId().toString());
    //bottomSheetWidget = new CompletedTestsWidget(tests: completed, sessions: sessions,);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: tests,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
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
                            child: _categoriesWidget(categories, widget.chosenCategories)),
                        _testsWidget(snapshot.data, sessions),
                      ],
                    ),
                  ),
                  bottomSheet: _getBottomSheetWidget(completed),
                ));
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  Widget _categoriesWidget(Future<List<Category>> categories, List<Category> chosenCategories) {
    return FutureBuilder(
        future: categories,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
                height: 100,
                child: GridView.count(
                  physics: new NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  childAspectRatio: (90 / 25),
                  padding: const EdgeInsets.all(4.0),
                  mainAxisSpacing: 6.0,
                  crossAxisSpacing: 6.0,
                  children: snapshot.data.map<Widget>((Category category) {
                    return GridTile(
                        child: CategoryWidget(
                            category: category,
                            isEditing: true,
                            chosenCategories: chosenCategories,
                            changeCategories: (List<Category> categories) {
                              setState(() {
                                print(categories.length);
                                chosenCategories = categories;
                                tests = ApiManager().allTests(chosenCategories);
                                //ApiManager().filteredTests(chosenCategories);
                              });
                            }
                        ));
                  }).toList(),
                ));
          } else {
            return CircularProgressIndicator();
          }
        }
    );
  }


  Widget _getBottomSheetWidget(Future<List<Test>> completed) {
    // setState(() {
    //   if (bottomSheetWidget == null) {
    //     if (completed.isEmpty) {
    //       bottomSheetWidget = new Container(width: 0, height: 0,);
    //     } else {
    //       bottomSheetWidget = new CompletedTestsWidget(
    //         tests: completed,
    //         sessions: widget.sessions,
    //       );
    //     }
    //   }
    // });
    // return bottomSheetWidget;
    return FutureBuilder(
        future: completed,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return new CompletedTestsWidget(
              tests: snapshot.data,
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}



Widget _testsWidget(List<Test> tests, Future<List<TestSessions>> sessions) {
  return FutureBuilder(
      future: sessions,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
              children: tests.map<Widget>((Test test) {
            return Padding(
                padding: new EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                child: TestIconWidget(
                    test, _getTestSessions(snapshot.data, test)));
          }).toList());
        } else {
          return CircularProgressIndicator();
        }
      }
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

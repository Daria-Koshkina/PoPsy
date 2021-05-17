import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:po_psy/constants/UIConstants/ColorPallet.dart';
import 'package:po_psy/constants/UIConstants/TextStyles.dart';
import 'package:po_psy/models/testsModels/Category.dart';
import 'package:po_psy/models/testsModels/Test.dart';
import 'package:po_psy/models/testsModels/TestHandler.dart';
import 'package:po_psy/models/testsModels/TestResult.dart';
import 'package:po_psy/models/testsModels/TestSessions.dart';
import 'package:po_psy/pages/homeScreen/homePage.dart';
import 'package:po_psy/pages/homeScreen/tests/TestResultPage.dart';
import 'package:po_psy/pages/homeScreen/tests/TestStepPage.dart';
import 'package:po_psy/pages/homeScreen/tests/categoryWidget.dart';
import 'package:po_psy/pages/homeScreen/tests/tests.dart';

class StartTestPage extends StatefulWidget {
  final Test test;
  final TestSessions _testSessions;
  StartTestPage(this.test, this._testSessions);

  StartTestPageState createState() => StartTestPageState();
}

class StartTestPageState extends State<StartTestPage> {

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: ColorPallet.mainColor,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: SafeArea(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.test.title,
                  style: TextStyles.lightHeaderTextStyle,
                ),
                SizedBox(height: 15,),
                _categoriesWidget(widget.test.categories),
                SizedBox(
                    width: 300,
                    height: 125,
                    child: Image.network(
                      widget.test.imageURL,
                      fit: BoxFit.fitWidth,
                    )
                ),
                SizedBox(height: 15,),
                Text(
                  widget.test.description,
                  style: TextStyles.lightCommonTextStyle,
                ),
                Spacer(),
                Text(
                  'You will have to answer ${widget.test.steps.length} questions :)',
                  style: TextStyles.lightCommonTextStyle,
                ),
                SizedBox(height: 30,),
                _sessionsWidget(),
                SizedBox(height: 30,),
                Row(
                  children: [
                    SizedBox(
                        height: 36,
                        width: 92,
                        child: TextButton.icon(
                          label: Text(
                            'Back',
                            style: TextStyles.backButtonTextStyle,),
                          icon: Icon(
                            Icons.arrow_back,
                            color: ColorPallet.redBlockColor,
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: ColorPallet.backgroundColor,
                          ),
                          onPressed: () {
                            Navigator.of(context).popUntil((route) => route.isFirst);
                          },
                        )
                    ),
                    Spacer(),
                    SizedBox(
                        height: 50,
                        width: 164,
                        child: TextButton.icon(
                          icon: Icon(
                            Icons.arrow_forward,
                            color: ColorPallet.mainColor,
                          ),
                          label: _getButtonText(),
                          style: TextButton.styleFrom(
                            backgroundColor: ColorPallet
                                .backgroundColor,
                          ),
                          onPressed: (){
                            _startTest(context, widget.test, widget._testSessions);
                          },
                        )
                    ),
                  ],
                ),
                SizedBox(height: 30,),
              ],
            )
        ),
      ),
    );
  }

  Widget _getButtonText() {
    if (widget._testSessions.results.isEmpty) {
      return Text(
        'I`m ready!',
        style: TextStyles.backStartTextStyle,);
    } else {
      return Text(
        'Retake',
        style: TextStyles.backStartTextStyle,);
    }
  }

  Widget _sessionsWidget() {
    if (widget._testSessions.results == null) {
      return Container(width: 0, height: 0,);
    } else {
      return Flexible(child: SingleChildScrollView(
          child: Column(
            children: widget._testSessions.results.map((TestResult testResult) {
              return _session(testResult);
            }).toList(),
          )
      )
      );
    }
  }

  Widget _session(TestResult res) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15)
      ),
      padding: EdgeInsets.all(5),
      height: 45,
      child: Row(
        children: [
          Text(
            _getDateString(res.date),
            style: TextStyles.songTitleTextStyle,
          ),
          Spacer(),
          Text(
            'See more details',
            style: TextStyles.songTitleTextStyle,
          ),
          IconButton(
              icon: Icon(Icons.arrow_forward, color: ColorPallet.placeholderColor,),
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>
                    new TestResultPage(res))
                );
              })
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
              child: CategoryWidget(category: category, isEditing: false,)
          );
        }).toList(),
      )
  );
}

void _startTest(BuildContext context, Test test, TestSessions testSessions) {
  var testHandler = TestHandler(test);
  var testStep = testHandler.getNext();
  if (testStep != null) {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
        new TestStepPage(testStep, testSessions))
    );
  }
}
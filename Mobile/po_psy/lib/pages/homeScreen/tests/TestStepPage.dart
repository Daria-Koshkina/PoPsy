import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:po_psy/api/api.dart';
import 'package:po_psy/constants/UIConstants/ColorPallet.dart';
import 'package:po_psy/constants/UIConstants/TextStyles.dart';
import 'package:po_psy/models/UserHandler.dart';
import 'package:po_psy/models/testsModels/TestHandler.dart';
import 'package:po_psy/models/testsModels/TestResult.dart';
import 'package:po_psy/models/testsModels/TestSessions.dart';
import 'package:po_psy/models/testsModels/TestStep.dart';
import 'package:po_psy/pages/homeScreen/tests/TestResultPage.dart';
import 'package:po_psy/pages/homeScreen/tests/startTestPage.dart';

class TestStepPage extends StatefulWidget {
  final TestStep _testStep;
  final TestSessions _testSessions;
  const TestStepPage(this._testStep, this._testSessions);

  TestStepPageState createState() => TestStepPageState();
}

class TestStepPageState extends State<TestStepPage> {
  List<String> _checked = [];
  Answer currentAnswer = null;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorPallet.mainColor,
      child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 5,),
                  Text(
                    'Question ${TestHandler.instance
                        .getIndex()} of ${TestHandler.instance.test
                        .steps.length}',
                    style: TextStyles.lightHeader2TextStyle,
                  ),
                  Text(
                    ' | ',
                    style: TextStyles.lightHeader2TextStyle,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                          new StartTestPage(
                              TestHandler.instance.test, widget._testSessions))
                      );
                    },
                    child: Text(
                      'Restart the test',
                      style: TextStyles.restartTestButtonTextStyle,
                    ),
                  )
                ],
              ),
              SizedBox(height: 15,),
              Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    widget._testStep.question.text,
                    style: TextStyles.lightHeader2TextStyle,
                  )
              ),
              _getImage(widget._testStep.imageURL),
              Material(
                color: ColorPallet.mainColor,
                child: CheckboxGroup(
                  labels: _getAnswersTitles(widget._testStep.answers),
                  activeColor: ColorPallet.mainColor,
                  checked: _checked,
                  itemBuilder: (Checkbox cb, Text txt, int i) {
                    return Column(
                      children: <Widget>[
                        _checkBoxWidget(cb, txt)
                      ],
                    );
                  },
                  onChange: (bool isChecked, String label, int index) {
                    currentAnswer = widget._testStep.answers[index];
                    print(currentAnswer.text);
                  },
                  onSelected: (List selected) =>
                      setState(() {
                        if (selected.length > 1) {
                          selected.removeAt(0);
                          print('selected length  ${selected.length}');
                        } else {
                          print("only one");
                        }
                        _checked = selected;
                      }),
                ),
              ),
              Spacer(),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                    children: [
                      SizedBox(
                          height: 35,
                          width: 90,
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
                              //Navigator.pop(context);
                              _previousStep(widget._testStep, context,
                                  widget._testSessions);
                            },
                          )
                      ),
                      Spacer(),
                      SizedBox(
                          height: 35,
                          width: 90,
                          child: TextButton.icon(
                            icon: Icon(
                              Icons.arrow_forward,
                              color: ColorPallet.mainColor,
                            ),
                            label: Text(
                              'Next',
                              style: TextStyles.backStartTextStyle,),
                            style: TextButton.styleFrom(
                              backgroundColor: ColorPallet
                                  .backgroundColor,
                            ),
                            onPressed: () {
                              _nextStep(currentAnswer);
                            },
                          )
                      ),
                    ],
                  )
              ),
            ],
          )
      ),
    );
  }

  void _nextStep(Answer answer) {
    if (answer == null) {
      final String title = 'Invalid input';
      final String text = 'You have to choose one of answers';
      _showAlertDialog(context, title, text);
      return;
    }
    TestHandler.instance.setScore(answer);
    var step = TestHandler.instance.getNext();
    if (step != null) {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>
          new TestStepPage(step, widget._testSessions))
      );
    } else {
      TestResult result = TestHandler.instance.getResult();
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>
          new TestResultPage(result))
      );
      ApiManager().postTestResult(
          widget._testSessions.testId.toString(),
          result,
          UserHandler.instance.getUserId().toString());
      setState(() {
        widget._testSessions.results.add(result);
      });
      //ApiManager().postTestSessions(widget._testSessions, UserHandler.instance.getUserId().toString());
      print(widget._testSessions.results);
    }
  }
}

Widget _getImage(String imageURL) {
  if (imageURL.isEmpty) {
    return Container(
      width: 0,
      height: 0,
    );
  } else {
    return Padding(padding: EdgeInsets.symmetric(vertical: 30),
        child: SizedBox(
            width: 195,
            height: 105,
            child: Image.network(
              imageURL,
              fit: BoxFit.fitWidth,
            )
        )
    );
  }
}

void _previousStep(TestStep testStep, BuildContext context, TestSessions testSessions) {
  var step = TestHandler.instance.getPrevious();
  if (step != null) {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
        new TestStepPage(step, testSessions))
    );
  } else {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
        new StartTestPage(TestHandler.instance.test, testSessions))
    );
    //TestHandler.instance.reset();
    return;
  }
}

List<String> _getAnswersTitles(List<Answer> answers) {
  var titles = <String>[];
  for (int i = 0; i < answers.length; i++) {
    titles.add(answers[i].text);
  }
  return titles;
}

Widget _checkBoxWidget(Checkbox cb, Text txt) {
  return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: ColorPallet.backgroundColor,
      ),
      child: Row(
        children: [
          cb,
          txt
        ],
      )
  );
}

_showAlertDialog(BuildContext context, String title, String text) {
  // Create button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(text),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:po_psy/constants/UIConstants/ColorPallet.dart';
import 'package:po_psy/constants/UIConstants/TextStyles.dart';
import 'package:po_psy/models/testsModels/TestHandler.dart';
import 'package:po_psy/models/testsModels/TestStep.dart';
import 'package:po_psy/pages/homeScreen/tests/answersWidget.dart';
import 'package:po_psy/pages/homeScreen/tests/startTestPage.dart';

class TestStepPage extends StatelessWidget {
  final TestHandler _testHandler;
  final TestStep _testStep;

  const TestStepPage(this._testHandler, this._testStep);

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
                    'Question ${_testHandler.getIndex()} of ${_testHandler.test
                        .steps.length}',
                    style: TextStyles.lightHeader2TextStyle,
                  ),
                  Text(
                    ' | ',
                    style: TextStyles.lightHeader2TextStyle,
                  ),
                  TextButton(
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                            new StartTestPage(test: _testHandler.test,))
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
              Text(
                _testStep.question.text,
                style: TextStyles.lightHeader2TextStyle,
              ),
              _getImage(_testStep.imageURL),
              AnswersWidget(_testStep.answers),
            ],
          )
      ),
    );
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
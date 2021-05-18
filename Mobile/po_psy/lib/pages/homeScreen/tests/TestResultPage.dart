import 'package:flutter/material.dart';
import 'package:po_psy/constants/UIConstants/ColorPallet.dart';
import 'package:po_psy/constants/UIConstants/TextStyles.dart';
import 'package:po_psy/models/testsModels/TestResult.dart';

class TestResultPage extends StatefulWidget {
  final TestResult _testResult;

  const TestResultPage(this._testResult);

  TestResultPageState createState() => TestResultPageState();
}

class TestResultPageState extends State<TestResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorPallet.mainColor,
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
            child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 50, horizontal: 20),
                        child: Text(
                          widget._testResult.result,
                          style: TextStyles.testResultTextStyle,
                        )
                    ),
                    SizedBox(
                        width: 300,
                        height: 250,
                        child: Image.network(
                          widget._testResult.imageURL,
                          fit: BoxFit.fitWidth,
                        )
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      width: 227,
                      height: 52,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).popUntil((route) =>
                          route.isFirst);
                        },
                        child: Text(
                          'Other tests',
                          style: TextStyles.backStartTextStyle,
                        ),
                      ),
                    ),
                    Container(
                      height: 52,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Share your results',
                          style: TextStyles.shareTestResultTextStyle,
                        ),
                      ),
                    )
                  ],
                )
            )
        ),
      ),
    );
  }
}
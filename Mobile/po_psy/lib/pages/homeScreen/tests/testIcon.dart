import 'package:flutter/material.dart';
import 'package:po_psy/constants/UIConstants/ColorPallet.dart';
import 'package:po_psy/constants/UIConstants/TextStyles.dart';
import 'package:po_psy/models/testsModels/Category.dart';
import 'package:po_psy/models/testsModels/Test.dart';
import 'package:po_psy/models/testsModels/TestSessions.dart';
import 'package:po_psy/pages/homeScreen/tests/categoryWidget.dart';
import 'package:po_psy/pages/homeScreen/tests/startTestPage.dart';

class TestIconWidget extends StatelessWidget {
  final Test test;
  final TestSessions _testSessions;
  const TestIconWidget(this.test, this._testSessions);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: ColorPallet.mainColor,
          borderRadius: BorderRadius.circular(20)
      ),
      height: 140,
      child: Column(
        children: [
          Expanded(
              child: Padding(padding: new EdgeInsets.symmetric(
                  vertical: 7, horizontal: 20),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            test.title,
                            style: TextStyles.lightHeader2TextStyle,
                          ),
                          Spacer(),
                          Text(
                            '${test.steps.length} questions',
                            style: TextStyles.lightHeader2TextStyle,
                          )
                        ],
                      ),
                      Spacer(),
                      SizedBox(
                          width: 150,
                          height: 80,
                          child: Image.network(
                            test.imageURL,
                            fit: BoxFit.fitWidth,
                          )
                      ),
                    ],
                  )
              )
          ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
              child: Row(
                children: [
                  _testCategoriesWidget(test.categories),
                  Spacer(),
                  IconButton(
                      icon: Icon(Icons.arrow_forward, color: Colors.white,),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              StartTestPage(test, _testSessions)),
                        );
                      })
                ],
              )
          )
        ],
      ),
    );
  }
}

Widget _testCategoriesWidget(List<Category> categories) {
  if (categories.length <= 3) {
    return Row(
        children: categories.map<Widget>((Category category) {
          return Padding(
              padding: EdgeInsets.only(right: 4),
              child: CategoryWidget(category: category,)
          );
        }).toList()
    );
  } else {
    return Row(
        children: categories.take(3).map<Widget>((Category category) {
          return Padding(
              padding: EdgeInsets.only(right: 4),
              child: CategoryWidget(category: category,)
          );
        }).toList()
    );
  }
}
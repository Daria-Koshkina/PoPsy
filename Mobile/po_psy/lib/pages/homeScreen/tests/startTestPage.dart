import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:po_psy/constants/UIConstants/ColorPallet.dart';
import 'package:po_psy/constants/UIConstants/TextStyles.dart';
import 'package:po_psy/models/testsModels/Category.dart';
import 'package:po_psy/models/testsModels/Test.dart';
import 'package:po_psy/models/testsModels/TestHandler.dart';
import 'package:po_psy/pages/homeScreen/homePage.dart';
import 'package:po_psy/pages/homeScreen/tests/TestStepPage.dart';
import 'package:po_psy/pages/homeScreen/tests/categoryWidget.dart';
import 'package:po_psy/pages/homeScreen/tests/tests.dart';

class StartTestPage extends StatefulWidget {
  final Test test;
  StartTestPage({this.test});

  StartTestPageState createState() => StartTestPageState();
}

class StartTestPageState extends State<StartTestPage> {
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
                          label: Text(
                            'I`m ready!',
                            style: TextStyles.backStartTextStyle,),
                          style: TextButton.styleFrom(
                            backgroundColor: ColorPallet
                                .backgroundColor,
                          ),
                          onPressed: (){
                            _startTest(context, widget.test);
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

void _startTest(BuildContext context, Test test) {
  var testHandler = TestHandler(test);
  var testStep = testHandler.getNext();
  if (testStep != null) {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
        new TestStepPage(testHandler, testStep))
    );
  }
}
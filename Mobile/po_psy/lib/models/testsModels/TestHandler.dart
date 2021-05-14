import 'package:po_psy/models/testsModels/Test.dart';
import 'package:po_psy/models/testsModels/TestStep.dart';

class TestHandler {
  Test test;
  double sum;
  int index;

  static final TestHandler _instance = TestHandler._internal();
  TestHandler._internal() {

  }

  factory TestHandler(Test test) {
    _instance.test = test;
    _instance.sum = 0;
    _instance.index = 0;
    return _instance;
  }

  TestStep getNext() {
    if (index < test.steps.length) {
      index++;
      return test.steps[index - 1];
    } else {
      return null;
    }
  }

  void setScore(Answer answer) {
    sum += answer.weight;
  }

  String getResult() {
    return test.result.getResult(sum);
  }
}
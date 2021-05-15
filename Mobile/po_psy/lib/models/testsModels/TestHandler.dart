import 'package:po_psy/models/testsModels/Test.dart';
import 'package:po_psy/models/testsModels/TestResult.dart';
import 'package:po_psy/models/testsModels/TestStep.dart';

class TestHandler {
  Test test;
  double sum;
  int index;
  double currScore;

  static final TestHandler instance = TestHandler._internal();
  TestHandler._internal() {}

  factory TestHandler(Test test) {
    instance.test = test;
    instance.sum = 0;
    instance.index = 0;
    instance.currScore = 0;
    return instance;
  }

  TestStep getNext() {
    if (index < test.steps.length) {
      index++;
      return test.steps[index - 1];
    } else {
      return null;
    }
  }

  TestStep getPrevious() {
    if (index > 1) {
      index--;
      sum -= currScore;
      return test.steps[index];
    } else {
      return null;
    }
  }

  int getIndex() {
    return index;
  }

  void setScore(Answer answer) {
    sum += answer.weight;
    currScore = answer.weight;
  }

  TestResult getResult() {
    return new TestResult(test.scores.getResult(sum), DateTime.now(), test.imageURL);
  }

  void reset() {
    test = null;
    sum = 0;
    index = 0;
    currScore = 0;
  }
}
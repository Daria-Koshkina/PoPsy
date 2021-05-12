import 'package:po_psy/models/testsModels/Category.dart';
import 'package:po_psy/models/testsModels/Test.dart';
import 'package:po_psy/models/testsModels/TestHandler.dart';
import 'package:po_psy/models/testsModels/AnswerScores.dart';
import 'package:po_psy/models/testsModels/TestResult.dart';
import 'package:po_psy/models/testsModels/TestStep.dart';

class TestData {
  List<Test> getTests() {

    List<Category> categories = [
      Category('Psychology'),
      Category('Group'),
      Category('Individual'),
      Category('Stress'),
    ];

    List<Category> categories2 = [
      Category('Test'),
    ];

    List<Answer> answers = [
      Answer('This is answer', 1),
      Answer('This is answer', 2),
      Answer('This is answer', 3),
      Answer('This is answer', 4),
    ];
    TestStep step1 = new TestStep(Question('This is question'), answers, 'https://picsum.photos/250?image=9');
    List<TestStep> steps = [
      step1,
      step1,
      step1
    ];

    List<Score> scores = [
      Score(3, 5, 'Result 1'),
      Score(6, 8, 'Result 2'),
      Score(9, 12, 'Result 3'),
    ];
    List<Score> scores2 = [
      Score(3, 5, 'Result Result 1'),
      Score(6, 8, 'Result Result 2'),
      Score(9, 12, 'Result Result 3'),
    ];

    AnswerScores result = new AnswerScores(scores);
    AnswerScores result2 = new AnswerScores(scores2);

    TestResult testResult = TestResult(null, DateTime.now());
    String desc = '    The Stanford-Binet test is a examination meant to gauge intelligence through five factors of cognitive ability. These five factors include fluid reasoning, knowledge, quantitative reasoning, visual-spatial processing and working memory. Both verbal and nonverbal responses are measured. ';

    Test test1 = new Test(categories, steps, result, 'Test title 1', desc, 'https://picsum.photos/250?image=9', testResult);
    Test test2 = new Test(categories2, steps, result2, 'Test title 2', desc, 'https://picsum.photos/250?image=9', testResult);


    List<Test> tests = [
      test1,
      test2,
      test1,
      test2
    ];

    //testSingleton(tests[0]);
    return tests;
  }

  List<Category> getCategories() {
    List<Category> categories = [
      Category('Psychology'),
      Category('Group'),
      Category('Individual'),
      Category('Stress'),
      Category('Mood'),
    ];
    return categories;
  }

  List<Test> getCompletedTest() {
    return getTests();
  }

  void testSingleton (Test test) {
    var data = TestHandler(test);
    TestStep step1 = data.getNext();
    print(step1);

    data.setScore(step1.answers[0]);
    TestStep step2 = data.getNext();
    data.setScore(step1.answers[1]);
    print(step2);

    TestStep step3 = data.getNext();
    data.setScore(step1.answers[2]);
    print(step3);

    TestStep step4 = data.getNext();
    print(step4);

    var result = data.getResult();
    print(result);
  }
}
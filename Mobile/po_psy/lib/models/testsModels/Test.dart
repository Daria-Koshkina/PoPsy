import 'package:po_psy/models/testsModels/Category.dart';
import 'package:po_psy/models/testsModels/AnswerScores.dart';
import 'package:po_psy/models/testsModels/TestResult.dart';
import 'package:po_psy/models/testsModels/TestStep.dart';

class Test {
  final List<Category> categories;
  final List<TestStep> steps;
  final AnswerScores scores;
  final String title;
  final String description;
  final String imageURL;
  final TestResult result;

  Test(this.categories, this.steps, this.scores, this.title, this.description, this.imageURL, this.result);
}
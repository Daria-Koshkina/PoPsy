import 'package:po_psy/models/testsModels/Category.dart';
import 'package:po_psy/models/testsModels/TestResult.dart';
import 'package:po_psy/models/testsModels/TestStep.dart';

class Test {
  final List<Category> categories;
  final List<TestStep> steps;
  final TestResult result;
  final String title;
  final String imageURL;
  final DateTime date;

  Test(this.categories, this.steps, this.result, this.title, this.imageURL, this.date);
}
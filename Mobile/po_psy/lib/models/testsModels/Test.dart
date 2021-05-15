import 'package:po_psy/models/testsModels/Category.dart';
import 'package:po_psy/models/testsModels/AnswerScores.dart';
import 'package:po_psy/models/testsModels/TestResult.dart';
import 'package:po_psy/models/testsModels/TestStep.dart';

class Test {
  final int id;
  final List<Category> categories;
  final List<TestStep> steps;
  final AnswerScores scores;
  final String title;
  final String description;
  final String imageURL;
  final TestResult result;

  Test(this.id, this.categories, this.steps, this.scores, this.title, this.description, this.imageURL, this.result);

  factory Test.fromJson(Map<String, dynamic> json){
    return Test(
      json['id'],
      json['categories'].map<Category>((json) => Category.fromJson(json)).toList(),
      json['questions'].map<TestStep>((json) => TestStep.fromJson(json)).toList(),
      AnswerScores.fromJson(json['scores']),
      json['title'],
      json['description'],
      json['photo'],
      TestResult.fromJson(json['testResult']),
    );
  }
}
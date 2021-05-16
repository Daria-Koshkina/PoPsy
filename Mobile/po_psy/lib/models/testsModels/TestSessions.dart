import 'package:po_psy/models/testsModels/TestResult.dart';

class TestSessions {
  final int testId;
  List<TestResult> results;

  TestSessions(this.testId, this.results);

  factory TestSessions.fromJson(Map<String, dynamic> json){
    return TestSessions(
      json['id'],
      json['Sessions'].map<TestResult>((json) => TestResult.fromJson(json)).toList(),
    );
  }
}
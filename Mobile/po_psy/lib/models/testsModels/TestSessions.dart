import 'package:po_psy/models/testsModels/TestResult.dart';

class TestSessions {
  final int testId;
  List<TestResult> results;

  TestSessions(this.testId, this.results);
}
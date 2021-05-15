class TestResult {
  final String result;
  final DateTime date;
  final String imageURL;

  TestResult(this.result, this.date, this.imageURL);

  factory TestResult.fromJson(Map<String, dynamic> json){
    return TestResult(
      json['result'],
      json['date'],
      json['photo'],
    );
  }
}
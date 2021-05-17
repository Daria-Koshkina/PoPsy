import 'package:intl/intl.dart';

class TestResult {
  final String result;
  final DateTime date;
  final String imageURL;

  TestResult(this.result, this.date, this.imageURL);

  factory TestResult.fromJson(Map<String, dynamic> json){
    return TestResult(
      json['result'],
      DateTime.parse(json['date']),
      json['photo'],
    );
  }

  Map<String,dynamic> toPost(){
    final paramDic = {
      "result" : result,
      "date": DateFormat('yyyy-MM-ddTHH:mm:ssZ').format(date),
      "image": imageURL
    };
    return paramDic;
  }
}
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
    var currentTime = new DateTime(date.year, date.month, date.day, date.hour, date.minute, date.timeZoneOffset.inMinutes);
    final paramDic = {
      "result" : result,
      "date": '${currentTime}',
      "image": imageURL
    };
    return paramDic;
  }
}
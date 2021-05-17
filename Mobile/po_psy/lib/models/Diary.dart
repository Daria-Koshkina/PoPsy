import 'package:po_psy/models/Record.dart';

class Diary{
  List<Record> records;

  Diary(this.records);
  factory Diary.fromJson(Map<String, dynamic> json){
    return Diary(
      json['records'].map<Record>((json) => Record.fromJson(json)).toList()
    );
  }
}
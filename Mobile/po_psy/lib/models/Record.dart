class Record {
  final DateTime Date;
  final String type;
  //final File content;


  Record(this.Date, this.type,/* this.content, */);
  @override
  bool isSameDate(Record other) {
    return this.Date.year == other.Date.year && this.Date.month == other.Date.month
        && this.Date.day == other.Date.day;

  factory Record.fromJson(Map<String, dynamic> json){
    return Record(
      json['Date'],
      json['type']
      //json['content']
    );
  }
}
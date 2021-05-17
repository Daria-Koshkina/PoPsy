class Record {
  final DateTime Date;
  final String type;
  //final File content;


  Record(this.Date, this.type,/* this.content, */);
  @override
  bool isSameDate(Record other) {
    return this.Date.year == other.Date.year &&
        this.Date.month == other.Date.month
        && this.Date.day == other.Date.day;
  }

  factory Record.fromJson(Map<String, dynamic> json){
    return Record(
        DateTime.parse(json['Date']),
        json['content']
      //json['content']
    );
  }
  Map<String,dynamic> toPost(){
    var currentTime = new DateTime(Date.year, Date.month, Date.day, Date.hour, Date.minute);
    final paramDic = {
      "text" : type,
      "Date": '${currentTime}'
    };
    return paramDic;
  }

}
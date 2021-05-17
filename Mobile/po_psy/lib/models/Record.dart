class Record {
  final DateTime Date;
  final String type;
  //final File content;

  Record(this.Date, this.type,/* this.content, */);

  factory Record.fromJson(Map<String, dynamic> json){
    return Record(
      json['Date'],
      json['type']
      //json['content']
    );
  }
}
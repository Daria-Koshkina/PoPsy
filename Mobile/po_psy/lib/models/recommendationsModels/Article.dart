import 'package:po_psy/models/recommendationsModels/Content.dart';

class Article extends Content {
  final String text;
  final String author;
  final String URL;

  Article({
    String title,
    final String status = 'Article',
    this.text,
    this.author,
    this.URL
  }) : super(title: title, status: status);

  factory Article.fromJson(Map<String, dynamic> json){
    return Article(
        title: json['title'],
        status: json['status'],
        text: json['text'],
        author: json['author'],
        URL: null,
    );
  }
}
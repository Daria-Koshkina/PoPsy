import 'package:po_psy/models/Content.dart';

class Article extends Content {
  final String title;
  final String status;
  final String text;
  final String author;
  final String URL;

  Article({
    this.title,
    this.status = 'Article',
    this.text,
    this.author,
    this.URL
  }) : super(title: title, status: status);
}
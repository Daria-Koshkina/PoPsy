import 'package:po_psy/models/recommendationsModels/Content.dart';

class Article extends Content {
  final int id;
  final String text;
  final String author;
  final String URL;

  Article({
    this.id,
    String title,
    final String status = 'Article',
    this.text,
    this.author,
    this.URL
  }) : super(title: title, status: status);
}
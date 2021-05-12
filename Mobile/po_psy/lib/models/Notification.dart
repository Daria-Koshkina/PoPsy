import 'package:po_psy/models/Content.dart';

class MyNotification extends Content {
  final int id;
  final String text;
  final String URL;

  MyNotification({
    this.id,
    String title,
    final String status = 'Notification',
    this.text,
    this.URL
  }) : super(title: title, status: status);
}
import 'package:po_psy/models/Content.dart';

class MyNotification extends Content {
  final String title;
  final String status;
  final String text;
  final String URL;

  MyNotification({
    this.title,
    this.status = 'Notification',
    this.text,
    this.URL
  }) : super(title: title, status: status);
}
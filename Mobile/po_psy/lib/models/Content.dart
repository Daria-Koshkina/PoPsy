import 'package:po_psy/models/MusicPlaylist.dart';

class Content {
  final String title;
  final String status;

  Content({
    this.title,
    this.status
  });

  factory Content.fromJson(Map<String, dynamic> json){
    if (json['status'] == 'Songs'){
      return MusicPlaylist.fromJson(json);
    }
    return null;
  }
}
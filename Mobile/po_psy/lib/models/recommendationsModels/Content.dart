import 'package:po_psy/models/recommendationsModels/Article.dart';
import 'package:po_psy/models/recommendationsModels/MusicPlaylist.dart';
import 'package:po_psy/models/recommendationsModels/VideoPlaylist.dart';

class Content {
  final String title;
  final String status;

  Content({
    this.title,
    this.status
  });

  factory Content.fromJson(Map<String, dynamic> json){
    switch (json['status']){
      case 'Songs':{
        return MusicPlaylist.fromJson(json);
      }
      break;
      case 'Videos':{
        return VideoPlaylist.fromJson(json);
      }
      break;
      case 'Article':{
        return Article.fromJson(json);
      }
      break;
      case 'Notification':{

      }
      break;
    }
    return null;
  }
}
import 'package:po_psy/models/recommendationsModels/Content.dart';
import 'package:po_psy/models/recommendationsModels/Video.dart';

class VideoPlaylist extends Content {
  final List<Video> videos;
  final String URL;
  final String imageURL;

  VideoPlaylist({
    String title,
    final String status = 'Videos',
    this.videos,
    this.URL,
    this.imageURL
  }) : super(title: title, status: status);

  factory VideoPlaylist.fromJson(Map<String, dynamic> json){
    return VideoPlaylist(
        title: json['title'],
        status: json['status'],
        videos: json['videos'].map<Video>((json) => Video.fromJson(json)).toList(),
        URL: null,
        imageURL: json['image']
    );
  }
}
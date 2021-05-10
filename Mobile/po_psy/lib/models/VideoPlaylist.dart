import 'package:po_psy/models/Content.dart';
import 'package:po_psy/models/Video.dart';

class VideoPlaylist extends Content {
  final int id;
  final List<Video> videos;
  final String URL;
  final String imageURL;

  VideoPlaylist({
    this.id,
    String title,
    final String status = 'Videos',
    this.videos,
    this.URL,
    this.imageURL
  }) : super(title: title, status: status);
}
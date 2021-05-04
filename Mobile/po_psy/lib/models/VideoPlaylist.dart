import 'package:flutter/cupertino.dart';
import 'package:po_psy/models/Content.dart';
import 'package:po_psy/models/Song.dart';
import 'package:po_psy/models/Video.dart';

class VideoPlaylist extends Content {
  final title;
  final status;
  final List<Video> videos;
  final String URL;
  final Image image;

  VideoPlaylist({
    this.title,
    this.status = 'Videos',
    this.videos,
    this.URL,
    this.image
  }) : super(title: title, status: status);
}
import 'package:flutter/cupertino.dart';
import 'package:po_psy/models/Content.dart';
import 'package:po_psy/models/Song.dart';

class MusicPlaylist extends Content {
  final title;
  final status;
  final List<Song> songs;
  final String URL;
  final Image image;

  MusicPlaylist({
    this.title,
    this.status = 'Songs',
    this.songs,
    this.URL,
    this.image
  }) : super(title: title, status: status);
}
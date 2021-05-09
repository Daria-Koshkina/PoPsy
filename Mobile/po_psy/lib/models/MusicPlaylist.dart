import 'package:flutter/cupertino.dart';
import 'package:po_psy/models/Content.dart';
import 'package:po_psy/models/Song.dart';

class MusicPlaylist extends Content {
  final int id;
  List<Song> songs;
  final String URL;
  String imageURL;

  MusicPlaylist({
    this.id,
    String title,
    final String status = 'Songs',
    this.songs,
    this.URL,
    this.imageURL
  }) : super(title: title, status: status);

  factory MusicPlaylist.fromJson(Map<String, dynamic> json){
    return MusicPlaylist(
        id: json['id'],
        title: json['title'],
        status: 'Songs',
        songs: null,
        URL: null,
        imageURL: null
    );
  }
}
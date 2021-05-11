import 'package:flutter/cupertino.dart';
import 'package:po_psy/models/recommendationsModels/Content.dart';
import 'package:po_psy/models/recommendationsModels/Song.dart';

class MusicPlaylist extends Content {
  List<Song> songs;
  final String URL;
  String imageURL;

  MusicPlaylist({
    String title,
    final String status = 'Songs',
    this.songs,
    this.URL,
    this.imageURL
  }) : super(title: title, status: status);

  factory MusicPlaylist.fromJson(Map<String, dynamic> json){
    return MusicPlaylist(
        title: json['title'],
        status: json['status'],
        songs: json['songs'].map<Song>((json) => Song.fromJson(json)).toList(),
        URL: null,
        imageURL: json['image']
    );
  }
}
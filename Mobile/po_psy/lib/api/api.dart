import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:po_psy/models/Content.dart';
import 'package:po_psy/models/MusicPlaylist.dart';
import '../models/Song.dart';
import '../models/connecters/song_playlist.dart';
import 'package:http/http.dart' as http;
import '../constants/ApiConstants/Strings.dart' as urls;

class ApiManager {
  Future<List<Song>> fetchSongs() async {
    var songs = null;
    final url = Uri.parse(urls.Strings.songs_url);
    final responce = await http.get(url);
    if (responce.statusCode == 200) {
      var data = json.decode(responce.body) as List;
      songs = data.map<Song>((json) => Song.fromJson(json)).toList();
    }
    return songs;
  }

  Future<List<MusicPlaylist>> getPlayLists() async {
    List<MusicPlaylist> playlists = null;

    var url = Uri.parse(urls.Strings.get_playlists_url);
    var responce = await http.get(url);
    if (responce.statusCode == 200) {
      var data = json.decode(responce.body) as List;
      playlists = data.map<MusicPlaylist>((json) => MusicPlaylist.fromJson(json)).toList();
    }

    return playlists;
  }

}
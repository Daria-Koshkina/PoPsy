import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:po_psy/models/recommendationsModels/MusicPlaylist.dart';
import '../models/recommendationsModels/Song.dart';
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
    List<Song> songs = null;
    List<SongPlayList> songs_playlists = null;

    var url = Uri.parse(urls.Strings.playlists_url);
    var responce = await http.get(url);
    if (responce.statusCode == 200) {
      var data = json.decode(responce.body) as List;
      playlists = data.map<MusicPlaylist>((json) => MusicPlaylist.fromJson(json)).toList();
    }

    url = Uri.parse(urls.Strings.songs_playlists_url);
    responce = await http.get(url);
    if (responce.statusCode == 200) {
      var data = json.decode(responce.body) as List;
      songs_playlists = data.map<SongPlayList>((json) => SongPlayList.fromJson(json)).toList();
    }

    songs = await fetchSongs();

    playlists.forEach((playlist) {
      playlist.imageURL = 'https://picsum.photos/250?image=9';
      // ignore: deprecated_member_use
      playlist.songs = new List<Song>();
      songs_playlists.forEach((sp) {
        if (sp.PlaylistId == playlist.id){
          playlist.songs.add(songs.firstWhere((song) => song.id == sp.SongId));
        }
      });
    });

    return playlists;
  }

}
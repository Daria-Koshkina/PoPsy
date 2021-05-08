import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/Song.dart';
import 'package:http/http.dart' as http;

class SongProvider with ChangeNotifier{
  List<Song> _songs = [];

  List<Song> get songs{
    return [..._songs];
  }

  fetchSongs() async{
    final url = Uri.parse('http://127.0.0.1:8000/apis/user/?format=json');
    final responce = await http.get(url);
    if (responce.statusCode == 200){
      var data = json.decode(responce.body) as List;
      _songs = data.map<Song>((json) => Song.fromJson(json)).toList();
    }

  }

}
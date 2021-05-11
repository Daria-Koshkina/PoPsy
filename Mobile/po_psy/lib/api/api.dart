import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:po_psy/models/recommendationsModels/Content.dart';
import 'package:po_psy/models/recommendationsModels/MusicPlaylist.dart';
import '../models/recommendationsModels/Song.dart';
import 'package:http/http.dart' as http;
import '../constants/ApiConstants/Strings.dart' as urls;

class User{
  String email;
  String password;

  User(this.email, this.password);

  Map<String,String> toPost(){
    final paramDic = {
      "email": email,
      "password": password,
    };
    return paramDic;
  }
}

class ApiManager {

  Future<List<MusicPlaylist>> getPlayLists() async {
    List<MusicPlaylist> playlists = null;
    User user = new User('123@test.com','12345');
    var resp = await register(user);

    var url = Uri.parse(urls.Strings.get_playlists_url);
    var responce = await http.get(url);
    if (responce.statusCode == 200) {
      var data = json.decode(responce.body) as List;
      playlists = data.map<MusicPlaylist>((json) => MusicPlaylist.fromJson(json)).toList();
    }

    return playlists;
  }

  Future<http.Response> register (User user) async{
    var url = Uri.parse(urls.Strings.register_url);
    var responce = await http.post(url, body: user.toPost());
    return responce;
  }

  Future<http.Response> signIn (User user) async{
    var url = Uri.parse(urls.Strings.signIn_url);
    var responce = await http.post(url, body: user.toPost());
    return responce;
  }

}
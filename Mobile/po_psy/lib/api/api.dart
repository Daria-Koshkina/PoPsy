import 'dart:convert';
import 'package:po_psy/models/recommendationsModels/Content.dart';
import 'package:http/http.dart' as http;
import '../constants/ApiConstants/Strings.dart' as urls;
import '../models/User.dart';


class ApiManager {

  Future<List<Content>> getContent() async {
    List<Content> content = null;

    var url = Uri.parse(urls.Strings.get_playlists_url);
    var responce = await http.get(url);
    if (responce.statusCode == 200) {
      var data = json.decode(responce.body) as List;
      content = data.map<Content>((json) => Content.fromJson(json)).toList();
    }

    return content;
  }

  Future<http.Response> register (User user) async{
    var url = Uri.parse(urls.Strings.register_url);
    Map<String, dynamic> responceBody = user.toPost();
    var responce = await http.post(url, body: responceBody);
    return responce;
  }

  Future<http.Response> signIn (String email, String password) async{
    User user;
    var url = Uri.parse(urls.Strings.signIn_url);
    var responce = await http.post(url, body: {"email" : email, "password" : password});
    return responce;
  }

}
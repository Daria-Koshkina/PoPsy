import 'dart:convert';
import 'dart:io';
import 'package:po_psy/api/GenerateImageUrl.dart';
import 'package:po_psy/models/UserHandler.dart';
import 'package:po_psy/models/recommendationsModels/Content.dart';
import 'package:http/http.dart' as http;
import '../constants/ApiConstants/Strings.dart' as urls;
import '../models/User.dart';
import 'package:po_psy/api/UploadFile.dart';


class ApiManager {

  Future<List<Content>> getContent() async {
    List<Content> content = null;

    var url = Uri.parse(urls.Strings.get_content_url);
    Map<String, dynamic> userId = {"userId": UserHandler.instance.getUserId().toString()};
    var responce = await http.post(url, body: userId);
    //var responce = await http.get(url);
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
    var url = Uri.parse(urls.Strings.signIn_url);
    var responce = await http.post(url, body: {"email" : email, "password" : password});
    return responce;
  }

  Future<http.Response> getUser (String userId) async{
    var url = Uri.parse(urls.Strings.getUser_url);
    var responce = await http.post(url, body: {"userId" : userId});
    return responce;
  }

  Future<String> uploadImage (context, String fileExtension, image) async {
    GenerateImageUrl generateImageUrl = GenerateImageUrl();
    await generateImageUrl.call(fileExtension);

    String uploadUrl;
    if (generateImageUrl.isGenerated != null &&
        generateImageUrl.isGenerated) {
      uploadUrl = generateImageUrl.uploadUrl;
    } else {
      throw generateImageUrl.message;
    }

    bool isUploaded = await uploadFile(context, uploadUrl, image);
    if (isUploaded) {
      return generateImageUrl.downloadUrl;
    }
    return null;
  }

  Future<bool> uploadFile(context, String url, File image) async {
    try {
      UploadFile uploadFile = UploadFile();
      await uploadFile.call(url, image);

      if (uploadFile.isUploaded != null && uploadFile.isUploaded) {
        return true;
      } else {
        throw uploadFile.message;
      }
    } catch (e) {
      throw e;
    }
  }


}
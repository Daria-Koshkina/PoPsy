import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:po_psy/api/GenerateImageUrl.dart';
import 'package:po_psy/models/Diary.dart';
import 'package:po_psy/models/Record.dart';
import 'package:po_psy/models/UserHandler.dart';
import 'package:po_psy/models/recommendationsModels/Content.dart';
import 'package:http/http.dart' as http;
import 'package:po_psy/models/testsModels/Category.dart';
import 'package:po_psy/models/testsModels/Test.dart';
import 'package:po_psy/models/testsModels/TestResult.dart';
import 'package:po_psy/models/testsModels/TestSessions.dart';
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

  Future<http.Response> getUserByEmail (String email) async{
    var url = Uri.parse(urls.Strings.getUserByEmail_url);
    var responce = await http.post(url, body: {"email" : email});
    return responce;
  }

  Future<http.Response> updateUser(User user) async{
    var url = Uri.parse(urls.Strings.updateUser_url);
    final Map<String,dynamic> responceBody = user.toPost();
    var responce = await http.post(url, body: responceBody);
    return responce;
    if (responce.statusCode == 200) {
      print('Posted successfully');
    }
    //return content;
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

  Future<List<Test>> allTests(List<Category> categories) async{
    List<Test> content = null;
    var url = Uri.parse(urls.Strings.allTests_url);
    Map<String,dynamic> responceBody = {'categories': jsonEncode(categories.map<Map<String,dynamic>>((category) => category.toPost()).toList())};
    var responce = await http.post(url, body: responceBody);
    if (responce.statusCode == 200) {
      var data = json.decode(responce.body) as List;
      content = data.map<Test>((json) => Test.fromJson(json)).toList();
    }
    return content;
  }

  Future<List<Test>> usedTests(String userId) async{
    List<Test> content = null;
    var url = Uri.parse(urls.Strings.usedTests_url);
    var responce = await http.post(url, body: {"userId" : userId});
    if (responce.statusCode == 200) {
      var data = json.decode(responce.body) as List;
      content = data.map<Test>((json) => Test.fromJson(json)).toList();
    }
    return content;
  }


  Future<List<TestSessions>> prepareSession(String userId) async{
    List<TestSessions> content = null;
    var url = Uri.parse(urls.Strings.prepareSession_url);
    var responce = await http.post(url, body: {"userId" : userId});
    if (responce.statusCode == 200) {
      var data = json.decode(responce.body) as List;
      content = data.map<TestSessions>((json) => TestSessions.fromJson(json)).toList();
    }
    return content;
  }

  Future<List<Category>> getCategories() async{
    List<Category> content = null;
    var url = Uri.parse(urls.Strings.getCategories_url);
    var responce = await http.get(url);
    if (responce.statusCode == 200) {
      var data = json.decode(responce.body) as List;
      content = data.map<Category>((json) => Category.fromJson(json)).toList();
    }
    return content;
  }

  Future<void> postTestResult(String testId, TestResult testResult, String userId) async{
    // TODO: push testSession to server
    var url = Uri.parse(urls.Strings.postTestResult_url);
    final Map<String,dynamic> responceBody = testResult.toPost();
    responceBody["userId"] = userId;
    responceBody["testId"] = testId;
    var responce = await http.post(url, body: responceBody);
    if (responce.statusCode == 200) {
      print('Posted successfully');
    }
    //return content;
  }

  Future<List<Record>> prepareDiary(String userId) async{
    List<Record> content = null;
    var url = Uri.parse(urls.Strings.prepareDiary_url);
    var responce = await http.post(url, body: {"userId" : userId});
    if (responce.statusCode == 200) {
      var data = json.decode(responce.body);
      content = data.map<Record>((json) => Record.fromJson(json)).toList();
    }
    return content;
  }

  Future<void> postRecord(String userId, Record record) async{
    // TODO: push testSession to server
    var url = Uri.parse(urls.Strings.postRecord_url);
    final Map<String,dynamic> responceBody = record.toPost();
    responceBody["userId"] = userId;
    var responce = await http.post(url, body: responceBody);
    if (responce.statusCode == 200) {
      print('Posted successfully');
    }
  }

}
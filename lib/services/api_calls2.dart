import 'package:flutter/foundation.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:sidebar_animation/services/api_login.dart';
import '../models/training_module_course_model.dart';
import '../models/video_model.dart';
import '../models/categories_model.dart';
import 'dart:io';

import 'api_url.dart';

// http.Client client;


Future getUpdatedUser(id,client)async{
  final storage = FlutterSecureStorage();
  String token = await storage.read(key: "token");
  final tokenHeaders = {'token': token, 'content-type': 'application/json'};
  final url = "$apiUrl/api/v1/users/$id";
  final response = await client.get(
    url, headers: tokenHeaders,
  );
  if (response.statusCode == 200){
    print(response.body);
  }

}
Future<List<VideoCategory>>getCategories(client)async{
  var dir = await getTemporaryDirectory();
  File categories = File(dir.path + "/categories.json");
  String url = "$apiUrl/api/v1/categories";
  print(url);
  final response = await client.get(
    url, headers: {'content-type': 'application/json'}
  );
  print(response.body);
  if (response.statusCode == 200){
    final parsed = json.decode(response.body);
    final parsedList = parsed.map<VideoCategory>((json) => VideoCategory.fromJson(json)).toList();
    print(parsedList);
    categories.writeAsStringSync(response.body, flush: true, mode: FileMode.write);
    return parsedList;
  }else return null;
}
getParsedCategories () async{
  var dir = await getTemporaryDirectory();
  File categories = File(dir.path + "/categories.json");
  return categories;
}

List<Video> parseVideos(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  final parsedList = parsed.map<Video>((json) => Video.fromJson(json))
          .toList();
  return parsedList;
}
Video parseOneVideo(random){
  final parsed = json.decode(random);
  final parsedVideo = Video.fromJson(parsed);
  return parsedVideo;
}

List<TrainingModule> parseTrainingModules(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  final parsedList = parsed.map<TrainingModule>((json) => TrainingModule.fromJson(json))
          .toList();
  return parsedList;
}

Future<List<Video>> cachedVideos (category)async {
  var dir = await getTemporaryDirectory();
  File file = File(dir.path + "/" + category + ".json");
  var cachedVideos = file.readAsStringSync();
  return parseVideos(cachedVideos);
}

Future<List<Video>> fetchVideos(client, category, context) async {
  var dir = await getTemporaryDirectory();
  File file = File(dir.path + "/" + category + ".json");
  if (file.existsSync()) {
    print("file exists");
    DateTime update = await file.lastModified();
    var now = new DateTime.now();
    print(update.day);
    if (update.day == now.day) {
      print("Fetching from cache: $category");
      var cachedVideos = file.readAsStringSync();
      return parseVideos(cachedVideos);
    } else{
      print("go for updates");
      return updateVideos(client, category, context);
    }
  } else {
    print("go for updates");
    return updateVideos(client, category, context);
  }
}
Future <Video> updateOneVideo(http.Client client, category, customUrl, context) async {
  var dir = await getTemporaryDirectory();
  File file = File(dir.path + "/" + category + ".json");
  final storage = FlutterSecureStorage();
  String token = await storage.read(key: "token");
  final tokenHeaders = {'token': token, 'content-type': 'application/json'};
  final url = "$apiUrl/api/v1/videos/$customUrl";
  print(url);
  final response = await client.get(
    url, headers: tokenHeaders,
  );
  if (response != null) {
    if (response.statusCode == 200) {
      file.writeAsStringSync(response.body, flush: true, mode: FileMode.write);
      return parseOneVideo(response.body);
    } else {
      signOut(context);
      print(response.body);
      return null;
    }
  }else{
    return null;
  }
}
Future<Video> fetchRandom(client, category, context) async {
  var dir = await getTemporaryDirectory();
  File file = File(dir.path + "/" + category + ".json");
  if (file.existsSync()) {
    DateTime update = await file.lastModified();
    if (update.day == DateTime.now().day) {
      print("update random from cache");
      var randomVideo = file.readAsStringSync();
      print(randomVideo);
      return parseOneVideo(randomVideo);
    } else {
      print("go get it");
      return updateOneVideo(client, category, "random", context);
    }
  }else{
    print("go get it");
    return updateOneVideo(client, category, "random", context);
  }

}

Future<List<TrainingModule>> fetchCourses(client, category, context) async {
  var dir = await getTemporaryDirectory();
  File file = File(dir.path + "/" + category + ".json");

  if (file.existsSync()) {
    print("Fetching from cache: $category");
    var cachedCourses = file.readAsStringSync();

    return parseTrainingModules(cachedCourses);
  } else {
    print("update");
    return updateCourses(client, category, context);
  }
}

Future<String>getVideoFile(id, client)async{
  final storage = FlutterSecureStorage();
  String token = await storage.read(key: "token");
  final tokenHeaders = {'token': token, 'content-type': 'application/json'};
  final url = "$apiUrl/api/v1/videos/$id";
  final response = await client.get(
    url, headers: tokenHeaders
  );
  print(response.body);
  if (response.statusCode == 200){
    return "here";
  } else return null;

}

Future <List<Video>> updateVideos(http.Client client, category, context) async {
  var updateResponse;
  var dir = await getTemporaryDirectory();
  File file = File(dir.path + "/$category.json");
  print("update: $category");
  final storage = FlutterSecureStorage();
  String token = await storage.read(key: "token");
  final tokenHeaders = {'token': token, 'content-type': 'application/json'};
  var url = "$apiUrl/api/v1/videos/category?category=$category";

  final response = await client.get(
    url, headers: tokenHeaders,
  );

  if (response != null) {
    if (response.statusCode == 200) {
      print("updated $category from api");
      file.writeAsStringSync(response.body, flush: true, mode: FileMode.write);
      print("so far so good");
      print(response.body);
      return parseVideos(response.body);
    } else {
      signOut(context);
      return null;
    }
  } else return null;
}
  Future<List<TrainingModule>>updateCourses(http.Client client, category, context) async {
    var dir = await getTemporaryDirectory();
    File file = File(dir.path + "/$category.json");
    print("update: $category");
    final storage = FlutterSecureStorage();
    String token = await storage.read(key: "token");
    final tokenHeaders = {'token': token, 'content-type': 'application/json'};
    final response = await client.get(
      "$apiUrl/api/v1/training_modules", headers: tokenHeaders,
    );
    print(response.body);
    if (response.statusCode == 200) {
      print("updated courses from api");
      file.writeAsStringSync(response.body, flush: true, mode: FileMode.write);
      return compute(parseTrainingModules, response.body);
    } else {
      signOut(context);
      return null;
      // if (response.statusCode != null) {
      //   print("media not updated from api");
      //   print(response.statusCode);
      //   return null;
      // } else {
      //   print("no api response");
      //   return null;
      // }
    }
  }
  Future<List<Video>> checkThenUpdateVideos(http.Client client,
      category) async {
    String media_type = "videos";
    var dir = await getTemporaryDirectory();
    File file = File(dir.path + "/" + category + ".json");
    var _cachedVideos = file.readAsStringSync();
    final storage = FlutterSecureStorage();
    String token = await storage.read(key: "token");
    final tokenHeaders = {'token': token, 'content-type': 'application/json'};

    if (file.existsSync()) {
      final response = await client.get(
        "$apiUrl/api/v1/$media_type", headers: tokenHeaders,
      );
      if (response.statusCode == 200) {
        var _apiVideos = response.body;

        if (_cachedVideos.length == _apiVideos.length) {
          print("no change in $category, no update");
          return parseVideos(_cachedVideos);
        } else {
          print("updating $category... there is a change");

          file.writeAsStringSync(
              _apiVideos, flush: true, mode: FileMode.write);
          return parseVideos(_apiVideos);
        }
      } else {
        if (response.statusCode != null) {
          print("$category not updated from api");
          print(response.statusCode);

        } else {
          print("no api response");
          return null;
        }
      }
    }
  }



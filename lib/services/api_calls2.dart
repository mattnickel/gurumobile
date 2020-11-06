import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:sidebar_animation/models/training_module_course_model.dart';
import '../models/video_model.dart';
import 'dart:io';

http.Client client;
// String url = 'https://limitlessguru.herokuapp.com/api/v1/videos';
String base_url = 'https://limitlessguru.herokuapp.com/api/v1';
// String local_url = 'http://localhost:3000/api/v1/';

List<Video> parseVideos(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  final parsedList = parsed.map<Video>((json) => Video.fromJson(json))
          .toList();
  return parsedList;
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

Future<List<Video>> fetchVideos(category) async {
  final storage = FlutterSecureStorage();
  String token = await storage.read(key: "token");
  var dir = await getTemporaryDirectory();
  File file = File(dir.path + "/" + category + ".json");

  if (file.existsSync()) {
    print("Fetching from cache: $category");
    var cachedVideos = file.readAsStringSync();
    return parseVideos(cachedVideos);
  } else {
    print("update now");
    return updateVideos(client, category);
  }
}
Future<List<TrainingModule>> fetchCourses(category) async {
  var dir = await getTemporaryDirectory();
  File file = File(dir.path + "/" + category + ".json");

  if (file.existsSync()) {
    print("Fetching from cache: $category");
    var cachedCourses = file.readAsStringSync();

    return parseTrainingModules(cachedCourses);
  } else {
    print("update");
    return updateCourses(client, category);
  }
}

Future<List<Video>>updateVideos(http.Client client, category) async {
  var dir = await getTemporaryDirectory();
  File file = File(dir.path + "/$category.json");
  print("update: $category");
  final storage = FlutterSecureStorage();
  String token = await storage.read(key: "token");

  final tokenHeaders = {'token': token, 'content-type': 'application/json'};
  final response = await client.get(
    "$base_url/videos", headers: tokenHeaders,
  );
  if (response.statusCode == 200) {
    print("updated $category from api");
    file.writeAsStringSync(response.body, flush: true, mode: FileMode.write);
    return compute(parseVideos, response.body);
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
Future<List<TrainingModule>>updateCourses(http.Client client, category) async {
  var dir = await getTemporaryDirectory();
  File file = File(dir.path + "/$category.json");
  print("update: $category");
  final storage = FlutterSecureStorage();
  String token = await storage.read(key: "token");
  final tokenHeaders = {'token': token, 'content-type': 'application/json'};
  final response = await client.get(
    "$base_url/training_modules", headers: tokenHeaders,
  );
  print(response.body);
  if (response.statusCode == 200) {
    print("updated courses from api");
    file.writeAsStringSync(response.body, flush: true, mode: FileMode.write);
    return compute(parseTrainingModules, response.body);
  } else {
    if (response.statusCode != null) {
      print("media not updated from api");
      print(response.statusCode);
    } else {
      print("no api response");
      return null;
    }
  }
}
  Future<List<Video>> checkThenUpdateVideos(http.Client client,
      category) async {
    String media_type = "videos";
    var dir = await getTemporaryDirectory();
    File file = File(dir.path + "/" + category + ".json");
    print("here");
    var _cachedVideos = file.readAsStringSync();
    print("also here");
    final storage = FlutterSecureStorage();
    String token = await storage.read(key: "token");
    final tokenHeaders = {'token': token, 'content-type': 'application/json'};

    if (file.existsSync()) {
      final response = await client.get(
        "$base_url/$media_type", headers: tokenHeaders,
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



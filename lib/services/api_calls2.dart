import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:async' show Future;
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:sidebar_animation/screens/login_screen.dart';
import '../models/video_model.dart';
import 'dart:io';

String url = 'https://limitlessguru.herokuapp.com/api/v1/videos';

List<Video> parseVideos(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  final parsedList = parsed.map<Video>((json)=> Video.fromJson(json)).toList();
  return parsedList;
}

Future<List<Video>> fetchVideos(http.Client client, category, context) async {

  final storage = FlutterSecureStorage();
  String token = await storage.read(key: "token");
  String params = "access_token=$token";
  String build_url = url+"?"+params;
  print(build_url);
  var dir = await getTemporaryDirectory();
  File file = File(dir.path + "/" + category + ".json");

  if (file.existsSync()) {
    print("Fetching from cache: $category");
    var cachedVideos = file.readAsStringSync();
    return parseVideos(cachedVideos);
  } else {
    print("Fetching from api: $category");
    final response = await client.get(
        build_url,
        );

    if (response.statusCode == 200) {
      file.writeAsStringSync(response.body, flush: true, mode: FileMode.write);
      return compute(parseVideos, response.body);
    } else {
      print("errors fetching: $category");
      if (response.statusCode != null) {
        print(response.statusCode);
        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => LoginPage("")));
      } else {

        print("no response");
        return null;
      }
    }
  }
}

Future<List<Video>> updateVideos(http.Client client, category) async {
  var dir = await getTemporaryDirectory();
  File file = File(dir.path + "/" + category + ".json");
  print("updateVideos: $category");
  final storage = FlutterSecureStorage();
  String token = await storage.read(key: "token");
  String params = "access_token=$token";
  String build_url = url+"?"+params;
  print(build_url);

  final response = await client.get(build_url);
  if (response.statusCode == 200) {
    print("update from api");
    file.writeAsStringSync(response.body, flush: true, mode: FileMode.write);
  } else {
    if (response.statusCode != null) {
      print("not updated from api");
      print(response.statusCode);
    } else {
      print("no api response");
      return null;
    }
  }
}
  Future<List<Video>> checkThenUpdateVideos(http.Client client,
      category) async {
    var dir = await getTemporaryDirectory();
    File file = File(dir.path + "/" + category + ".json");
    var _cachedVideos = file.readAsStringSync();
    final storage = FlutterSecureStorage();
    String token = await storage.read(key: "token");
    String params = "access_token=$token";
    String build_url = url+"?"+params;
    print(build_url);

    if (file.existsSync()) {
      final response = await client.get(build_url);
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


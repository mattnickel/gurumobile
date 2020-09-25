import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:async' show Future;
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:sidebar_animation/models/training_module_course_model.dart';
import 'package:sidebar_animation/screens/login_screen.dart';
import '../models/video_model.dart';
import 'dart:io';

// String url = 'https://limitlessguru.herokuapp.com/api/v1/videos';
String base_url = 'https://limitlessguru.herokuapp.com/api/v1';
// String local_url = 'http://localhost:3000/api/v1/';



Future<String>markedViewed(videoId, seconds) async {

  final storage = FlutterSecureStorage();
  String token = await storage.read(key: "token");
  final tokenHeaders = {'token': token, 'content-type': 'application/json'};
  DateTime now = DateTime.now();
  print(now);
  final msg = jsonEncode({"video_id": videoId, "last_second_viewed":seconds, "date":"$now"});
  final response = await http.post(
      "$base_url/viewings",
      headers: tokenHeaders,
      body: msg,
    );
  print (response.body);
  return null;

}



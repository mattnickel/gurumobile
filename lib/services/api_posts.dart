
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:async' show Future;
import 'dart:convert';


// String url = 'https://limitlessguru.herokuapp.com/api/v1/videos';
String base_url = 'https://limitlessguru.herokuapp.com/api/v1';
String local_url = 'http://localhost:3000/api/v1/';



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
Future<String>saveGoals(goals) async {

  final storage = FlutterSecureStorage();
  String token = await storage.read(key: "token");
  final tokenHeaders = {'token': token, 'content-type': 'application/json'};
  final message = goals.asMap();
  // print(message);
  final msg = [{"goals": message}];
  print(msg);
  final response = await http.post(
    "$local_url/goals",
    headers: tokenHeaders,
    body: msg,
  );
  // print (response.body);
  return null;

}


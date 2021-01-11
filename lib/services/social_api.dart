import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:sidebar_animation/models/social_post_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'dart:io';
import 'package:dio/dio.dart';

http.Client client;
// String url = 'https://limitlessguru.herokuapp.com/api/v1/videos';
String baseUrl = 'https://limitlessguru.herokuapp.com/api/v1';
// String localUrl = 'http://localhost:3000/api/v1';

List<SocialPost> parseSocial(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  final parsedList = parsed.map<SocialPost>((json) => SocialPost.fromJson(json))
          .toList();
  return parsedList;
}

Future<List<SocialPost>> fetchSocial(client) async {
  var dir = await getTemporaryDirectory();
  File file = File(dir.path + "/social.json");
  if (file.existsSync()) {
    print("file exists");
    DateTime update = await file.lastModified();
    var now = new DateTime.now();
    if (update.day == now.day) {
      print("Fetching social from cache");
      var cachedSocial = file.readAsStringSync();
      return parseSocial(cachedSocial);
    } else{
      print("go for updates");
      return updateSocial(client);
    }
  } else {
    print("go for updates");
    return updateSocial(client);
  }
}
savePost(message, image) async {
  final storage = FlutterSecureStorage();
  String token = await storage.read(key: "token");
  final tokenHeaders = {'token': token};
  var postUri = Uri.parse("$baseUrl/social_posts");
  print(postUri);
  String fileName = image.path.split('/').last;
  final msg = [{"message": message, "image":image}];

  FormData data = FormData.fromMap({
    "image": await MultipartFile.fromFile(
      image.path,
      filename: fileName,
    ),
    "message": message

  });

  Dio dio = new Dio();
  dio.options.headers = tokenHeaders;
  Response response = await dio.post("$postUri", data: data);

  if (response != null) {
    print(response);
    return false;
  }else{
    return true;
  }
}


Future <List<SocialPost>> updateSocial(http.Client client) async {
  var updateResponse;
  var dir = await getTemporaryDirectory();
  File file = File(dir.path + "/social.json");
  print("update social");
  final storage = FlutterSecureStorage();
  String token = await storage.read(key: "token");
  final tokenHeaders = {'token': token, 'content-type': 'application/json'};
  var url = "$baseUrl/social_posts";

  final response = await client.get(
    url, headers: tokenHeaders,
  );

  if (response != null) {
    if (response.statusCode == 200) {
      print("updated social from api");
      file.writeAsStringSync(response.body, flush: true, mode: FileMode.write);
      print(response.body);
      return parseSocial(response.body);
    } else {
      print("social not updated from api");
      print(response.body);
      return null;
    }
  }
}
Future mostRecentPostTime(http.Client client) async {
  final storage = FlutterSecureStorage();
  String token = await storage.read(key: "token");
  final tokenHeaders = {'token': token, 'content-type': 'application/json'};
  var url = "$baseUrl/social_posts/recent";

  final response = await client.get(
    url, headers: tokenHeaders,
  );
  if (response != null) {
    if (response.statusCode == 200) {
      print("latest timestamp");
      print(response.body);
      var time = json.decode(response.body);
      return time;
    } else {
      print("timestamp not working");
      print(response.body);
      return null;
    }
  }
}
Future bumpThisPost(postId)async{
  final storage = FlutterSecureStorage();
  String token = await storage.read(key: "token");
  final tokenHeaders = {'token': token, 'content-type': 'application/json'};
  var url = "$baseUrl/post_bumps";

  final msg = jsonEncode({"bump": "true", "postId":"$postId"});
  final response = await http.post(
    url,
    headers: tokenHeaders,
    body: msg,
  );
  print(response.body);
}

Future unbumpThisPost(postId) async{
  final storage = FlutterSecureStorage();
  String token = await storage.read(key: "token");
  final tokenHeaders = {'token': token, 'content-type': 'application/json'};
  var url = "$baseUrl/post_bumps";

  final msg = jsonEncode({"bump": "false", "post_id":"$postId"});
  print(msg);
  final response = await http.put(
    url,
    headers: tokenHeaders,
    body: msg,
  );
  print(response.body);

}





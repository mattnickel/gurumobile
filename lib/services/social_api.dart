
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

import 'dart:io';
import 'package:dio/dio.dart';

import 'api_login.dart';
import 'api_url.dart';

http.Client client;

List<Map> parseSocial(String responseBody) {
  final responseJson = utf8.decode(responseBody.runes.toList());
  print (responseJson);
  final parsed = json.decode(responseJson).cast<Map<String, dynamic>>();
  return parsed;
}

Future<List<Map>> fetchSocial(client, page, group) async {
  var dir = await getTemporaryDirectory();
  File file = File(dir.path + "/social.json");
  if (file.existsSync()) {
    print("file exists");
    DateTime update = await file.lastModified();
    var now = new DateTime.now();
    if (page == 0) {
      if (update.day == now.day) {
        print("Fetching social from cache");
        var cachedSocial = file.readAsStringSync();
        return parseSocial(cachedSocial);
      }
    } else {
      print("go for updates");
      return updateSocial(client, page, group);
    }
  } else {
    print("go for updates");
    return updateSocial(client, page, group);
  }
}

savePost({message, image, group}) async {
  try {
    final storage = FlutterSecureStorage();
    String token = await storage.read(key: "token");
    final tokenHeaders = {'token': token};
    var postUri = Uri.parse("$apiUrl/api/v1/social_posts");
    print("group: $group");
    print(postUri);
    String fileName = image.path
        .split('/')
        .last;

    FormData data = FormData.fromMap({
      "image": await MultipartFile.fromFile(
        image.path,
        filename: fileName,
      ),
      "message": message,
      "group":group

    });

    Dio dio = new Dio();
    dio.options.headers = tokenHeaders;
    Response response = await dio.post("$postUri", data: data);

    if (response != null) {
      print(response);
      return false;
    } else {
      return true;
    }
  }on TimeoutException catch (_) {
    // A timeout occurred.
  } on SocketException catch (_) {
    // Other exception
  }
}
saveVideoPost({message, image, video, group}) async {
  try {
    final storage = FlutterSecureStorage();
    String token = await storage.read(key: "token");
    final tokenHeaders = {'token': token};
    var postUri = Uri.parse("$apiUrl/api/v1/social_posts");
    print("group: $group");
    print(postUri);
    String fileName = image.path
        .split('/')
        .last;
    String videoName = image.path
        .split('/')
        .last;
    FormData data = FormData.fromMap({
      "video": await MultipartFile.fromFile(
        video.path,
        filename: videoName,
      ),
      "image": await MultipartFile.fromFile(
        image.path,
        filename: fileName,
      ),
      "message": message,
      "group":group

    });

    Dio dio = new Dio();
    dio.options.headers = tokenHeaders;
    Response response = await dio.post("$postUri", data: data);

    if (response != null) {
      print(response);
      return false;
    } else {
      return true;
    }
  }on TimeoutException catch (_) {
    // A timeout occurred.
  } on SocketException catch (_) {
    // Other exception
  }
}
Future submitSupportTicket(message)async {
  final storage = FlutterSecureStorage();
  String token = await storage.read(key: "token");
  final tokenHeaders = {'token': token, 'content-type': 'application/json'};
  final msg = jsonEncode({"message": message});
  final response = await http.post(
    "$apiUrl/api/v1/support_messages",
    headers: tokenHeaders,
    body: msg,
  );
  print(response.body);
}

newPostComment(postId, comment)async{
  final storage = FlutterSecureStorage();
  String token = await storage.read(key: "token");
  final tokenHeaders = {'token': token, 'content-type': 'application/json'};
  var url = "$apiUrl/api/v1/comments";
  final msg = jsonEncode({"comment": "$comment", "post_id":postId});
  final response = await http.post(
    url,
    headers: tokenHeaders,
    body: msg,
  );
  print(response.body);
  return response.body;
}


Future <List<Map>> updateSocial(http.Client client, page, group) async {
  final storage = FlutterSecureStorage();
  String token = await storage.read(key: "token");
  final tokenHeaders = {'token': token, 'content-type': 'application/json'};
  var url;
  if (group != null){
    print("We have a group");
    print(group);
    url = "$apiUrl/api/v1/social_posts?page=$page&group=$group";
  }
  else {
    print("no group");
    url = "$apiUrl/api/v1/social_posts?page=$page";
    print(token);
  }
  final response = await client.get(
    url, headers: tokenHeaders,
  );

  if (response != null) {
    if (response.statusCode == 200) {
      print("updated social from api");
      print(response.body);
      if (page== 1) {
        print("update file");
        var dir = await getTemporaryDirectory();
        File file = File(dir.path + "/social.json");
        file.writeAsStringSync(
            response.body, flush: true, mode: FileMode.write);
      }
      print(response.body);
      return parseSocial(response.body);
    } else {
      print("social not updated from api");
      print(response.body);
      return null;
    }
  }else{
    return null;
  }
}
Future mostRecentPostTime(http.Client client) async {
  final storage = FlutterSecureStorage();
  String token = await storage.read(key: "token");
  print(token);
  final tokenHeaders = {'token': token, 'content-type': 'application/json'};
  var url = "$apiUrl/api/v1/social_posts/recent";

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
  var url = "$apiUrl/api/v1/post_bumps";

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
  var url = "$apiUrl/api/v1/post_bumps";

  final msg = jsonEncode({"bump": "false", "post_id":"$postId"});
  print(msg);
  final response = await http.put(
    url,
    headers: tokenHeaders,
    body: msg,
  );
  print(response.body);

}






import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

import 'dart:io';
import 'package:dio/dio.dart';

import 'api_login.dart';

http.Client client;
String baseUrl = 'https://limitlessguru.herokuapp.com/api/v1';
// String localUrl = 'http://localhost:3000/api/v1';

List<Map> parseSocial(String responseBody) {
  final responseJson = utf8.decode(responseBody.runes.toList());
  print (responseJson);
  final parsed = json.decode(responseJson).cast<Map<String, dynamic>>();
  return parsed;
}

Future<List<Map>> fetchSocial(client, page) async {
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
      return updateSocial(client, page);
    }
  } else {
    print("go for updates");
    return updateSocial(client, page);
  }
}

savePost({message, image}) async {
  try {
    final storage = FlutterSecureStorage();
    String token = await storage.read(key: "token");
    final tokenHeaders = {'token': token};
    var postUri = Uri.parse("$baseUrl/social_posts");
    print(postUri);
    String fileName = image.path
        .split('/')
        .last;
    final msg = [{"message": message, "image": image}];

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
    "$baseUrl/support_messages",
    headers: tokenHeaders,
    body: msg,
  );
  print(response.body);
}
newPostComment(postId, comment)async{
  final storage = FlutterSecureStorage();
  String token = await storage.read(key: "token");
  final tokenHeaders = {'token': token, 'content-type': 'application/json'};
  var url = "$baseUrl/comments";
  final msg = jsonEncode({"comment": "$comment", "post_id":postId});
  final response = await http.post(
    url,
    headers: tokenHeaders,
    body: msg,
  );
  print(response.body);
  return response.body;
}


Future <List<Map>> updateSocial(http.Client client, page) async {
  final storage = FlutterSecureStorage();
  String token = await storage.read(key: "token");
  final tokenHeaders = {'token': token, 'content-type': 'application/json'};
  var url = "$baseUrl/social_posts?page=$page";
  print(token);

  final response = await client.get(
    url, headers: tokenHeaders,
  );

  if (response != null) {
    if (response.statusCode == 200) {
      print("updated social from api");

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





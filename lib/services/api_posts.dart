
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:async' show Future;
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_url.dart';


Future<String> postImage(_image, id) async{
  final storage = FlutterSecureStorage();
  String token = await storage.read(key: "token");
  final tokenHeaders = {'token':token};
  var postUri = Uri.parse("$apiUrl/api/v1/users/$id");
  String fileName = _image.path.split('/').last;
    FormData data = FormData.fromMap({
      "avatar": await MultipartFile.fromFile(
        _image.path,
        filename: fileName,
      ),
    });

    Dio dio = new Dio();
    dio.options.headers = tokenHeaders;
    Response response = await dio.put("$postUri", data: data);
    print("respond here");
    final avatarUrl = response.data["avatar"].toString();
    return avatarUrl;
  }

Future<String>markedViewed(videoId, seconds) async {

  final storage = FlutterSecureStorage();
  String token = await storage.read(key: "token");
  final tokenHeaders = {'token': token, 'content-type': 'application/json'};
  DateTime now = DateTime.now();
  print(now);
  final msg = jsonEncode({"video_id": videoId, "last_second_viewed":seconds, "date":"$now"});
  final response = await http.post(
      "$apiUrl/api/v1/viewings",
      headers: tokenHeaders,
      body: msg,
    );
  print(response.body);
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
    "$apiUrl/api/v1/users",
    headers: tokenHeaders,
    body: msg,
  );
  // print (response.body);
  return null;

}

Future<String>updateUser(update) async {

  final storage = FlutterSecureStorage();
  String token = await storage.read(key: "token");
  final tokenHeaders = {'token': token, 'content-type': 'application/json'};
  print(update);
  final msg = jsonEncode({"username": update[1], "description":update[2], "email":update[3], "joincode":update[4]});
  print(msg);
  int userId = int.parse(update[0]);
  print (userId);
  String thisUrl = "$apiUrl/api/v1/users/$userId";

  final response = await http.put(
    "$thisUrl",
    headers: tokenHeaders,
    body: msg,
  );
  print (response.body);
  return "success";
}

Future<String>addUserToGroup(joinCode) async {

  final storage = FlutterSecureStorage();
  String token = await storage.read(key: "token");
  final tokenHeaders = {'token': token, 'content-type': 'application/json'};
  final msg = jsonEncode({"joincode": joinCode});
  String thisUrl = "$apiUrl/api/v1/groups";
  final response = await http.post(
    "$thisUrl",
    headers: tokenHeaders,
    body: msg,
  );
  print(response.statusCode);
  if (response.statusCode == 201){
    print("we good");
    var parsedJson = json.decode(response.body);
    var res = parsedJson['json'];
    var group = res['group'];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("group", group);
    print ("success");
    return "success";
  }
  else {
    var parsedJson = json.decode(response.body);
    try {
      var res = parsedJson['json'];
      var message = res['messages'];
      return message;
    } catch (e) {
      return "user already joined";
    }
  }

}

Future<String>removeUserGroup(group) async {
  print('here');
  final storage = FlutterSecureStorage();
  String token = await storage.read(key: "token");
  final tokenHeaders = {'token': token, 'content-type': 'application/json'};
  final msg = jsonEncode({"group": group});

  String thisUrl = "$apiUrl/api/v1/groups";
  final response = await http.put(
    thisUrl,
    headers: tokenHeaders,
    body: msg,
  );
  if (response.statusCode == 200){
    print(response.body);
    print("success");
    return "success";
  }else
    print("try");
  print(response.body);
    var parsedJson = json.decode(response.body);
    try {
      var res = parsedJson['json'];
      var message = res['messages'];
      return message;
    } catch(e){
      return "other issue";
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

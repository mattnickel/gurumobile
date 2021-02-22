

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
String baseUrl = 'https://limitlessguru.herokuapp.com/api/v1';


markAndOrHideContent(postId, {hideOnly=true})async{
    final storage = FlutterSecureStorage();
    String token = await storage.read(key: "token");
    final tokenHeaders = {'token': token, 'content-type': 'application/json'};
    final msg = jsonEncode({"post_id": postId, "hide_only":hideOnly});
    final response = await http.post(
      "$baseUrl/bad_posts",
      headers: tokenHeaders,
      body: msg,
    );
    print(response.body);
    return null;
}

blockUserContent(blockedUserId)async{
  final storage = FlutterSecureStorage();
  String token = await storage.read(key: "token");
  final tokenHeaders = {'token': token, 'content-type': 'application/json'};
  final msg = jsonEncode({"blocked_user_id": blockedUserId});
  print("blocking user $blockedUserId");
  final response = await http.post(
    "$baseUrl/blocked_users",
    headers: tokenHeaders,
    body: msg,
  );
  print(response.body);
  return null;
}
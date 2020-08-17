import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:async' show Future;
import 'dart:convert';

import '../models/video_model.dart';
import 'dart:io';

String url = 'https://aqueous-sierra-56433.herokuapp.com/api/v1/videos';

List<Video> parseVideos(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  final parsedList = parsed.map<Video>((json)=> Video.fromJson(json)).toList();
  return parsedList;
}
Future<List<Video>> fetchVideos(http.Client client, category) async {

  final response =  await client.get(url);

  if (response.statusCode == 200) {
    //If the call to the server was successful, parse the JSON.
   return compute(parseVideos, response.body);

  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}
//Future<Video> getVideo() async{
//  final response = await http.get('$url/1');
//  return postFromJson(response.body);
//}
//
//Future<http.Response> createPost(Post post) async{
//  final response = await http.post('$url',
//      headers: {
//        HttpHeaders.contentTypeHeader: 'application/json',
//        HttpHeaders.authorizationHeader : ''
//      },
//      body: postToJson(post)
//  );
//  return response;
//}

//Future<String> _callApi() async {
//  return await url;
//}
//
//Future getVideos() async {
//  String jsonPhotos = await _callApi();
//  final jsonResponse = json.decode(jsonPhotos);
//  videosList VideosList = videosList.fromJson(jsonResponse);
//  print("videos " + videosList.photos[0].title);
//}

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:async' show Future;
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';


// String url = 'https://limitlessguru.herokuapp.com/api/v1/videos';
String baseUrl = 'https://limitlessguru.herokuapp.com/api/v1';
String localUrl = 'http://localhost:3000/api/v1';

Future<String> postImage(_image) async{
  var jsonResponse;
  final storage = FlutterSecureStorage();
  String token = await storage.read(key: "token");
  final tokenHeaders = {'token': token};
  var postUri = Uri.parse("$localUrl/users/1");
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
    print(response);
    String avatar = await response.data[0]["avatar"];
    print(avatar);
    return avatar;
  }





  // var request = http.MultipartRequest(
  //     "PUT",
  //     postUri
  // );
  //List<int> imageBytes = await _imagePath.readAsBytes();
  // print(imageBytes);
  // String base64Image = base64Encode(imageBytes);

  // request.fields['user'] = 'blah';
  // request.files.add(
  //     await http.MultipartFile.fromPath('avatar', _imagePath, contentType: MediaType('image', 'png'))
  // );
  // // request.headers.addAll(tokenHeaders);
  // http.StreamedResponse response = await request.send();

  // request.send().then((response) {
  //   print (response.statusCode);
  //   if (response.statusCode == 200) {
  //     print("Uploaded!");
  //   }
  // });
// }

Future<String>markedViewed(videoId, seconds) async {

  final storage = FlutterSecureStorage();
  String token = await storage.read(key: "token");
  final tokenHeaders = {'token': token, 'content-type': 'application/json'};
  DateTime now = DateTime.now();
  print(now);
  final msg = jsonEncode({"video_id": videoId, "last_second_viewed":seconds, "date":"$now"});
  final response = await http.post(
      "$baseUrl/viewings",
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
    "$baseUrl/users",
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
  final msg = jsonEncode({"first_name": update[1], "description":update[2], "email":update[3]});
  print(msg);
  int userId = int.parse(update[0]);
  print (userId);
  String thisUrl = "$localUrl/users/$userId";
  print(thisUrl);

  final response = await http.put(
    "$thisUrl",
    headers: tokenHeaders,
    body: msg,
  );
  print (response.body);
  return "success";

}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../services/api_calls2.dart';
import '../featured.dart';
import 'login_screen.dart';


const SERVER_IP = 'http://localhost:3000/api/v1';
final storage = FlutterSecureStorage();

Future<String> attemptLogIn(String username, String password) async {
  var response = await http.post (
    '$SERVER_IP/login',
    body: {
      "username": username,
      "password": password
    },
  );
    if(response.statusCode == 200) {
      return response.body;
      } else {
        return null;
      }
    }
Future<int> attemptSignUp(String username, String password) async {
  var res = await http.post(
      '$SERVER_IP/signup',
      body: {
        "username": username,
        "password": password
      }
  );
  return res.statusCode;

}


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:async' show Future;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sidebar_animation/screens/start_screen.dart';

import '../screens/set_goals.dart';
import '../framework_page.dart';
import '../screens/login_screen.dart';
import '../screens/signup_screen.dart';

import '../main.dart';

String authUrl = "https://limitlessguru.herokuapp.com/api/v1/";
String localUrl = "http://localhost:3000/api/v1/";

checkLoginStatus(context) async {
  final storage = FlutterSecureStorage();
  String token = await storage.read(key: "token");
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String firstName = prefs.getString("firstName");

  if(token != null && firstName != null ) {
    // await fetchRandom(http.Client(), "For $firstName Today");
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
        builder: (BuildContext context) => FrameworkPage()), (
        Route<dynamic> route) => false);
  }else {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => StartScreen()), (
        Route<dynamic> route) => false);
  }
}
Future setLocals(response) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var jsonResponse = json.decode(response.body);
  print(jsonResponse);
  // print("here");
  String userId = jsonResponse["id"].toString();
  print(userId);
  String authToken = jsonResponse["authentication_token"] as String;
  String userEmail = jsonResponse["email"] as String;
  String firstName = jsonResponse["first_name"] as String;
  String tagLine = jsonResponse["description"] as String;
  String avatarUrl = jsonResponse["avatar"] as String;
  final storage = FlutterSecureStorage();
  await storage.write(key:"token", value: authToken);
  await storage.write(key:"email", value: userEmail);
  prefs.setString("userId", userId);
  prefs.setString("firstName", firstName);
  prefs.setString("email", userEmail);
  prefs.setString("tagLine", tagLine);
  prefs.setString("avatarUrl", avatarUrl);
}
Future signIn(String email, String pass, context, prefs) async {

  String errorMessage;
  String loginUrl = authUrl +"login";

  final response = await http.post(
    loginUrl,
    headers: {"Accept": "Application/json"},
    body: {"email": email, "password": pass},

  );
  if(response.statusCode == 200){
    await setLocals(response);
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => FrameworkPage()), (Route<dynamic> route) => false);
  }else{
    print("nope");
    errorMessage = "Oops... incorrect email or password";
    print(response.body);
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => LoginPage(errorMessage)));
  }
}


Future signUp(String email, String pass, String firstName, context) async {

  String signUpUrl = authUrl +'signup';

  final response = await http.post(
    signUpUrl,
    headers: {"Accept": "Application/json"},
    body: {"email":email, "password":pass, "first_name":firstName},
  );
  if(response.statusCode == 200) {
    await setLocals(response);
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => SetGoals()), (Route<dynamic> route) => false);
  }else{
    print("nope");
    print(response.body);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignupPage()));
  }
}
Future signOut(context) async {
  String signoutUrl = authUrl +'logout';
  final storage = FlutterSecureStorage();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String userEmail = await storage.read(key: "email");
  await http.post(
    signoutUrl,
    headers: {"Accept": "Application/json"},
    body: {"email":userEmail},
  );
  await storage.deleteAll();
  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => MainApp()), (Route<dynamic> route) => false);
}

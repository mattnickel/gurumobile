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
  // String localUrl = "http://localhost:3000/api/v1/";

Future setLocals(response) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var jsonResponse = json.decode(response.body);
  String userId = jsonResponse["id"].toString();
  print("setting locals");
  String authToken = jsonResponse["authentication_token"] as String;
  String userEmail = jsonResponse["email"] as String;
  String username = jsonResponse["username"] as String;
  String tagLine = jsonResponse["description"] as String;
  String avatarUrl = jsonResponse["avatar"] as String;
  print (username);
  final storage = FlutterSecureStorage();
  await storage.write(key:"token", value: authToken);
  await storage.write(key:"email", value: userEmail);
  prefs.setString("userId", userId);
  prefs.setString("username", username);
  prefs.setString("email", userEmail);
  prefs.setString("tagLine", tagLine);
  prefs.setString("avatarUrl", avatarUrl);
  return null;
}
Future signIn(String email, String pass, context, prefs) async {

  String errorMessage;
  String loginUrl = authUrl +"login";
  // String loginUrl =  localUrl +"login";

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


Future signUp(String email, String pass, String username, context) async {

  String signUpUrl = authUrl +'signup';
  final response = await http.post(
    signUpUrl,
    headers: {"Accept": "Application/json"},
    body: {"email":email, "password":pass, "username":username},
  );
  if(response.statusCode == 200) {
    await setLocals(response);
    print(response.body);
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => FrameworkPage()), (Route<dynamic> route) => false);
    // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => SetGoals()), (Route<dynamic> route) => false);
  }else{
    print("nope");
    print(response.body);
    var jsonMessage = json.decode(response.body);
    String error = jsonMessage["error"].toString();
    print(error);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignupPage(error)));
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

Future createVerificationCode(email)async{
  String params = "email="+email;
  String url = authUrl + 'passwords/forgot?'+params;
  var response = await http.get(
    url,
    headers: {"Accept": "Application/json"},
  );
  if(response.statusCode == 200) {
    print(response.body);
    return true;
  }else{
    print("nope");
    print(response.body);
    return false;
  }
}

Future confirmReset(code)async{
  final storage = FlutterSecureStorage();


  String params = "verify="+code;

  String url = authUrl + 'passwords/confirm?'+params;
  var response = await http.get(
    url,
    headers: {"Accept": "Application/json"},
  );
  if(response.statusCode == 200) {
    await storage.write(key:"resetToken", value: code);
    print(response.body);
    return true;
  }else{
    print("nope");
    print(response.body);
    return false;
  }
}
Future setPasswordAndLogin(password, context) async{
  final storage = FlutterSecureStorage();
  String resetToken= await storage.read(key:"resetToken");
  String url = authUrl + 'passwords/reset';

  final response = await http.put(
    url,
    headers: {"Accept": "Application/json"},
    body: {"reset":resetToken, "password":password},
  );
  if(response.statusCode == 200) {
    await setLocals(response);
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => FrameworkPage()), (Route<dynamic> route) => false);
    print(response.body);
    return true;
  }else{
    print("nope");
    print(response.body);
    return false;
  }
}
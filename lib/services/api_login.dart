import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:async' show Future;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../framework_page.dart';
import '../screens/login_screen.dart';
import '../screens/signup_screen.dart';

import '../main.dart';

String auth_url = "https://limitlessguru.herokuapp.com/api/v1/";
// String local_url = "http://localhost:3000/api/v1/";

Future signIn(String email, String pass, context, prefs) async {
  String errorMessage;
  final storage = FlutterSecureStorage();
  String login_url = auth_url +"login";
  SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http.post(
      login_url,
      headers: {"Accept": "Application/json"},
      body: {"email": email, "password": pass},
    );
    var jsonResponse = json.decode(response.body);
    if(response.statusCode == 200) {

      print("success");
      String auth_token = jsonResponse["data"]["authentication_token"] as String;
      String user_email = jsonResponse["data"]["email"] as String;
      String first_name = jsonResponse["data"]["first_name"] as String;
      String tag_line = jsonResponse["data"]["description"] as String;
      String avatar_url = jsonResponse["data"]["avatar"] as String;

      await storage.deleteAll();
      await storage.write(key:"token", value: auth_token);
      await storage.write(key:"email", value: user_email);
      prefs.setString("first_name", first_name);
      prefs.setString("tag_line", tag_line);
      prefs.setString("avatar_url", avatar_url);
      print(prefs.getString(first_name));
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => FrameworkPage()), (Route<dynamic> route) => false);
    }else{
      print("nope");
      errorMessage = "Oops... incorrect email or password";
      print(response.body);
      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => LoginPage(errorMessage)));
    }
  }


Future signUp(String email, String pass, String firstName, context) async {

  String signup_url = auth_url +'signup';
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final response = await http.post(
    signup_url,
    headers: {"Accept": "Application/json"},
    body: {"email":email, "password":pass, "first_name":firstName},
  );

  var jsonResponse = json.decode(response.body);
  print(jsonResponse);
  if(response.statusCode == 200) {
    String auth_token = jsonResponse["data"]["authentication_token"] as String;
    String user_email = jsonResponse["data"]["email"] as String;
    String first_name = jsonResponse["data"]["first_name"] as String;
    String tag_line = jsonResponse["data"]["description"] as String;
    String avatar_url = jsonResponse["data"]["avatar"] as String;
    final storage = FlutterSecureStorage();
    await storage.write(key:"token", value: auth_token);
    await storage.write(key:"email", value: user_email);
    print("success");
    print(jsonResponse["data"]);

    prefs.setString("first_name", first_name);
    prefs.setString("tag_line", tag_line);
    prefs.setString("avatar_url", avatar_url);

    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => FrameworkPage()), (Route<dynamic> route) => false);
  }else{
    print("nope");
    print(response.body);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignupPage()));
  }
}
Future signOut(context) async {
  String signoutUrl = auth_url +'logout';
  final storage = FlutterSecureStorage();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String userEmail = await storage.read(key: "email");("userEmail");
  await http.post(
    signoutUrl,
    headers: {"Accept": "Application/json"},
    body: {"email":userEmail},
  );
  prefs?.clear();
  await storage.deleteAll();
  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => MainApp()), (Route<dynamic> route) => false);
}

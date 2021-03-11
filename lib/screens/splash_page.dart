import 'dart:core';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:sidebar_animation/framework_page.dart';
import 'package:sidebar_animation/screens/start_screen.dart';
import 'dart:async';
import '../services/api_login.dart';
import '../services/api_calls2.dart';



class SplashPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return SplashPageState();
  }
}

class SplashPageState extends State<SplashPage> {
  Image splashImage;
  @override
  Future<void> initState() {
    super.initState();
    splashImage = Image.asset('assets/images/adventure3.png', width: 500, gaplessPlayback: true,);
    getCategories(http.Client());
    checkLoginStatus(context);
  }

  static Future checkLoginStatus(context)async {
    final storage = FlutterSecureStorage();
    String token;
    try {
      token = await storage.read(key: "token");
    } catch (exception) {
      storage.deleteAll();
    }
    if(token != null) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
          builder: (BuildContext context) => FrameworkPage()), (
          Route<dynamic> route) => false);
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => StartScreen()), (
          Route<dynamic> route) => false);
    }
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: splashImage.image,
                  fit:BoxFit.cover
              )
            )
          ),
          Center (
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black54),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text("Loading Neutral Thinking...",
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    )),
                  )
                ],
              )
          ),
      ]
    )
    );
  }
}
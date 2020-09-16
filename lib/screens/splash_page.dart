import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sidebar_animation/pages/home.dart';
import '../framework_page.dart';
import '../services/api_calls2.dart';
import '../featured.dart';
import 'login_screen.dart';


class SplashPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return SplashPageState();
  }
}

class SplashPageState extends State<SplashPage> {
  Image splashImage;

  @override
  void initState() {
    super.initState();
    splashImage = Image.asset('assets/images/adventure3.png', width: 500, gaplessPlayback: true,);
    loadData();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future<Timer> loadData() async {
    return Timer(
        Duration(seconds: 3),
        onDoneLoading);
  }
  checkLoginStatus() async {
    print("here");
    final storage = FlutterSecureStorage();
    String token = await storage.read(key: "token");
    print(token);
    if(token != null) {
      print("logged in");
      await updateVideos(http.Client(), "For Today");
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => FrameworkPage()), (Route<dynamic> route) => false);
    }else {
      print("logged out");
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage("")), (
          Route<dynamic> route) => false);
    }
  }

  onDoneLoading() async {
    checkLoginStatus();
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
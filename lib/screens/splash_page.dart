import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sidebar_animation/framework_page.dart';
import '../featured.dart';
import 'login_screen.dart';


class SplashPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return SplashPageState();
  }
}

class SplashPageState extends State<SplashPage> {

  SharedPreferences sharedPreferences;
  Image splashImage;

  @override
  void initState() {
    super.initState();
    splashImage = Image.asset('assets/images/adventure.png', width: 500, gaplessPlayback: true,);
    loadData();
//    checkLoginStatus();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();


  }
  Future<Timer> loadData() async {
    return Timer(
        Duration(seconds: 5),
        onDoneLoading);
  }
  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginPage()), (Route<dynamic> route) => false);
    }else
      TodayFeature();
  }

  onDoneLoading() async {
    checkLoginStatus();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
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
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text("Loading Neutral Thinking...",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    )),
                  )
                ],
              )),
//        child: Stack(
//                children: <Widget>[
//                Positioned.fill(
//                child:
//                )
//                ]
//            ),

    ]
    )
    );
  }
}
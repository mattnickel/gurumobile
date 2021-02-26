import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
  String firstName;
  bool skipLogin;

  @override
  Future<void> initState() {
    super.initState();
    splashImage = Image.asset('assets/images/adventure3.png', width: 500, gaplessPlayback: true,);
    // Firebase.initializeApp().whenComplete(() {
    //   print("completed");
    //   setState(() {});
    // });
    getCategories(http.Client());
    checkLoginStatus(context);
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
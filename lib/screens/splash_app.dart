import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:sidebar_animation/screens/simple_splash.dart';
import 'dart:async';
import 'package:get/get.dart';
import 'package:sidebar_animation/screens/splash_page.dart';
import 'package:sidebar_animation/services/api_calls2.dart';

import '../framework_page.dart';
import 'login_screen.dart';


class SplashApp extends StatefulWidget {
  final VoidCallback onInitializationComplete;

  const SplashApp({
    Key key,
    @required this.onInitializationComplete,
  }) : super(key: key);

  @override
  _SplashAppState createState() => _SplashAppState();
}

class _SplashAppState extends State<SplashApp> {
  bool _hasError = false;


  @override
  void initState() {
    super.initState();
    _initializeAsyncDependencies();
  }

  Future<void> _initializeAsyncDependencies() async {
    print("initializing");

    final skipLogin = await checkLoginStatus();
    if (skipLogin) {
      await updateVideos(http.Client(), "For Today");
      await updateVideos(http.Client(), "Continue Watching");
      await updateVideos(http.Client(), "Trending Videos");
      await updateVideos(http.Client(), "Recommended Videos");
    } else {
     GetMaterialApp(home:LoginPage(""));
    }
    print("done initializing");
    await widget.onInitializationComplete();
  }
  Future<bool> checkLoginStatus() async {
    final storage = FlutterSecureStorage();
    String token = await storage.read(key: "token");
    if (token != null) {
      return true;
    }
    else {
      return false;
    }
  }
  // Future navigateNext(skipLogin){
  //   skipLogin
  //       ? Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
  //         builder: (BuildContext context) => FrameworkPage()), (
  //         Route<dynamic> route) => false)
  //       : Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
  //         builder: (BuildContext context) => LoginPage("")), (
  //         Route<dynamic> route) => false);
  // }


  @override
  Widget build(BuildContext context) {
    return
      MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            primaryColor: Colors.white,
            splashColor: Color(0xFF00ebcc),
          ),
          home: SimpleSplashPage()
      );

  }
}
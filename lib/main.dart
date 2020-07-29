import 'package:flutter/material.dart';

import './pages/framework_page.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
//  Future<List<Video>>futureVideos;
//  @override
//  void initState() {
//    final futureVideos = fetchVideos(http.Client());
//  }
  Widget build(BuildContext context) {
    return
      MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.white
      ),
      home: FrameworkPage(),
    );
  }
}
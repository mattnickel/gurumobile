import 'package:flutter/material.dart';
import './media_widgets/video_player_screen.dart';


class TodayFeature extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            primaryColor: Colors.white
        ),
        home: VideoPlayerScreen(),
      );
  }
}
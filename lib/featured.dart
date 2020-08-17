import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sidebar_animation/media_widgets/video_player_screen.dart';
import 'models/navbar_tab_selected_model.dart';

import 'sidebar/sidebar_layout.dart';

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
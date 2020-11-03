import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widgets/flutter_widgets.dart';
import 'package:sidebar_animation/services/api_posts.dart';
import 'package:video_player/video_player.dart';


import 'landscape_player_controls.dart';

class FlickVideoScreen extends StatefulWidget {
  int positionValue;
  String videoFile;
  int videoId;
  FlickVideoScreen(this.videoFile, this.videoId);

  @override
  _FlickVideoScreenState createState() => _FlickVideoScreenState(

  );
}

class _FlickVideoScreenState extends State<FlickVideoScreen> {
  FlickManager flickManager;

  @override
  void initState() {
    super.initState();

    flickManager = FlickManager(
      videoPlayerController:
      VideoPlayerController.network(widget.videoFile),

    );
    // void positionValue = flickManager.flickVideoManager.videoPlayerController.value.position;
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
          children:<Widget>[
            Center(
              child: AspectRatio(
                aspectRatio:16/9,
                child: FlickVideoPlayer(

                      flickManager: flickManager,

                        preferredDeviceOrientationFullscreen: [
                        DeviceOrientation.landscapeLeft,
                        DeviceOrientation.landscapeRight,
                      ],
                      systemUIOverlay: [],
                      flickVideoWithControls: FlickVideoWithControls(
                        controls:FlickLandscapeControls(),
                      ),
                ),
              ),
            ),

            Positioned(
              top:40,
              right:10,
              child: IconButton(
                  icon:Icon(Icons.close),
                  color: Colors.white,
                  onPressed: () {
                    setState(() {

                      widget.positionValue = flickManager.flickVideoManager.videoPlayerController.value.position.inSeconds;
                    });
                    markedViewed(widget.videoId, widget.positionValue);
                    Navigator.of(context).pop();
                    print(widget.positionValue);
                  }
              ),
            ),

      ]
      ),
    );

  }


}
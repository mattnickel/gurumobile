import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widgets/flutter_widgets.dart';
import 'package:sidebar_animation/screens/social_post_screen.dart';
import 'package:sidebar_animation/services/api_posts.dart';
import 'package:video_player/video_player.dart';


import 'landscape_player_controls.dart';

class FlickVideoScreen extends StatefulWidget {
  int positionValue;
  final String videoFile;
  final int videoId;
  final String image;
  FlickVideoScreen(this.videoFile, this.videoId, this.image);

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
    flickManager.flickVideoManager.videoPlayerController.addListener(checkVideo);
    // void positionValue = flickManager.flickVideoManager.videoPlayerController.value.position;
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }
  void checkVideo(){
    if(flickManager.flickVideoManager.videoPlayerController.value.position == flickManager.flickVideoManager.videoPlayerController.value.duration) {
      print('video Ended');
      // Navigator.of(context).push(PageRouteBuilder(
      //     opaque: false,
      //     pageBuilder: (BuildContext context, _, __) =>
      //         SocialPostScreen()));
    }

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
            // Positioned(
            //   top:100,
            //   right:10,
            //   child: IconButton(
            //       icon:Icon(Icons.tag_faces),
            //       color: Colors.white,
            //       onPressed: () {
            //         Navigator.of(context).push(PageRouteBuilder(
            //             opaque: false,
            //             pageBuilder: (BuildContext context, _, __) =>
            //                 SocialPostScreen(image: widget.image)));
            //       }
            //   ),
            // ),
      ]
      ),
    );

  }


}
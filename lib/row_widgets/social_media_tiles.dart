import 'package:cached_network_image/cached_network_image.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';

// ignore: non_constant_identifier_names
Container SocialVideoTile(video){
  FlickManager flickManager = FlickManager(
    videoPlayerController:
    VideoPlayerController.network(video),

  );
  flickManager.flickVideoManager.videoPlayerController.setVolume(0.0);
    return Container(
        height:double.infinity,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(17.0),
          child:
          AspectRatio(
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
            // Image.network(image,
            // height: 100,
            // width:100,
            // fit: BoxFit.cover)
        );
  }
CachedNetworkImage SocialImageTile(image) {
  return CachedNetworkImage(
    imageUrl: image,
    imageBuilder: (context, imageProvider) => Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
            ),
      ),
    ),
    placeholder: (context, url) => Center(child: CircularProgressIndicator()),
    errorWidget: (context, url, error) => Icon(Icons.error),
  );
}


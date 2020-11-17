// import 'package:flutter/material.dart';
// import 'package:flick_video_player/flick_video_player.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_widgets/flutter_widgets.dart';
// import 'package:sidebar_animation/models/training_module_course_model.dart';
// import 'package:sidebar_animation/services/api_posts.dart';
// import 'package:video_player/video_player.dart';
//
//
// import 'landscape_player_controls.dart';
//
// class PlaylistManager extends StatefulWidget {
//   int positionValue;
//   List<Videos> videoList;
//   int _next;
//   PlaylistManager(this.videoList, this._next);
//
//   @override
//   _PlaylistManagerState createState() => _PlaylistManagerState(
//
//   );
// }
//
// class _PlaylistManagerState extends State<PlaylistManager> {
//   FlickManager flickManager;
//
//   @override
//   void initState() {
//     super.initState();
//     flickManager = FlickManager(
//       videoPlayerController:
//       VideoPlayerController.network(widget.videoList[widget._next].file),
//     );
//     // void positionValue = flickManager.flickVideoManager.videoPlayerController.value.position;
//   }
//
//
//   @override
//   void dispose() {
//     flickManager.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Container(
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height,
//         child: Stack(
//             children:<Widget>[
//               Center(
//                 child: AspectRatio(
//                   aspectRatio:16/9,
//                   child: FlickVideoPlayer(
//
//                         flickManager: flickManager,
//
//                           preferredDeviceOrientationFullscreen: [
//                           DeviceOrientation.landscapeLeft,
//                           DeviceOrientation.landscapeRight,
//                         ],
//                         systemUIOverlay: [],
//                         flickVideoWithControls: FlickVideoWithControls(
//                           controls:FlickLandscapeControls(),
//                         ),
//                   ),
//                 ),
//               ),
//
//               Positioned(
//                 top:40,
//                 right:10,
//                 child: IconButton(
//                     icon:Icon(Icons.close),
//                     color: Colors.white,
//                     onPressed: () {
//                       setState(() {
//                         widget.positionValue = flickManager.flickVideoManager.videoPlayerController.value.position.inSeconds;
//                       });
//                       markedViewed(widget.videoList[widget._next].id, widget.positionValue);
//                       Navigator.of(context).pop();
//
//                     }
//                 ),
//               ),
//               Padding(
//                   padding: const EdgeInsets.only(top:220.0),
//                   child: Align(
//                       alignment:Alignment.topCenter,
//                       child: Text("${widget.videoList[widget._next].title}",
//                           style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold))
//                   )),
//                 Padding(
//                   padding: const EdgeInsets.only(top:250.0),
//                   child: Align(
//                     alignment:Alignment.topCenter,
//                     child: Text("${widget._next + 1} of ${widget.videoList.length}",
//                       style: TextStyle(color: Colors.white, fontSize: 16))
//     )),
//                   Padding(
//                       padding: const EdgeInsets.only(bottom:48.0),
//                       child: Align(
//                         alignment:Alignment.bottomCenter,
//                         child: widget._next +1 == widget.videoList.length
//                     ? RaisedButton(elevation: 0.2,
//                       color: Color(0xff00eebc),
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 20.0, right:20, top:10.0, bottom:10.0),
//                         child: Text(("Done").toUpperCase(),
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold)
//                         ),
//                       ),
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
//                       onPressed: () {
//                         setState(() {
//                           widget.positionValue = flickManager.flickVideoManager.videoPlayerController.value.position.inSeconds;
//                         });
//                         Navigator.of(context).pop();
//                         markedViewed(widget.videoList[widget._next].id, widget.positionValue);
//                       }
//                     )
//                       : RaisedButton(elevation: 0.2,
//                           color: Color(0xff00eebc),
//                           child: Padding(
//                               padding: const EdgeInsets.only(left: 20.0, right:20, top:10.0, bottom:10.0),
//                               child: Text(("Next Video").toUpperCase(),
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold
//                                 )
//                               ),
//                           ),
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
//                           onPressed: () {
//                             setState(() {
//                               widget.positionValue = flickManager.flickVideoManager.videoPlayerController.value.position.inSeconds;
//                             });
//                             int nextVideo = widget._next + 1;
//                             Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
//                               return PlaylistManager(widget.videoList, nextVideo);
//                             }));
//                             markedViewed(widget.videoList[widget._next].id, widget.positionValue);
//                           }
//                           )
//                 ),
//               ),
//
//         ]
//         ),
//       ),
//     );
//
//   }
//
//
// }
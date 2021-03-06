import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sidebar_animation/media_widgets/flick_manager.dart';
import 'package:sidebar_animation/models/video_model.dart';



class BigTiles extends StatelessWidget {

 Video video;


  BigTiles({ this.video});
  bool hasViewed = false;

  @override
  Widget build(BuildContext context) {
    return Wrap(
        children: <Widget>[
          Container(
              margin: const EdgeInsets.all(10.0),
              height: 550,
              width: MediaQuery.of(context).size.width - 40,
              child: Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(18.0),
                    child:
                    // Container(
                    //     decoration: BoxDecoration(
                    //       image: DecorationImage(
                    //           image: NetworkImage(video.image),
                    //           fit: BoxFit.cover,
                    //           colorFilter:
                    //           ColorFilter.mode(Colors.black38, BlendMode.darken)),
                    //     ),
                    //   ),
                    CachedNetworkImage(
                      imageUrl: '${video.image}',
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                              colorFilter:
                              ColorFilter.mode(Colors.black38, BlendMode.darken)),
                        ),
                      ),
                      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  Positioned(
                      top: 20,
                      right:20,
                      child:
                      hasViewed
                          ? Icon(
                        Icons.check_box,
                        size: 35.0,
                        color: Colors.white38,
                      ) : SizedBox()
                  ),
                  Center(
                    child: RawMaterialButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return FlickVideoScreen(video.file, video.id, video.image, video.socialImage);
                        }));
                      },
                      elevation: 2.0,
                      child: Icon(
                        Icons.play_circle_filled,
                        size: 55.0,
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.all(15.0),
                      shape: CircleBorder(),
                    )

                  ),
                  Positioned(
                    bottom: 50,
                    left:10,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 40,
                      child: Text(
                          video.title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                          ),
                    ),
                  ),
                  Positioned(
                    bottom: 30,
                    left:10,
                    child: Text(
                        video.author != null ?
                        video.author : "unknown",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      )
                    ),
                  ),
                ],
              ),
          ),
        ],
    );
  }
}


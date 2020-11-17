import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sidebar_animation/media_widgets/flick_manager.dart';
import 'package:sidebar_animation/models/video_model.dart';



class VideoTiles extends StatelessWidget {

  List<Video> videos;
  int index;

  VideoTiles({ this.videos, this.index});
  bool hasViewed = false;
  @override
  Widget build(BuildContext context) {
    return Wrap(
        children: <Widget>[
          Container(
              margin: const EdgeInsets.all(10.0),
              height: 200,
              width: 300,
              child: Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(18.0),
                    child:
                    CachedNetworkImage(
                      imageUrl: videos[index].image,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                              colorFilter:
                              ColorFilter.mode(Colors.black38, BlendMode.darken)),
                        ),
                      ),
                      placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  Center(
                    child: RawMaterialButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          // return FlickVideoScreen(videos[index].file, videos[index].id);
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
                    child: Text(
                        videos[index].title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white)
                        ),
                  ),
                  Positioned(
                    bottom: 30,
                    left:10,
                    child: Text(
                        videos[index].author,
                      style: TextStyle(
                        color: Colors.white,
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


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vimeoplayer/vimeoplayer.dart';


class VimeoTiles extends StatelessWidget {

  List<dynamic> videos;
  int index;

  VimeoTiles({ this.videos, this.index});

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
                  VimeoPlayer(id:'${videos[index].vimeoId}'),
                  Center(
                    child: Icon(
                        Icons.play_circle_filled,
                        size: 54,
                        color: Colors.white,
                    ),

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


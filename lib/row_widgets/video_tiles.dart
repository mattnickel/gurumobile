import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VideoTiles extends StatelessWidget {

  List<String> videos;
  int index;

  VideoTiles({ this.videos, this.index});

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
                      Image.asset("assets/images/" + videos[index],
                      width: 300,
                      height: 200,
                      fit: BoxFit.cover,
                      color: Colors.black38,
                      colorBlendMode: BlendMode.darken,)
                  ),
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
                        "Video Name",
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
                      "Author Name",
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


import 'package:flutter/material.dart';

import 'video_tiles.dart';

class VideoRow extends StatelessWidget {
  String category;
  List<String> videos;
  int index;

  VideoRow({ this.category, this.videos, this.index});

  @override
  Widget build(BuildContext context) {
    return
    Wrap(
        children: <Widget>[
          Row(children: [
            Container(
              margin: EdgeInsets.only(left: 20.0, bottom:10.0),
              child: Text(
                  category,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  )
              ),
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.only(right: 10.0),
              child: Icon(
                Icons.chevron_right,
                color: Colors.redAccent,
              ),
            ),
          ],
          ),
          Container(
              margin: EdgeInsets.only(left: 10.0, bottom:30.0),
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: videos.length,
                itemBuilder: (context, index) {
                  return VideoTiles(
                    videos: videos,
                    index: index,
                  );
                },
              )
          ),
        ]
    );
  }
}
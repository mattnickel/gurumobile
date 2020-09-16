import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;


import 'package:sidebar_animation/models/video_model.dart';
import 'package:sidebar_animation/services/api_calls2.dart';

import 'video_tiles.dart';

class VideoRow extends StatelessWidget {

  String category;
  List<String> videos;
  int index;

  VideoRow({ this.category, this.videos, this.index});

  @override
  Widget build(BuildContext context) {
    return
      FutureBuilder<List<Video>>(
          future: checkThenUpdateVideos(http.Client(), category),
          builder: (context, snapshot) {

            if(snapshot.connectionState == ConnectionState.done) {

              if(snapshot.hasError)print(snapshot.error);

              return snapshot.hasData
                  ? Wrap(
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
                            color: Color(0xFF00ebcc),
                          ),
                        ),
                      ],),
                      Container(
                          margin: EdgeInsets.only(left: 10.0, bottom:30.0),
                          height: 220,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data == null ? 0 : snapshot.data.length,
                            itemBuilder: (context, index) {
                              return VideoTiles(
                                videos: snapshot.data,
                                index: index,
                              );
                            },
                          )
                      )
                    ]
                  )
                  : Center(child: Text("Woah"));

            }
            else
              return CircularProgressIndicator();
          }
      );
  }
}
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';


import 'package:sidebar_animation/models/video_model.dart';
import 'package:sidebar_animation/services/api_calls2.dart';

import 'big_tiles.dart';

class BigRow extends StatelessWidget {

  String category;
  List<String> videos;
  int index;

  BigRow({ this.category, this.videos, this.index});

  @override
  Widget build(BuildContext context) {
    return
      FutureBuilder<List<dynamic>>(
          future: fetchVideos(http.Client(), category),
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
                          height: 575,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data == null ? 0 : snapshot.data.length,
                            itemBuilder: (context, index) {
                              return BigTiles(
                                videos: snapshot.data,
                                index: index,
                              );
                            },
                          )
                      )
                    ]
                  )
                  : Center(child: Text("Nothing new today"));

            }
            else
              return Wrap(
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
                        height: 575,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            Container(
                               margin: const EdgeInsets.all(10.0),
                                height: 550,
                                width: MediaQuery.of(context).size.width - 40,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(18.0),
                                child: Shimmer.fromColors(
                                  baseColor: Colors.black54,
                                  highlightColor: Colors.black45,
                                    child: Container(
                                      color: Colors.black54
                                  )
                              )
                            )
                    )
                  ]
              )
            )
         ]
              );
          }
      );
  }
}
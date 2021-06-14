import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';


import 'package:sidebar_animation/models/video_model.dart';
import 'package:sidebar_animation/services/api_calls2.dart';

import 'big_game_tiles.dart';
import 'big_tiles.dart';

class BigGameRow extends StatelessWidget {

  String category;
  List<String> videos;
  int index;

  BigGameRow({ this.category, this.index});

  @override
  Widget build(BuildContext context) {
    return
      Wrap(
          children: <Widget>[
            Row(children: [
              Container(
                margin: EdgeInsets.only(left: 20.0, bottom: 10.0),
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
                margin: EdgeInsets.only(left: 10.0, bottom: 30.0),
                height: 575,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return BigGameTiles(

                    );
                  },
                )
            )
          ]
      );
  }
}
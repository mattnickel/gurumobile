import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sidebar_animation/row_widgets/course_list.dart';

class CourseTiles extends StatelessWidget {

  List<dynamic> trainingModules;
  int index;

  CourseTiles({ this.trainingModules, this.index});

  @override

  Widget build(BuildContext context) {

    return Wrap(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(10.0),
            height: 365,
            width: 300,
            child: Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(18.0),
                  child:
                  CachedNetworkImage(
                    imageUrl: trainingModules[index].coverPhoto,
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
                        Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => CourseList(module:trainingModules[index])));
                      },
                      elevation: 2.0,
                      child: Icon(
                      Icons.play_circle_filled,
                      size: 55.0,
                      color: Colors.white,
                      ),
                      padding: EdgeInsets.all(15.0),
                      shape: CircleBorder(),
                    ),
                    ),
                Positioned(
                  bottom: 50,
                  left:10,
                  child: Text(
                      trainingModules[index].title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white)
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left:10,
                  width: 300,
                  child: Text(
                      trainingModules[index].description,
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white)
                  ),
                ),
              ],
            ),
          ),
        ],
    );
  }
}


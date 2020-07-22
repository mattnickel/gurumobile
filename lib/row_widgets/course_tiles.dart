import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CourseTiles extends StatelessWidget {

  List<String> courses;
  int index;

  CourseTiles({ this.courses, this.index});

  @override
  Widget build(BuildContext context) {
    return Wrap(
        children: <Widget>[
          Container(
              margin: const EdgeInsets.all(10.0),
              height:350,
              width: 250,
              child: Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(18.0),
                    child:
                      Image.asset("assets/images/" + courses[index],
                      width: 250,
                      height: 350,
                      fit: BoxFit.cover,
                      color: Colors.black38,
                      colorBlendMode: BlendMode.darken,)
                  ),
                  Positioned(
                    top: 20,
                    left: 10,
                    child: Icon(Icons.account_circle,
                    color: Colors.white,
                    size: 64,
                    )
                  ),
                  Positioned(
                      top: 35,
                      left: 80,
                      child: Text(
                          "Author Name",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize:16,
                        ),
                      )
                  ),
                  Positioned(
                      top: 55,
                      left: 80,
                      child: Text(
                        "Author Tagline",
                        style: TextStyle(
//                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize:14,
                        ),
                      )
                  ),
                  Positioned(
                    bottom: 100,
                    left:20,
                    child: Text(
                            "Course Name",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: Colors.white)
                            ),
                  ),
                  Positioned(
                    bottom: 80,
                    left:20,
                        child: Text(
                          "Course Description",
                          style: TextStyle(
                            color: Colors.white,
                          )
                        ),
                      ),
                    ],
                  )
              )
        ],
    );
  }
}


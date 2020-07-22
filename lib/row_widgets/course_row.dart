import 'package:flutter/material.dart';

import 'course_tiles.dart';


class CourseRow extends StatelessWidget {
  String category;
  List<String> courses;
  int index;

 CourseRow({ this.category, this.courses, this.index});
  @override
  Widget build(BuildContext context) {
    return
    Column(
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
              child: Icon(
                Icons.chevron_right,
                color: Colors.redAccent,
              ),
            ),
          ],
          ),
          Container(
              margin: EdgeInsets.only(left: 10.0, bottom:30.0),
              height: 370,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  return CourseTiles(
                    courses: courses,
                    index: index,
                  );
                },
              )
          ),
        ]
    );
  }
}
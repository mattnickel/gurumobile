import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sidebar_animation/models/training_module_course_model.dart';
import 'package:sidebar_animation/services/api_calls2.dart';
import 'package:http/http.dart' as http;
import 'course_tiles.dart';


class CourseRow extends StatelessWidget {
  String category;
  List<String> trainingModules;
  int index;

 CourseRow({ this.category, this.trainingModules, this.index});
  @override
  Widget build(BuildContext context) {

    return
      FutureBuilder<List<TrainingModule>>(
          future: fetchCourses(http.Client(),category),
          builder: (context, snapshot) {

            if(snapshot.connectionState == ConnectionState.done)  {

              if(snapshot.hasError)print(snapshot.error);

              return snapshot.hasData
                  ? Column(
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
                              color: Color(0xFF00ebcc),
                            ),
                          ),
                        ],
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 10.0, bottom:30.0),
                            height: 380,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data == null ? 0 : snapshot.data.length,
                              itemBuilder: (context, index) {
                                return CourseTiles(
                                  trainingModules: snapshot.data,
                                  index: index,
                                );
                              },
                            )
                        ),
                      ]
                    )
                  : Center(child: Text("No courses available"));
            }
            else
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
                            color: Color(0xFF00ebcc),
                          ),
                        ),
                      ],
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 10.0, bottom:30.0),
                          height: 380,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              Wrap(
                                  children: <Widget>[
                                    Container(
                                      margin: const EdgeInsets.all(10.0),
                                      height: 365,
                                      width: 300,
                                        child: Stack(
                                          children: <Widget>[
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(18.0),
                                              child: Shimmer.fromColors(
                                                baseColor: Colors.black54,
                                                highlightColor: Colors.black45,
                                                child: Container(
                                                        color: Colors.black54
                                                )
                                              )
                                            )
                                          ]
                                        )
                                      )

                                    ]
                              )
                            ]

                          )
                      ),
                    ]
                );
          }
      );
  }
}

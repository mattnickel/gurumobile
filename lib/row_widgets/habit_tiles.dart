import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sidebar_animation/helpers/database_helpers.dart';

class HabitTiles extends StatelessWidget {

  List<Habit> habits;
  int index;

 HabitTiles({ this.habits, this.index});

  @override
  Widget build(BuildContext context) {
    return Wrap(
        children: <Widget>[
          Container(
             padding:EdgeInsets.only(left:10),
              margin: EdgeInsets.only(left: 5.0, bottom: 30.0),
              height: 120,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(18.0),
                  child: Stack(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [0.0, 0.24, 0.7],
                              colors: [
                                Color(0xFFffffff),
                                Color(0xFFc4ece7),
                                Color(0xFF60f2df),
                              ],
                            ),
                          ),
                        width: 120,
                        height: 120,
                        child: Center(
                            child: Text(habits[index].time,
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 22.0,
                              color: Colors.white,
                            ))

                        )
                      ),
                      Positioned(
                          left:40.0,
                          bottom: 25.0,
                          child: Text("DAILY",
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 16.0,
                              color: Colors.white70
                              ),
                              textAlign: TextAlign.center,
                          )
                      ),
                      Align(
                        alignment:Alignment.bottomCenter,
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          width: 120,
                          child: Text(habits[index].habit.toUpperCase(),
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 16.0,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ), Positioned(
                        right:5.0,
                        child: Switch(
                            value: true,
                            onChanged: (value) {

                            },
                            activeTrackColor: Colors.white70,
                            activeColor: Colors.white,
                          ),
                        ),
                    ],
                  ),
                ),
              )
        ],
    );
  }
}


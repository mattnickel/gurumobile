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
              margin: EdgeInsets.only(left: 5.0, bottom: 30.0),
              height: 120,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(18.0),
                  child: Stack(
                    children: [
                      Container(
                        color: Colors.greenAccent,
                        width: 120,
                        height: 120,
                        child: Center(
                            child: Icon(Icons.add_circle,
                              color: Colors.black26,
                              size: 55,)

                        ),
                      ),
                      Align(
                        alignment:Alignment.bottomCenter,
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          width: 120,
                          child: Text(habits[index].habit,
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black54),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
        ],
    );
  }
}


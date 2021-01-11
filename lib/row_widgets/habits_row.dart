import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../popups/habit_popup.dart';
import '../services/local_notifications_manager.dart';
import '../helpers/database_helpers.dart';
import './habit_tiles.dart';


class HabitsRow extends StatefulWidget {
  String category;
  List<String> habits;
  int index;

  HabitsRow({ this.category, this.habits, this.index});
  @override
  _HabitsRowState createState() => _HabitsRowState();

}

class _HabitsRowState extends State<HabitsRow> {
  final habitController = TextEditingController();
  final timeController = TextEditingController();
  final localNotifications = LocalNotificationsManager.init();
  String addIt;

  @override
  void dispose() {
    habitController.dispose();
    timeController.dispose();
    super.dispose();
  }

  Container addHabitWidget(){
    return Container(
        height: 120,
        child: FlatButton(
          onPressed: ()async {
            await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return habitPopup(
                      "New Habit Reminder", context);
                }
            );

            setState(() {
              addIt = "true";
            });
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18.0),
            child: Stack(
              children: [
                Container(
                  color: Colors.black12,
                  width: 120,
                  height: 120,
                  child: Center(
                      child: Icon(Icons.add_circle,
                        color: Colors.black26,
                        size: 45,)

                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    width: 120,
                    child: Text("Add Habit",
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
    );
  }

  @override
  Widget build(BuildContext context) {
    _read() async {
      DatabaseHelper helper = DatabaseHelper.instance;
      List<Habit> habitList = await helper.queryAll();
      return habitList;
    }
    return FutureBuilder <List<Habit>>(
        future: _read(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              padding: EdgeInsets.only(top:25),
              child: Column(
                children: <Widget>[
                  Row(children: [
                    Container(
                      margin: EdgeInsets.only(left: 20.0, bottom: 10.0),
                      child: Text(
                          widget.category,
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
                  snapshot.hasData
                      ? Container(
                      margin: EdgeInsets.only(left: 5.0, bottom: 30.0),
                      height: 120,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot == null ? 1 : snapshot.data.length +1,
                        itemBuilder: (context, index) {
                          if (index == snapshot.data.length || index == null){
                            return addHabitWidget();
                          }
                          return HabitTiles(
                            habits: snapshot.data,
                            index: index,
                          );
                        },
                      )
                  )
                      : Container()
                ],
              ),
            );
          } else
            return
              Wrap(
                  children: <Widget>[
                    Row(children: [
                      Container(
                        margin: EdgeInsets.only(left: 20.0, bottom: 10.0),
                        child: Text(
                            widget.category,
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
                        height: 200,
                        width: 200,
                        child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              Container(
                                  margin: const EdgeInsets.all(10.0),
                                  height: 120,
                                  width: 120,
                                  child: Stack(
                                      children: <Widget>[
                                        ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                18.0),
                                            child: Shimmer.fromColors(
                                                baseColor: Colors.black54,
                                                highlightColor: Colors.black45,
                                                child: Container(
                                                    color: Colors.black12
                                                )
                                            )
                                        )
                                      ]
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
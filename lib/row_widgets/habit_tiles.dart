import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import '../helpers/database_helpers.dart';
import '../services/local_notifications_manager.dart';

class HabitTiles extends StatefulWidget {

  List<Habit> habits;
  int index;
  bool isSwitched;

 HabitTiles({ this.habits, this.index});

  @override
  _HabitTilesState createState() => _HabitTilesState();
}

class _HabitTilesState extends State<HabitTiles> {
  bool here;
  final localNotifications = LocalNotificationsManager.init();

  updateIt(id, activity){
      DatabaseHelper helper = DatabaseHelper.instance;
      helper.updateHabitActivity(id, activity);
  }
  deleteIt(id){
    DatabaseHelper helper = DatabaseHelper.instance;
    helper.deleteHabit(id);
  }
  cancelIt(id){
    localNotifications.turnOffNotificationById(id);
  }
  restoreIt()async{
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String today = formatter.format(now);
    // DateTime best = DateFormat.jm().parse(timeController.text);
    DateTime best = DateFormat.jm().parse(widget.habits[widget.index].time);
    DateTime bester = calcTime(best);
    localNotifications.showDailyNotification(widget.habits[widget.index].id, widget.habits[widget.index].description, bester);
    return true;
  }
  DateTime calcTime(time){
    DateTime now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String today = formatter.format(now);
    var timeFormatter = new DateFormat("HH:mm");
    print("ouch_");
    String militaryTime = timeFormatter.format(time);
    print(militaryTime);
    String bestest = today+" "+militaryTime;
    DateTime best = DateTime.parse(bestest);
    if (best.isBefore(DateTime.now())){
      best = best.add(Duration(days:1));
      print(best);
    }
    return best;
  }
 @override
  void initState() {
    here = true;
    widget.habits[widget.index].active > 0
        ? widget.isSwitched = true
        : widget.isSwitched = false;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Visibility(
      visible: here,
      child: Wrap(
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
                            decoration:
                            widget.isSwitched ? BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                stops: [0.0, 0.24, 0.9],
                                colors: [
                                  Color(0xFFffffff),
                                  Color(0xFFc4ece7),
                                  Color(0xFF09eebc),
                                ],
                              ),
                            )
                            : BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                stops: [0.0, 0.24, 0.9],
                                colors: [
                                  Colors.black12,
                                  Colors.black12,
                                  Colors.black26,
                                ],
                              ),
                            ),
                          width: 120,
                          height: 120,
                          child: Center(
                              child: Text(widget.habits[widget.index].time,
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 22.0,
                                color: Colors.white,
                              ))

                          )
                        ),
                        widget.isSwitched
                            ?  Positioned(
                          right:55,
                          child:Container(),

                        )
                        :Positioned(
                            right:55,
                            child: FlatButton(
                                child: Icon(Icons.cancel,
                                    color: Colors.black26),
                                onPressed:(){
                                    deleteIt(widget.habits[widget.index].id);
                                    setState((){
                                      here = false;
                                      print("cool");
                                    });
                                })


                        ),
                        Positioned(
                            left:40.0,
                            bottom: 25.0,
                            child: Text("DAILY",
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 14.0,
                                color: Colors.white
                                ),
                                textAlign: TextAlign.center,
                            )
                        ),
                        Align(
                          alignment:Alignment.bottomCenter,
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            width: 120,
                            child: Text(widget.habits[widget.index].habit.toUpperCase(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14.0,
                                  color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ), Positioned(
                          right:5.0,
                          child: Switch(
                              value:  widget.isSwitched,
                              onChanged: (value)async {
                                updateIt(widget.habits[widget.index].id, value);
                                if (value == false) {
                                  cancelIt(widget.habits[widget.index].id);
                                }else {
                                  restoreIt();
                                }

                                setState(() {
                                  widget.isSwitched = value;
                                  print( widget.isSwitched);
                                });

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
      ),
    );
  }
}


import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sidebar_animation/helpers/database_helpers.dart';
import 'package:sidebar_animation/pages/manage_habits.dart';
import 'package:sidebar_animation/row_widgets/habit_tiles.dart';

import 'guru_tiles.dart';

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

  @override
  void dispose() {
    habitController.dispose();
    timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _read() async {
      print("hello");
      DatabaseHelper helper = DatabaseHelper.instance;
      List<Habit> habitList = await helper.queryAll();
      print(habitList.length);
      return habitList;
    }
    return FutureBuilder <List<Habit>>(
        future: _read(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            print(snapshot);
            return Column(
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
                    margin: EdgeInsets.only(left: 10.0, bottom: 30.0),
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot == null ? 0 : snapshot.data.length,
                      itemBuilder: (context, index) {
                        return HabitTiles(
                          habits: snapshot.data,
                          index: index,
                        );
                      },
                    )
                )
                    : Container(),
                Row(
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 5.0, bottom: 30.0),
                        height: 120,
                        child: FlatButton(
                          onPressed: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(builder: (context) => ManageHabits())
                            // );
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return habitPopup(
                                      "New Habit Reminder", context);
                                }
                            );
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
                                        size: 55,)

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
                    ),
                  ],
                ),

              ],
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
                        width: 330,
                        child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              Container(
                                  margin: const EdgeInsets.all(10.0),
                                  height: 365,
                                  width: 300,
                                  child: Stack(
                                      children: <Widget>[
                                        ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                18.0),
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
                    )
                  ]
              );
        }
        );
  }


  habitPopup(title, context) {
    final habitFormKey = GlobalKey<FormState>();
    String _habit;
    DateTime _habitTime;
    final List<Map<String, dynamic>> _items = [
      {
        'value': 'gratitude',
        'label': 'Gratitude Habit',
        'text' : 'gratitude'
      },
      {
        'value': 'objective',
        'label': 'Daily Objective',
        'text' : 'objective'
      },
      {
        'value': 'affirmations',
        'label': 'Affirmations',
        'enable': false,
        'text' : 'affirmations'
      },
    ];

    void saveIssue(selected_habit, time) async{
      String selected_description;
      print('here');
      // habitFormKey.currentState.save();
      Habit newHabit;
      if (selected_habit =="gratitude"){
        selected_description = 'What are you grateful for today?';
      }else if (selected_habit == "objective"){
        selected_description = 'What is your one objective for today?';
      } else {
        selected_description = 'Did you accomplish this today?';
      };
      newHabit.habit = selected_habit;
      newHabit.description = selected_description;
      newHabit.time =time;
      newHabit.active =true;
      print('still moving');
      print("time is $time");
      DatabaseHelper helper = DatabaseHelper.instance;
      int id = await helper.insert(newHabit);
      print('inserted row: $id');
      print(newHabit.time);
    }
    final format = DateFormat.jm();
    return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
          contentPadding: EdgeInsets.only(left: 25, right: 25),
          title: Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),

              ),
            ),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))
          ),
          content: Container(
            child: SingleChildScrollView(
                child: Form(
                  key:habitFormKey,
                  child: Column(
                      children: <Widget>[
                        SelectFormField(
                          controller: habitController,
                          // initialValue: _items[0],
                          decoration: InputDecoration(
                              labelText: "Select Habit:",
                            // labelStyle: TextStyle(fontSize: 12.0),
                          ),
                          labelText: "Select Habit:",
                          items: _items,
                          onChanged:(val){
                            setState(() {});
                          },
                          onSaved: (input) => _habit = input),
                        DateTimeField(
                          controller: timeController,
                          format: format,
                          initialValue: DateFormat('dd-MM-yyyy h:mm:ssa', 'en_US')
                              .parseLoose('01-11-2020 7:00:00AM'),
                          decoration: InputDecoration(
                              labelText: "Select Time:"
                          ),
                          onShowPicker: (context, currentValue) async {
                            final time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay(hour: 07, minute: 00),
                            );
                            return DateTimeField.convert(time);
                          },
                            onChanged:(tex){
                              setState(() {});
                            },
                            onSaved: (input) => _habitTime = input
                        ),

                      ]
                  ),
                )
            ),
          ),
          actions: <Widget>[
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: Align(
                alignment: Alignment.center,
                child:
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.60,
                  child: RaisedButton(
                    child: Text(
                      'SAVE',

                      style: TextStyle(color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),

                    ),
                    color: Color(0xff00eebc),
                    disabledColor: Color.fromRGBO(0,238,188, 0.25),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    onPressed:  habitController.text ==''|| timeController.text =='' ? null : () async {
                      saveIssue(habitController.text,timeController.text);
                      Navigator.of(context).pop();

                    },
                  ),
                ),

              ),
            ),
          ]
      );

  }
    );
  }


}
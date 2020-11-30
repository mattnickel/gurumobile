import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';


class ManageHabits extends StatefulWidget {

  @override
  _ManageHabitsState createState() => _ManageHabitsState();
}

class _ManageHabitsState extends State<ManageHabits> {
  final timeController = TextEditingController();
  final habitController = TextEditingController();
  @override
  void initState() {
    super.initState();
    // timeController.addListener();
    // habitController.addListener();
  }

  Widget build(BuildContext context) {

    return Scaffold(
          body: Stack(
              children: <Widget>[
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.1, 0.7, 0.9],
                        colors: [
                          Color(0xFFffffff),
                          Color(0xFFc4ece7),
                          Color(0xFF60f2df),
                        ],
                      ),
                    ),
                ),
                Positioned(
                    top: 20,
                    left: -20,
                    child: RawMaterialButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      elevation: 2.0,
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 25.0,
                        color: Colors.black87,
                      ),
                ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 20.0, right: 20.0),
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                          "Habit Builder".toUpperCase(),
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 28,
                            fontFamily: "Druk",
                            // fontWeight: FontWeight.w800,
                          )
                      )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 100, left: 40.0, right: 40.0),
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                              "\"People don't decide their futures. People decide their habits and their habits decide their future.\"\n -   FM Alexander",
                              style: TextStyle(color: Colors.black87,fontSize: 18,)
                          ),
                        ),
                      )
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 40.0, left:60, right:60),
                    child: RaisedButton(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(Icons.add),
                            Spacer(),
                            Text("Daily Gratitude Habit",
                                style: TextStyle(color: Colors.black87,fontSize: 22,)
                    ),

                          ],
                        ),
                      ),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
                      onPressed: (){
                          showDialog(
                          context:context,
                          builder:(BuildContext context){
                          return habitPopup("New Habit Reminder", context);
                          }
    );}

                ),
                  )
                ),

                ]
            )
        );
  }

  AlertDialog habitPopup(title, context) {
    final format = DateFormat.jm();
    return AlertDialog(
        contentPadding: EdgeInsets.only(left: 25, right: 25),
        title: Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: 15),
            child: Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),

            ),),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        content: Container(
          child: SingleChildScrollView(
              child: Column(
                  children: <Widget>[
                    // Container(
                    //   child: Text("Pick a time that works best for you."),
                    //
                    // ),
                    DateTimeField(
                      controller: timeController,
                      format: format,
                      initialValue: DateFormat('dd-MM-yyyy h:mm:ssa', 'en_US').parseLoose('01-11-2020 7:00:00AM'),
                      onShowPicker: (context, currentValue) async {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay(hour: 07, minute: 00),
                        );
                        return DateTimeField.convert(time);
                      },
                    ),

                  ]
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
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  onPressed: habitController.text == "" || timeController.text == "" ? null :() {
                    //saveIssue();
                    Navigator.of(context).pop();
                  },
                ),
              ),

            ),
          ),
        ]
    );
  }
}
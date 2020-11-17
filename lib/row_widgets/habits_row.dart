import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sidebar_animation/pages/manage_habits.dart';
import 'package:sidebar_animation/row_widgets/habit_tiles.dart';

import 'guru_tiles.dart';

class HabitsRow extends StatelessWidget {
  String category;
  List<String> habits;
  int index;

  HabitsRow({ this.category, this.habits, this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(children: [
          Container(
            margin: EdgeInsets.only(left: 20.0, bottom: 10.0),
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
        // Container(
        //     margin: EdgeInsets.only(left: 10.0, bottom:30.0),
        //     height: 120,
        //     child: ListView.builder(
        //       scrollDirection: Axis.horizontal,
        //       itemCount: habits == null ? 0 : habits.length,
        //       itemBuilder: (context, index) {
        //         return HabitTiles(
        //           habits: habits,
        //           index: index,
        //         );
        //       },
        //     )
        // ),
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
                    context:context,
                    builder:(BuildContext context){
                      return habitPopup("Schedule Gratitude Reminder", context);
                    }
                  );
              },

                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18.0),
                  child: Container(
                    color: Colors.black12,
                    width: 120,
                    height: 120,
                    child: Center(
                        child: Icon(Icons.add_circle,
                          color: Colors.white54,
                          size: 38,)

                    ),
                  ),
                ),
              )
            ),
          ],
        ),
      ],
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
                      format: format,
                      initialValue: DateFormat('dd-MM-yyyy h:mm:ssa', 'en_US')
                          .parseLoose('01-11-2020 7:00:00AM'),
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
                  onPressed: () {
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
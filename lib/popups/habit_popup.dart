import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:select_form_field/select_form_field.dart';
import '../helpers/database_helpers.dart';
import '../services/local_notifications_manager.dart';



habitPopup(title, context) {
  final localNotifications = LocalNotificationsManager.init();
  final habitFormKey = GlobalKey<FormState>();
  final habitController = TextEditingController();
  final timeController = TextEditingController();
  String _habit;
  DateTime _habitTime;
  // _HabitsRowState parent;
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
      'text' : 'affirmations'
    },
  ];
  DateTime calcTime(time){
    DateTime now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String today = formatter.format(now);
    var timeFormatter = new DateFormat("HH:mm");
    String militaryTime = timeFormatter.format(time);
    print(militaryTime);
    String bestest = today+" "+militaryTime;
    DateTime best = DateTime.parse(bestest);
    print(now);
    if (best.isBefore(DateTime.now())){
      print("it's before");
      best = best.add(Duration(days:1));
    }
    return best;
  };
  void saveIssue(selectedHabit, time, timeValue) async{
    String selectedDescription;
    if (selectedHabit =="gratitude"){
      selectedDescription = 'What are you grateful for today?';
    }else if (selectedHabit == "objective"){
      selectedDescription = 'What is your one objective for today?';
    } else {
      selectedDescription = 'Remember: You are smart. You are tough. You can do hard things.';
    };
    Habit newHabit=Habit();
    newHabit.time = time;
    newHabit.habit = selectedHabit;
    newHabit.description = selectedDescription;
    newHabit.active = 1;

    DatabaseHelper helper = DatabaseHelper.instance;
    int id = await helper.insert(newHabit);
    localNotifications.showDailyNotification(id, selectedDescription, timeValue);

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
                    key: habitFormKey,
                    child: Column(
                        children: <Widget>[
                          SelectFormField(
                              controller: habitController,
                              decoration: InputDecoration(
                                labelText: "Select Habit:",
                              ),
                              labelText: "Select Habit:",
                              items: _items,
                              onChanged: (val) {
                                setState(() {});
                              },
                              onSaved: (input) => _habit = input),
                          DateTimeField(
                              controller: timeController,
                              format: format,
                              initialValue: DateFormat(
                                  'dd-MM-yyyy h:mm:ssa', 'en_US')
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
                              onChanged: (tex) {
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
                      color: Color(0xff09eebc),
                      disabledColor: Color.fromRGBO(0, 238, 188, 0.25),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      onPressed: habitController.text == '' ||
                          timeController.text == '' ? null : () async {
                        DateTime best = DateFormat.jm().parse(
                            timeController.text);
                        DateTime bester = calcTime(best);
                        saveIssue(
                            habitController.text, timeController.text, bester);
                        Navigator.pop(context, 'yep');
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
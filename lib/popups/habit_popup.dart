import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:select_form_field/select_form_field.dart';
import '../helpers/habit_database_helpers.dart';
import '../services/local_notifications_manager.dart';



habitPopup(title, context) {
  final localNotifications = LocalNotificationsManager.init();
  final habitFormKey = GlobalKey<FormState>();
  final habitController = TextEditingController();
  final timeController = TextEditingController();
  final customTextController = TextEditingController();
  final customNameController = TextEditingController();
  bool selectSee = true;
  bool customSee = false;
  bool customTextSee = false;
  String _habit;
  bool affirmationLabel = false;
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
    {
      'value': "custom",
      'label': 'Custom Habit',
      'text':'',
    }
  ];
  //Make the selected date into a dateTime in the future
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
  }
  void saveIssue(selectedHabit, time, customName, customText, timeValue) async{
    String selectedDescription;
    if (selectedHabit =="gratitude"){
      selectedDescription = 'What are you grateful for today?';
    }else if (selectedHabit == "objective"){
      selectedDescription = customText;
    }else if (selectedHabit == "affirmations") {
        selectedDescription = customText;
    } else{
      selectedHabit = customName;
      selectedDescription = customText;
    }
    print(selectedHabit);
    Habit newHabit=Habit();
    newHabit.time = time;
    newHabit.habit = selectedHabit;
    newHabit.description = selectedDescription;
    newHabit.active = 1;
    //save in local database
    HabitDatabaseHelper helper = HabitDatabaseHelper.instance;
    int id = await helper.insert(newHabit);
    //save in device notifications
    localNotifications.showDailyNotification(id, selectedDescription, selectedHabit, timeValue);

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
                          Visibility(
                            visible: selectSee,
                            child: SelectFormField(
                                controller: habitController,
                                decoration: InputDecoration(
                                  labelText: "Select Habit:",
                                ),
                                labelText: "Select Habit:",
                                items: _items,
                                onChanged: (val) {
                                  print(val);
                                  setState(() {
                                    if (val == "custom") {
                                      selectSee = false;
                                      customSee = true;
                                      customTextSee = true;
                                    }else if(val == "affirmations"){
                                      affirmationLabel = true;
                                        selectSee = false;
                                        customSee = false;
                                        customTextSee = true;
                                      customTextController.text = "You are strong. You are smart. You got this.";
                                    }else if(val == "objective"){
                                    selectSee = false;
                                    customTextSee = true;
                                    customTextController.text = "What is the one thing you want to accomplish today?";
                                    }
                                    else {
                                      selectSee = true;
                                      customSee = false;
                                      customTextSee = false;
                                    }
                                  });
                                },
                                onSaved: (input) => _habit = input),
                          ),
                          Visibility(
                            visible: customSee,
                            child: TextFormField(
                              maxLength: 12,
                              controller: customNameController,
                              decoration: InputDecoration(
                                labelText: "Habit Name:",
                              ),

                            ),
                          ),
                          Visibility(
                            visible: customTextSee,
                            child: TextFormField(
                              controller: customTextController,
                              decoration: InputDecoration(
                                labelText: affirmationLabel ? "Your Affirmations:" :"Habit Text:"
                              ),
                            ),
                          ),
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
                        DateTime time = DateFormat.jm().parse(
                            timeController.text);
                        DateTime calculatedTime = calcTime(time);
                        saveIssue(
                            habitController.text,
                            timeController.text,
                            customNameController.text,
                            customTextController.text,
                            calculatedTime,
                        );
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
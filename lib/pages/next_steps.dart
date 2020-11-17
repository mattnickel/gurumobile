import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sidebar_animation/row_widgets/big_row.dart';
import 'package:sidebar_animation/row_widgets/guru_row.dart';
import 'package:sidebar_animation/row_widgets/habits_row.dart';
import '../row_widgets/video_row.dart';
import 'dart:async';
import 'dart:async' show Future;

class NextSteps extends StatefulWidget {

  @override
  _NextStepsState createState() => _NextStepsState();
}

class _NextStepsState extends State<NextSteps>{
  String firstName;

  Future <String> readName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('first_name');
  }


  @override
  void initState() {
    super.initState();
    readName().then((value) {
      setState(() {
        firstName = value;
      });
    });
  }



  @override
  Widget build(BuildContext context){
    return ListView(
      children:<Widget>[
        HabitsRow(category: "Daily Habits"),
        BigRow(category:"For $firstName Today"),
        // GuruRow(category: "Recommended Gurus", gurus:gurus),
        VideoRow(category:"Continue Watching"),
      ],
      );
  }

}



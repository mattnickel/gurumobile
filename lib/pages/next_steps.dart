import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sidebar_animation/row_widgets/big_row.dart';
import '../row_widgets/video_row.dart';
import 'dart:async';
import 'dart:async' show Future;

class NextSteps extends StatefulWidget {

  @override
  _NextStepsState createState() => _NextStepsState();
}

class _NextStepsState extends State<NextSteps>{
  String firstName;
  @override
  void initState() {
    super.initState();
    readName().then((value) {
      setState(() {
        firstName = value;
      });
    });
  }

  String category;
  List<String> videos = <String>[];
  List<String> gurus = <String>['guru1.png', 'guru2.png', 'guru3.png'];


  Future <String> readName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("first_name");
  }

  @override
  Widget build(BuildContext context){
    return ListView(
      children:<Widget>[
        BigRow(category:"For $firstName Today", videos:videos),
        // GuruRow(category: "Recommended Gurus", gurus:gurus),
        VideoRow(category:"Continue Watching", videos:videos),
      ],
      );
  }

}



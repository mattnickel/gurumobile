import 'package:flutter/material.dart';
import 'dart:async' show Future;


import '../row_widgets/big_row.dart';
import '../row_widgets/habits_row.dart';



class NextSteps extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    return  ListView(
        children:<Widget>[
          HabitsRow(category: "Daily Habits"),
          BigRow(category:"For Today"),
        ],
    );
  }

}



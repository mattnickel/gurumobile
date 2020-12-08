import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sidebar_animation/row_widgets/big_row.dart';
import 'package:sidebar_animation/row_widgets/guru_row.dart';
import 'package:sidebar_animation/row_widgets/habits_row.dart';
import '../row_widgets/video_row.dart';
import 'dart:async';
import 'dart:async' show Future;
import 'package:pull_to_refresh/pull_to_refresh.dart';


class NextSteps extends StatefulWidget {

  @override
  _NextStepsState createState() => _NextStepsState();
}

class _NextStepsState extends State<NextSteps>{
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  ScrollController _scrollController;
  String firstName;

  void _onRefresh() async{
    // call api
    if(mounted){
      setState(() {

      });
    }
    _refreshController.refreshCompleted();
  }
  void _onLoading() async{
    _refreshController.loadComplete();

  }

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
    return SmartRefresher(
      controller:_refreshController,
      onLoading: _onLoading,
      onRefresh: _onRefresh,
      enablePullDown: true,
      enablePullUp: true,
      child: ListView(
        children:<Widget>[
          HabitsRow(category: "Daily Habits"),
          BigRow(category:"For $firstName Today"),
          // GuruRow(category: "Recommended Gurus", gurus:gurus),
          // VideoRow(category:"Continue Watching"),
        ],
        ),
    );
  }

}



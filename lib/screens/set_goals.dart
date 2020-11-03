import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:notification_permissions/notification_permissions.dart';
import 'package:sidebar_animation/screens/signup_screen.dart';
import 'package:sidebar_animation/services/api_posts.dart';
import '../services/notifications_manager.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


class SetGoals extends StatefulWidget {

  @override
  _SetGoalsState createState() => _SetGoalsState();
}

class _SetGoalsState extends State<SetGoals> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  Future<String> permissionStatusFuture;
  var permGranted = "granted";
  var permDenied = "denied";
  var permUnknown = "unknown";
  var permProvisional = "provisional";

  // PushNotificationsManager push;

  @override



  List<String> goals =[
    "Practicing gratitude",
    "Reducing Negativity",
    "Staying neutral",
    "Overcoming adversity",
    "Making better choices",
    "Setting goals",
    "visualizing success",

  ];

  Future<String> getCheckNotificationPermStatus() {
    return NotificationPermissions.getNotificationPermissionStatus()
        .then((status) {
      switch (status) {
        case PermissionStatus.denied:
          return permDenied;
        case PermissionStatus.granted:
          return permGranted;
        case PermissionStatus.unknown:
          return permUnknown;
        case PermissionStatus.provisional:
          return permProvisional;
        default:
          return null;
      }
    });
  }
  Widget build(BuildContext context) {
    double tenPercentHeight = MediaQuery.of(context).size.height/20;
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
        child: Padding(
          padding: EdgeInsets.only(top: tenPercentHeight, left:22.0, right:22.0),
          child: Theme(
            data: ThemeData(canvasColor:Colors.transparent, shadowColor:Colors.white.withOpacity(0.2)),
            child: ReorderableListView(
              onReorder:(oldIndex, newIndex){
                setState((){
                  if (newIndex > oldIndex){
                    newIndex:-1;
                  }
                  final goal = goals.removeAt(oldIndex);
                  goals.insert(newIndex, goal);
                });
              },
                header: Padding(
                  padding: const EdgeInsets.only(bottom: 18.0, left:5, right: 5),
                  child: RichText(
                      text:TextSpan(
                          style: TextStyle(color:Colors.black),
                          children: <TextSpan>[
                          TextSpan(text: "What are your top goals?\n",
                            style:TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              height:3.0,
                            ),
                          ),
                        TextSpan(
                            style: TextStyle(color:Colors.black54),
                            text: "Reordering this list will help us recommend the right steps for getting started.")
                  ]),),
                ),
              children: <Widget>[
                for (final goal in goals)
                  Padding(
                    padding: const EdgeInsets.only(top:10.0),
                    key:ValueKey(goal),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25.0),
                      child: Card(
                        color: Colors.transparent,
                        shape:RoundedRectangleBorder(
                          side: BorderSide(color:Colors.black12, width:1.0),
                          borderRadius:BorderRadius.circular(10.0)
                        ),
                        // shadowColor:Colors.transparent,

                            child: ListTile(
                              selectedTileColor: Colors.white,
                              tileColor: Colors.white.withOpacity(0.35),
                              trailing: Icon(Icons.format_line_spacing),
                              title: Text(goal.toUpperCase()),
                            ),

                        ),
                    ),
                    ),
              ]
            ),
          ),
        )
        ),
          Padding(
            padding: const EdgeInsets.only(bottom: 60.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: RaisedButton(
                elevation: 2,
                color:Colors.white,
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width -100,
                  padding: EdgeInsets.only( top:15.0, bottom:15.0),
                  child: Align(
                      alignment:Alignment.center,
                      child: Text(
                          "Continue",
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 18,
                          )
                      )
                  ),
                ),

                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                onPressed: (){
                  // saveGoals(goals);
                  _firebaseMessaging.requestNotificationPermissions();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => SignupPage()),
                        (Route<dynamic> route) => false,
                  );
                },
              ),
            ),
          ),
            ]
          )
        );

  }
}

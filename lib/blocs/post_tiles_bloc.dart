import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_attachable/keyboard_attachable.dart';
import 'package:sidebar_animation/services/social_api.dart';


String convertTime(apiTime){
  print(apiTime);
  String time;
  DateTime now = new DateTime.now();
  var then = DateTime.parse(apiTime);
  var timeSpan = now.difference(then);
  if (timeSpan.inMinutes <= 59 ){
    if (timeSpan.inMinutes < 2){
      time = "now";
    }else {
      time = timeSpan.inMinutes.toString() + " min ago";
    }
  } else if (timeSpan.inHours < 24){
    if(timeSpan.inHours < 2){
      time = timeSpan.inHours.toString() + " hr ago";
    }else {
      time = timeSpan.inHours.toString() + " hrs ago";
    }
  } else if (timeSpan.inHours < 48){
    time = timeSpan.inDays.toString()  + " day ago";
  }else{
    time = timeSpan.inDays.toString()  + " days ago";
  }
  return time;
}

GestureDetector triggerKeyboardComment(context, postId){
  return  GestureDetector(
    onTap:(){
      Navigator.pop(context);
      },
    child: Scaffold(
      backgroundColor: Colors.transparent,
      body: FooterLayout(
            footer: Container(
              padding: const EdgeInsets.only(left: 20.0, bottom:10.0, top:10),
              color: Colors.white,

              child: TextField(
                 onSubmitted: (value){
                   if (value != null) {
                     newPostComment(postId, value);
                   }
                   Navigator.pop(context, value);
                 },
                autofocus: true,
                decoration: InputDecoration(
                border: InputBorder.none,
                 fillColor: Colors.white,
                 hintText: 'Add a comment...'
                ),
              ),
            ),
          ),
        ),
  );
}
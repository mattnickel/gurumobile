import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:async' show Future;
import 'package:notification_permissions/notification_permissions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../framework_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'new_game_screen.dart';


class GameOver extends StatefulWidget {
  int score;
  String allTimeHigh;
  String todaysHigh;

  GameOver({ this.score});
  @override
  _GameOverState createState() => _GameOverState();
}

class _GameOverState extends State<GameOver> {

String message;

void initState() {
  super.initState();
  getPrefs();
  setMessage(widget.score);
  // timeController.addListener();
  // habitController.addListener();
}
getPrefs()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    widget.todaysHigh = prefs.getString("highToday");
    widget.allTimeHigh = prefs.getString("allTimeHigh");

  }

setMessage(score){
  if (score > 200 && score<1){
    message = "Wow, you scored " + score.toString() +". You are a top performer!";
  } else if (score >150){
    message = score + "! That was impressive!";
  }else if (score >100){
    message = "You scored " + score.toString() +". That's pretty good.";
  }else if (score >50){
    message = "You scored " + score.toString() +". That's a good start, but you can do better.";
  }else if (score < 50 && score > 1){
    message = "You scored " + score.toString()+ ". Looks like you are having trouble concentrating. Try again?";
  }
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
          child: Center(
            child:
              Container(
              width: MediaQuery
              .of(context)
              .size
              .width * 0.80,
      child: Row(
        children: [
          RaisedButton(

            child: Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.3,
              child: Text(
                'Quit',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xff09eebc),
                    fontWeight: FontWeight.bold,
                    fontSize: 16),

              ),
            ),
            color: Colors.white,
            disabledColor: Color.fromRGBO(0, 238, 188, 0.25),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            onPressed: (){
              Navigator.of(context)
                ..pop();
            },
          ),
          Spacer(),
          RaisedButton(
            child: Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.3,
              child: Text(
                "Play Again",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),

              ),
            ),
            color: Color(0xff09eebc),
            disabledColor: Color.fromRGBO(0, 238, 188, 0.25),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            onPressed: (){
              Navigator.pushReplacement(context,
                  MaterialPageRoute(
                      builder: (context) => NewGameScreen(game:"Concentration Grid", todaysHigh: widget.todaysHigh, allTimeHigh: widget.allTimeHigh ,)));
            },
          ),
        ],
      ),
    ),
          )
          ),
          Positioned(

            width: MediaQuery.of(context).size.width,
              top: 200,
          child:
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: RichText(
                textAlign: TextAlign.center,
                text:TextSpan(
                    text: "Game Over \n",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.bold
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: message,
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                                  fontSize:16
                          )
                      ),
                    ]
                )
            ),
          ),
),

    ]
        ),

        );

  }
}

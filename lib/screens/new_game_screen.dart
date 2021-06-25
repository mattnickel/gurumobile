import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:share/share.dart';
import 'package:provider/provider.dart';
import 'package:circular_check_box/circular_check_box.dart';
import 'package:sidebar_animation/game_widgets/grid_square.dart';
import 'package:sidebar_animation/models/concentration_model.dart';
import 'package:sidebar_animation/popups/concentration_popup.dart';


class NewGameScreen extends StatefulWidget {
  String game;
  NewGameScreen({this.game});
  String score;

  @override
  _NewGameScreenState createState() => _NewGameScreenState();
}

class _NewGameScreenState extends State<NewGameScreen> {
 // List list = new List<int>.generate(100, (i) => i + 1);
  int timesLoaded = 0;
  String message;
  Timer _timer;
 int _start = 60;
   void startTimer(concentration) {
     if (_timer != null) {
        _timer.cancel();
       _timer = null;
        _start = 60;
     }
       _timer = new Timer.periodic(

         const Duration(seconds: 1),
             (Timer timer) =>
             setState(
                   () {
                 if (_start < 1) {
                   timer.cancel();
                   showConcentrationPopup(context, concentration, "Game Over", "Wow, that was terribly unimpressive.", "Play Again");
                 } else {
                   _start = _start - 1;
                 }
               },
             ),
       );
   }
showConcentrationPopup(context, concentration, title, message, action)async{
     if (concentration.score > 200 && concentration.score<1){
       message = "Wow, you scored " + concentration.score.toString() +". You are a top performer!";
     } else if (concentration.score >150){
       message = concentration.score + "! That was impressive!";
     }else if (concentration.score >100){
       message = "You scored " + concentration.score.toString() +". That's pretty good.";
     }else if (concentration.score >50){
       message = "You scored " + concentration.score.toString() +". That's a good start, but you can do better.";
     }else if (concentration.score < 50 && concentration.score > 1){
       message = "You scored " + concentration.score.toString()+ ". Looks like you are having trouble concentrating. Try again?";
     }
  await showDialog(
       context: context,
       builder: (_) =>
         concentrationPopup(context, title, message, action)
   ).then(
          (val){
            buildNewGame(concentration);

      }
  );
 }

 buildNewGame(concentration)async{

   setState(() {
     startTimer(concentration);
   });
 }
 @override
 initState() {
   super.initState();

 }
   @override
   void dispose() {
     if (_timer != null) {
      _timer.cancel();
     }
     super.dispose();
   }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 1,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          title: Text(widget.game,
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        body:
        ChangeNotifierProvider<ConcentrationModel>(
          create: (context)=> ConcentrationModel(),
            child: Consumer<ConcentrationModel>(builder:(context, concentration, child) {
              concentration.shuffleList();
              concentration.randomStart();
              WidgetsBinding.instance.addPostFrameCallback((_) async {
                timesLoaded+=1;
                if (timesLoaded ==1) {
                  showConcentrationPopup(context, concentration, "Can you concentrate?",
                      "How many numbers in sequence you can find before the time runs out. Your start number is selected for you. If you reach 100, the next number is 1. ",
                      "Play Game");
                }
              }
              );
              return
                Stack(
                  children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/8, left:10, right:10),
                  child: GridView.count(
                      crossAxisCount: 8,
                      children: List.generate(100, (index) {
                          bool selected = concentration.numbersList[index] == concentration.next -1;
                          return GridSquare(concentration.numbersList[index], concentration, selected);
                        })
                  )
                ),
                Positioned(
                  top:100,
                  child:Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Stack(
                      children: [

                        Container(

                          width:MediaQuery.of(context).size.width,
                          height: 80,
                          padding: const EdgeInsets.only(top:20.0, left:25),
                          color: Color(0xFF09eebc),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "High Score: 220",

                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),

                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Today's best: 180",

                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),

                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Your Score: "+ concentration.score.toString(),

                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          right:0,
                          top: 0,
                          child: Container(
                            height: 80,
                            width: MediaQuery.of(context).size.width/3,
                            color: Colors.black,
                            child: Center(
                              child: Text( "0:"+_start.toString().padLeft(2, '0'),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 38,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
            })
            ),

    );
  }
}

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:math';
import 'package:flutter/material.dart';

class ConcentrationModel with ChangeNotifier{
  int currentValue;
  int next;
  int score = 0;
  List numbersList=new List<int>.generate(100, (i) => i + 1);
  int bestScore = 0;

  int returnNext(){
    return next;
  }
  void randomStart(){
    if (next==null) {
      Random random = new Random();
      int startingValue = random.nextInt(100);
      print("shuffle");
      if (startingValue == 0){
        startingValue +=1;
      }
      next = startingValue;
    }
  }
  void setStartingValue() async{
    // int startingValue = random.nextInt(100);
  }
  void updateNext() async {
    next +=1;
    if (next == 101){
      next = 1;
    }
    addPoint();
    notifyListeners();
  }
  void addPoint() async {
    score += 10;
    if (score > bestScore) {
      bestScore = score;
    }
  }
  void resetGame(){
    score = 0;
    Random random = new Random();
    // startingValue = random.nextInt(100);
    // print("Start at: $startingValue");
    notifyListeners();
  }
  void shuffleList(){
    List shuffled;
     numbersList.shuffle();

  }


}
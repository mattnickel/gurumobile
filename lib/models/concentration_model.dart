import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:math';
import 'package:flutter/material.dart';

class ConcentrationModel with ChangeNotifier{
  int startingValue;
  int currentValue;
  int next;
  int score;


  int returnNext(){
    setNext();
    return next;
  }
  void setNext() async {
    next= currentValue +=1;
    notifyListeners();
    addPoint();
  }
  void addPoint() async {
    score += 1;
  }
  void resetGame(bool){
    score = 0;
    Random random = new Random();
    int startingValue = random.nextInt(100);
    notifyListeners();
  }


}
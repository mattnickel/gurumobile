import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sidebar_animation/models/concentration_model.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:sidebar_animation/services/game_api.dart';

class GridSquare extends StatefulWidget {
  int _index;
  ConcentrationModel conMod;
  bool selected;
  GridSquare(this._index, this.conMod, this.selected);
  @override
  _GridSquareState createState() => _GridSquareState();
}
class _GridSquareState extends State<GridSquare>{
  bool _canVibrate = true;
  bool selected = false;
  int numberInt;
  String number;
  String start;

  @override
  initState() {
    super.initState();
    selected = widget.selected;
    number = widget._index.toString();
    numberInt = widget._index;
    init();
  }

  init() async {
    bool canVibrate = await Vibrate.canVibrate;
    setState(() {
      _canVibrate = canVibrate;

    });
  }
  @override
  Widget build(BuildContext context) {
    return
    selected ?
      Container(
        child: Text(
          number,
          style: TextStyle(fontSize: 18, color: Colors.white),
          textAlign: TextAlign.center,

        ),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1.0,
              color: Colors.black12,
            ),
            color: Color(0xFF09eebc),
            borderRadius: BorderRadius.all(
                Radius.circular(5.0) //
            ),
          ),
        width: 40,
        height: 40,
        padding: EdgeInsets.only(top:10),
        margin: EdgeInsets.all(4),
      )
        :
    GestureDetector(
      onTap: () {
        print(widget.conMod.next);
        if (numberInt == widget.conMod.next){
          widget.conMod.updateNext();
          updateScore("conGrid", widget.conMod.score);
          setState(() {
            selected = true;
          });
        } else{
          print("fail");
          !_canVibrate
              ? null
              : Vibrate.vibrate();
        }
      },
      child: Container(
        child: Text(number, style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
        decoration: BoxDecoration(
        border: Border.all(
        width: 1.0,
        color: Colors.black12,
        ),
        borderRadius: BorderRadius.all(
        Radius.circular(5.0) //                 <--- border radius here
        ),
        ),
        // color: Colors.black12,
        width: 40,
        height: 40,
        padding: EdgeInsets.only(top:10),
        margin: EdgeInsets.all(4),
      ),
    );
  }}


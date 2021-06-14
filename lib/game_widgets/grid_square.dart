import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sidebar_animation/models/concentration_model.dart';

class GridSquare extends StatefulWidget {
  int value;
  int globalNext;
  GridSquare(this.value);
  @override
  _GridSquareState createState() => _GridSquareState();
}
class _GridSquareState extends State<GridSquare>{
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return
    selected ?
      Container(
        child: Text(
          widget.value.toString(),
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
        // if (widget.value == 0){
        selected = true;
        setState(() {});
        // },
      },
      child: Container(
        child: Text(widget.value.toString(), style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
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


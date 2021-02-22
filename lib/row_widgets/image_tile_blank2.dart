import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ImageTileBlank2 extends StatefulWidget {
  int index;
  bool selected;
  ImageTileBlank2({this.selected, this.index});

  @override
  _ImageTileBlank2State createState() => _ImageTileBlank2State();
}

class _ImageTileBlank2State extends State<ImageTileBlank2> {

  @override
  Widget build(BuildContext context) {

    return GestureDetector(


      child: Container(
          margin: const EdgeInsets.only(right:20.0),
          height:100,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.black12,
              border: widget.selected ? Border.all(color: Color(0xFF09eebc), width: 3.0) : null,
            borderRadius: BorderRadius.circular(18.0),

          ),

          child: Center(
            child: Icon(
              Icons.photo_size_select_actual_outlined,
              size:34,
              color: Colors.white,
            )

          )
      ),
    );
  }
}


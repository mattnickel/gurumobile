import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ignore: non_constant_identifier_names
Container ImageTileBlank({selected= true}){

  return Container(
        margin: const EdgeInsets.only(right:20.0),
        height:100,
        width: 100,
        decoration: BoxDecoration(
          color: Colors.black12,
          border: selected ? Border.all(color: Color(0xFF09eebc), width: 3.0) : null,
          borderRadius: BorderRadius.circular(18.0),

        ),

        child: Center(
            child: Icon(
              Icons.photo_size_select_actual_outlined,
              size:34,
              color: Colors.white,
            )

        )
    );

}



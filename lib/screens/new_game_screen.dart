import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:share/share.dart';
import 'package:provider/provider.dart';
import 'package:circular_check_box/circular_check_box.dart';
import 'package:sidebar_animation/game_widgets/grid_square.dart';
import 'package:sidebar_animation/models/concentration_model.dart';


class NewGameScreen extends StatefulWidget {
  String game;
  NewGameScreen({this.game});

  @override
  _NewGameScreenState createState() => _NewGameScreenState();
}

class _NewGameScreenState extends State<NewGameScreen> {
 List list = new List<int>.generate(100, (i) => i + 1);

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
          child: GestureDetector(
            // onTap: () {
            //   FocusScope.of(context).requestFocus(new FocusNode());
            // },
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.all(10),
                  child:
                        Consumer<ConcentrationModel>(builder:(context, startingValue, next) {
                            return
                            GridView.count(
                                crossAxisCount: 8,
                            children: List.generate(100, (index) {

                              // if (list[index]== ConcentrationModel.startingValue)
                              return GridSquare(list[index]);
                            }



                          )
                            );
                        })

                  ),
                Positioned(
                  bottom: 10,
                  child: Center(
                    child: RaisedButton(
                        child: Text(
                          "Shuffle",
                        ),
                        color: Colors.black,
                        onPressed:(){
                      list.shuffle();
                      setState(() {

                      });
                    }),
                  ),
                )
              ],
            )
            ),
          ),
    );
  }
}

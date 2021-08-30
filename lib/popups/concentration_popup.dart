import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:sidebar_animation/screens/new_game_screen.dart';
import '../helpers/habit_database_helpers.dart';
import '../services/local_notifications_manager.dart';



concentrationPopup(BuildContext context, title, message, action) {

  return  AlertDialog(
            contentPadding: EdgeInsets.only(left: 25, right: 25),
            title: Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: 15),
                child: Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),

                ),
              ),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))
            ),
            content: Container(
              child: SingleChildScrollView(
                  child: Column(
                        children: <Widget>[
                            Text(message)


                        ]
                    ),

              ),
            ),
            actions: <Widget>[
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: Align(
                  alignment: Alignment.center,
                  child:
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.70,
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
                              ..pop()
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
                              action,
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
                            Navigator.pop(context, false);
                          },
                        ),
                      ],
                    ),
                  ),

                ),
              ),
            ]
        );
      }

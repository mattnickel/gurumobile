import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sidebar_animation/pages/home.dart';
import 'package:sidebar_animation/screens/set_goals.dart';
import 'package:sidebar_animation/screens/signup_screen.dart';
import 'package:sidebar_animation/screens/splash_page.dart';
import 'package:sidebar_animation/screens/start_card.dart';
import '../framework_page.dart';
import '../services/api_calls2.dart';
import '../featured.dart';
import 'login_screen.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show SystemUiOverlayStyle, rootBundle;


class StartScreen extends StatelessWidget {

  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Scaffold(
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
          child: DefaultTabController(
            length: 3,
            child: Stack(
                  children:<Widget>[
                    TabBarView(
                      children: [
                        StartCard(
                          title1: "Get",
                          title2: "Content",
                          description: "Access mindset content when you need it most.",
                          startImage: "content.png"),
                        StartCard(
                          title1:"Get",
                          title2:"Consistent",
                          description:"Build daily habits that fuel your future success.",
                            startImage: "consistent.png"),
                        StartCard(
                            title1:"Get",
                            title2:"Connected",
                            description:"Share your mindset with friends and coworkers.",
                            startImage: "connect.png"),
                      ],
                    ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 100.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: RaisedButton(
                      elevation: 0.2,
                      color: Color(0xff00eebc),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0, right:20, top:10.0, bottom:10.0),
                        child: Text(("Get Started").toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                      onPressed: (){
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => SetGoals()),
                              (Route<dynamic> route) => false,
                        );
                      },
                    ),
                  ),
                ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 60.0),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: FlatButton(child:
                           Text("Log In", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold, decoration: TextDecoration.underline, )),
                          onPressed: (){
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => LoginPage("")),
                                  (Route<dynamic> route) => false,
                            );
                          },
                        ),
                      ),
                    ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 180.0),
                  child: Align(
                    alignment:Alignment.bottomCenter,
                    child: PreferredSize(
                      preferredSize: Size(5.0, 5.0),
                      child: TabBar(
                          indicatorColor: Colors.transparent,
                          labelColor: Color(0xFF00ebcc),
                          unselectedLabelColor: Colors.white38,
                          isScrollable: true,
                        tabs: <Widget> [
                          Container(
                            width:5,
                            child: Icon(Icons.fiber_manual_record, size: 16),
                          ),
                          Container(
                              width:5,
                            child: Icon(Icons.fiber_manual_record, size: 16)
                          ),
                          Container(
                            width:5,
                            child: Icon(Icons.fiber_manual_record, size: 16),
                           )
                        ]
                      ),
                    )
                  ),
                ),
              ]
              ),
          )
          ),
              ]
            )
          ),
    );

  }
}

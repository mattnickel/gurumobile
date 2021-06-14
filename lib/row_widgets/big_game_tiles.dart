import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:sidebar_animation/screens/new_game_screen.dart';



class BigGameTiles extends StatelessWidget {


  bool hasViewed = false;

  @override
  Widget build(BuildContext context) {
    return Wrap(
        children: <Widget>[
          Container(
              margin: const EdgeInsets.all(10.0),
              height: 550,
              width: MediaQuery.of(context).size.width - 40,
              child: Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(18.0),
                    child:
                    CachedNetworkImage(
                      imageUrl: 'https://images.unsplash.com/photo-1619887524805-92d8930f5050',
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                              colorFilter:
                              ColorFilter.mode(Colors.black38, BlendMode.darken)),
                        ),
                      ),
                      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  Positioned(
                    bottom: 100,
                    right: 45,
                    child: Container(
                      width:100,
                      height:100,
                      child: FittedBox(
                        child: FloatingActionButton(

                          child:RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                             children: <TextSpan>[
                                TextSpan(text: 'Play ', style: TextStyle( color: Colors.white, fontFamily: 'DancingScript')),
                                TextSpan(text: 'Game',  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                              ],
                          ),
                          ),

                          backgroundColor: Color(0xFF09eebc),
                          onPressed:(){
                            Navigator.push(context,
                                MaterialPageRoute(
                                    builder: (context) => NewGameScreen(game:"Concentration Grid")));
                          },
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 40,
                    left:10,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 40,
                      child: Text(
                          "Concentration Grid",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                              color: Colors.white,
                          ),
                        maxLines: 1,
                          ),
                    ),
                  ),

                ],
              ),
          ),
        ],
    );
  }
}


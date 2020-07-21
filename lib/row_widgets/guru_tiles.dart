import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GuruTiles extends StatelessWidget {

  List<String> gurus;
  int index;

  GuruTiles({ this.gurus, this.index});

  @override
  Widget build(BuildContext context) {
    return Wrap(
        children: <Widget>[
          Container(
              margin: const EdgeInsets.all(10.0),
              height:200,
              width: 150,
              child: Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(18.0),
                    child:
                      Image.asset("assets/images/" + gurus[index],
                      width: 150,
                      height: 200,
                      fit: BoxFit.cover,
                      color: Colors.black38,
                      colorBlendMode: BlendMode.darken,)
                  ),
                  Positioned(
                    bottom: 50,
                    left:10,
                    child: Text(
                            "Guru Name",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white)
                            ),
                  ),
                  Positioned(
                    bottom: 30,
                    left:10,
                        child: Text(
                          "Guru tagline",
                          style: TextStyle(
                            color: Colors.white,
                          )
                        ),
                      ),
                    ],
                  )
              )
        ],
    );
  }
}


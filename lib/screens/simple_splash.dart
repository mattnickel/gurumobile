import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class SimpleSplashPage extends StatelessWidget {
  Image splashImage = Image.asset('assets/images/adventure3.png', width: 500, gaplessPlayback: true,);
  @override

  Widget build(BuildContext context) {

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: splashImage.image,
                  fit:BoxFit.cover
              )
            )
          ),
          Center (
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black54),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text("Loading Neutral Thinking...",
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    )),
                  )
                ],
              )
          ),
      ]
    )
    );
  }
}
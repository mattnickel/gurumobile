import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SocialPostScreen extends StatelessWidget {

  String image;
  SocialPostScreen({this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white.withOpacity(0.75), // this is the main reason of transparency at next screen. I am ignoring rest implementation but what i have achieved is you can see.
    body: Stack(
    children: <Widget>[
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.only(top:60.0),
          child: Align(
              alignment: Alignment.topCenter,
              child: Text("Share on Socials",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),)),
        ),
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(18.0),
        child:
        CachedNetworkImage(
          imageUrl: image,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                  colorFilter:
                  ColorFilter.mode(Colors.black38, BlendMode.darken)),
            ),
          ),
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 60.0),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: RaisedButton(
            elevation: 2,
            color:Color(0xFF09eebc),
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width -100,
              padding: EdgeInsets.only( top:15.0, bottom:15.0),
              child: Align(
                  alignment:Alignment.center,
                  child: Text(
                      "Share It",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      )
                  )
              ),
            ),

            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
            onPressed: (){
              print("true");
              // saveGoals(goals);
              // _firebaseMessaging.requestNotificationPermissions();
              // Navigator.pushAndRemoveUntil(
              //   context,
              //   MaterialPageRoute(builder: (context) => FrameworkPage()),
              //       (Route<dynamic> route) => false,
              // );
            },
          ),
        ),
      ),
    ], ),
    );
  }
}
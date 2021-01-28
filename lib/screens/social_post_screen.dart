// import 'dart:html';
import 'package:path_provider/path_provider.dart';
import 'package:sidebar_animation/models/social_post_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sidebar_animation/services/social_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class SocialPostScreen extends StatefulWidget {

  String image;
  SocialPostScreen({this.image});

  @override
  _SocialPostScreenState createState() => _SocialPostScreenState();
}

class _SocialPostScreenState extends State<SocialPostScreen> {
  final messageController = TextEditingController();

  File betterImage;

 convertImage(imageUrl) async{
    var response = await get(imageUrl);
    var dir = await getTemporaryDirectory();
    print("yo");
    File file = File(dir.path + "/image.jpg");
    print("sup");
    file.writeAsBytesSync(response.bodyBytes);
    setState(() {
      betterImage = file;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white, // this is the main reason of transparency at next screen. I am ignoring rest implementation but what i have achieved is you can see.
    body: GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: SingleChildScrollView(
        child:
          Column(
            children: [
              Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: widget.image,
                    imageBuilder: (context, imageProvider) => Container(
                      height: MediaQuery.of(context).size.width,
                      // width:360,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  Positioned(
                      top: 40,
                      right: 10,
                      child: IconButton(
                        icon: Icon(Icons.cancel),
                        onPressed: () {
                          Navigator.pop(context, 'yep');
                        }
                      )),
                ],
              ),

          //
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [

                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                      // focusNode: _focusNode,
                      controller: messageController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black26,
                          ),
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        hintText: 'Write a caption... ',
                        fillColor: Colors.white,
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      onChanged: (tex) {
                        setState(() {
                          print(tex);
                        });
                      },
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 140.0),
                      child: RaisedButton(
                        elevation: 2,
                        color:Color(0xFF09eebc),
                        disabledColor: Color.fromRGBO(0,238,188, 0.25),
                        child: Container(
                          height: 50,
                          width:MediaQuery.of(context).size.width -100,
                          padding: EdgeInsets.only( top:15.0, bottom:15.0),
                          child: Align(
                              alignment:Alignment.center,
                              child: Text(
                                  "Share It",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  )
                              )
                          ),
                        ),

                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                        onPressed: messageController.text=="" ? null: ()async{
                          await convertImage(widget.image);
                          savePost(messageController.text, betterImage);
                          Navigator.pop(context, 'yep');

                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
            //     Center(
            //       child:
            // ),

        ], ),
        // ],
        ),
    ),
    );
    // );
  }
}
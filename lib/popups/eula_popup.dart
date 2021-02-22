import 'package:flutter/material.dart';


import 'package:sidebar_animation/services/social_api.dart';

sessionPopup(BuildContext context) {

  return  AlertDialog(

            content: ListView(
              children: [
                Container(

                width: MediaQuery
                    .of(context)
                    .size
                    .width - 60,
                height: 680,
                child: Text("I agree to the Terms of Service and I acknowledge that there is no tolerance for objectionable content or abusive users. Violation these terms will result in the termination of my user account.",
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 18,
                                ),
                              ),



                          ),
                ]
            )
                    );
                    // Container(
                    //   width: MediaQuery
                    //       .of(context)
                    //       .size
                    //       .width/2,
                    //   height: 50.0,
                    //   padding: EdgeInsets.symmetric(horizontal: 15.0),
                    //   margin: EdgeInsets.only(top: 5.0),
                    //   child: RaisedButton(
                    //     onPressed: messageController.text == ''|| image == null ? null :
                    //         ()async {
                    //       setState((){isLoading = true;});
                    //       Share.shareFiles([image], text: messageController.text, subject: messageController.text );
                    //       // await savePost(
                    //       //     messageController.text, image);
                    //       // Navigator.pop(context, 'yep');
                    //     },
                    //     elevation: 0.2,
                    //     color: Color(0xff09eebc),
                    //     disabledColor: Color.fromRGBO(0, 238, 188, 0.25),
                    //     child: isLoading
                    //         ? Center(child:CircularProgressIndicator())
                    //
                    //         :Text("Share", style: TextStyle(
                    //         color: Colors.white,
                    //         fontWeight: FontWeight.w800,
                    //         fontSize: 16)),
                    //     shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(25.0)),
                    //   ),
                    // ),


}

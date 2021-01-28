import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:sidebar_animation/models/social_post_model.dart';
import 'package:sidebar_animation/services/social_api.dart';

class PostTiles extends StatefulWidget {

  final SocialPost post;

 PostTiles({ this.post});

  @override
  _PostTilesState createState() => _PostTilesState();
}

class _PostTilesState extends State<PostTiles> {
  bool bumped = false;
  bool localBumped = false;
  bool localFalse =  true;

  bool bumpCheck(val){
    if (localBumped == true){
      bumped = true;
    }else if (localFalse == false){
      bumped = false;
    } else if(val != null){
      bumped = true;
    }
    return bumped;
  }


 int number = 0;

 String convertTime(apiTime){
   print(apiTime);
     String time;
     DateTime now = new DateTime.now();
     var then = DateTime.parse(apiTime);
     var timeFormatter = new DateFormat('E h:mm a');
     var timeSpan = now.difference(then);
     var timeSpanFormat = new DateFormat('h:mm');
      if (timeSpan.inHours <=1 ){
        if (timeSpan.inMinutes < 2){
          time = "now";
        }else {
          time = timeSpan.inMinutes.toString() + " min ago";
        }
     } else if (timeSpan.inHours < 24){
        time = timeSpan.inHours.toString() + " hrs ago";
     } else if (timeSpan.inHours < 48){
        time = timeSpan.inDays.toString()  + " day ago";
      }else{
        time = timeSpan.inDays.toString()  + " days ago";
      }
     print(time);
     // time = timeFormatter.format(DateTime.parse(apiTime)).toString();

   return time;
 }

  @override
  Widget build(BuildContext context) {


    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 25),

                        child:
                        widget.post.userAvatar != null
                            ? Center(child:
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage:   NetworkImage(widget.post.userAvatar)
                                ),
                            )
                            : Center(child:
                                CircleAvatar(
                                  child: Icon(
                                    Icons.account_circle,
                                    size: 75,
                                  ),
                                radius: 30,
                              backgroundColor: Color(0XFF09eebc),
                              ),
                              )
                          ),
                      ]
              ),
              Column(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top:20),
                    width:MediaQuery.of(context).size.width-120,
                    child: Row(
                      children: [
                        Container(
                          child: Text(
                              widget.post.userName,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              )
                          ),
                        ),
                        Spacer(),
                        Container(
                          child: Text(
                            convertTime(widget.post.time),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black26,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width:MediaQuery.of(context).size.width-120,
                      child:

                      Text(
                        widget.post.userTagline != null
                            ? widget.post.userTagline
                            : " "
                       ),

                    ),
                  ),
                ],
              ),
            ],
          ),
              Container(
                margin: const EdgeInsets.only(top:10.0, right:10.0),
              width: MediaQuery.of(context).size.width - 35,
              height: MediaQuery.of(context).size.width - 35,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(18.0),
                      child:
                      CachedNetworkImage(
                        imageUrl: widget.post.image,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                                ),
                          ),
                        ),
                        placeholder: (context, url) => CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ],
                ),
              ),
          Container(
            margin: EdgeInsets.symmetric(horizontal:10),
            padding: EdgeInsets.only(top:20.0),
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 115,
                  child: RichText(
                      textAlign: TextAlign.left,
                      text:TextSpan(
                          text: widget.post.userName+": ",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontSize: 14,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: widget.post.message,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            )

                          ]
                      )
                  ),
                ),
               Container(
                 width:40,
                 child: Padding(
                   padding: const EdgeInsets.only(top:5.0),
                   child: Text((widget.post.bumpCount + number).toString() , textAlign: TextAlign.right,),
                 ),
               ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    if (bumped== false) {
                      bumpThisPost(widget.post.id);
                      setState(() {
                        localBumped = true;
                        localFalse = true;
                        number += 1;
                      });
                    }else{
                      unbumpThisPost(widget.post.id);
                      setState(() {
                        localBumped = false;
                        localFalse = false;
                        number -= 1;
                      });
                    }

                  },

                  child:  bumpCheck(widget.post.myBump)
                      ? Image.asset('assets/images/bump_filled.png', height: 20, width:20 )
                      : Image.asset('assets/images/bump_black.png', height: 20, width:20 )

                ),
                // Icon(Icons.thumb_up_outlined),

              ],
            ),
          ),
          // Container(
          //     width: MediaQuery.of(context).size.width,
          //     margin: EdgeInsets.symmetric(horizontal:20),
          //     padding: EdgeInsets.only(top:20),
          //     child: Row(
          //       children: [
          //         Text("$number Bumps"),
          //         Spacer(),
          //         Icon(Icons.thumb_up_outlined),
          //
          //       ],
          //     )
          // ),
          Divider(),

        ],
              ),
    );
  }
}


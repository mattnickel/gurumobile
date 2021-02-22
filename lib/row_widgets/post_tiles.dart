import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:sidebar_animation/helpers/mark_block_hide.dart';
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
  bool _visibility = true;

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
      if (timeSpan.inMinutes <= 59 ){
        if (timeSpan.inMinutes < 2){
          time = "now";
        }else {
          time = timeSpan.inMinutes.toString() + " min ago";
        }
     } else if (timeSpan.inHours < 24){
        if(timeSpan.inHours < 2){
          time = timeSpan.inHours.toString() + " hr ago";
        }else {
          time = timeSpan.inHours.toString() + " hrs ago";
        }
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


    return Visibility(
      visible: _visibility,
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Stack(
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
                                        child: Center(
                                          child: Icon(
                                            Icons.person,
                                            size: 50,
                                            color: Colors.white70,
                                          ),
                                        ),
                                      radius: 30,
                                    backgroundColor: Colors.black12,
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
                                    // widget.post.username,
                                    widget.post.username != null ? widget.post.username :"unknown",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    )
                                ),
                              ),
                              Spacer(),
                              Container(
                                child:Text(
                                      convertTime(widget.post.time),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black26,
                                      ),
                                    ),
                                ),
                                ]
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
                Positioned(
                  right: 10,
                  top:40,
                  child: DropdownButton<String>(
                  underline: Container(),
                  icon: Icon(Icons.more_horiz),
                  items: [
                    DropdownMenuItem<String>(
                      child: Text('Hide this content'),
                      value: 'hide',
                    ),
                    DropdownMenuItem<String>(
                      child: Text('Mark as objectionable'),
                      value: 'object',
                    ),
                    DropdownMenuItem<String>(
                      child: Text('Block this user'),
                      value: 'block',
                    ),
                  ],
                  onChanged: (String value) {
                    if (value == "hide"){
                      markAndOrHideContent(widget.post.id);
                    } else if (value == "object"){
                      markAndOrHideContent(widget.post.id, hideOnly: false);
                    } else if(value == "block"){
                      print('blocking');
                      if (widget.post.postUserId != null) {
                        blockUserContent(widget.post.postUserId);
                      }else{
                        print('no id');
                      }
                    }
                    setState(() {
                      _visibility = false;
                    });
                  },
                ),)
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
                          placeholder: (context, url) => Center(child: CircularProgressIndicator()),
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
                            text: widget.post.username != null ? widget.post.username+": " : "Unknown: ",
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
                        ? Image.asset('assets/images/fist2.png', height: 20, width:20 )
                        : Image.asset('assets/images/fist.png', height: 20, width:20 )

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
      ),
    );
  }
}


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sidebar_animation/blocs/post_tiles_bloc.dart';
import 'package:sidebar_animation/helpers/mark_block_hide.dart';
import 'package:sidebar_animation/models/social_post_model.dart';
import 'package:sidebar_animation/row_widgets/social_media_tiles.dart';
import 'package:sidebar_animation/services/social_api.dart';
import 'package:keyboard_attachable/keyboard_attachable.dart';

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
  bool _opened = false;
  int number = 0;
  String username= "test";
  String newComment;
  int newCommentInt =0;

  getUsername()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    username = prefs.getString("username");
  }

  @override
  Future<void> initState() {
    super.initState();
    getUsername();
  }

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
                  top:25,
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
                            widget.post.video != null
                                ? SocialVideoTile(widget.post.video)
                                : SocialImageTile(widget.post.image)

                      ),
                    ],
                  ),
                ),
            Stack(
              children: [
                Container(
                  // margin: EdgeInsets.symmetric(horizontal:10),
                  padding: EdgeInsets.only(top:50.0, bottom:20),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width - 40,
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
                        ],
                      ),


                    ],
                  ),
                ),
                Positioned(
                  top:15,
                  right:20,
                  child: GestureDetector(
                    onTap: () {
                      if (_opened == false) {
                        setState(() {
                          _opened = true;
                        });
                      }else{
                        setState(() {
                          _opened = false;
                        });
                      }

                    },
                    child: Container(
                      width:80,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top:5.0),
                            child: widget.post.comments != null
                                ? Text((widget.post.comments.length + newCommentInt).toString() , textAlign: TextAlign.right,)
                                : Text('0', textAlign: TextAlign.right,)
                          ),
                          Spacer(),
                          Image.asset('assets/icons/comment_icon.png', height: 23, width:23 ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(top:5.0),
                            child: Text((widget.post.bumpCount + number).toString() , textAlign: TextAlign.right,),
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
                        ],
                      ),
                    ),
                  ),
                ),

              ],
            ),

              Visibility(
                visible: _opened,
                child: Column(
                  children: [
                    Divider(
                      endIndent: 250,
                      thickness: 1,
                    ),
                    Container(
                      // margin: EdgeInsets.symmetric(horizontal:10),
                      padding: EdgeInsets.only(bottom: 20, top:10),
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: widget.post.comments != null
                              ? widget.post.comments.length +1
                              : 1,
                          itemBuilder: (BuildContext context,int index) {
    if (index < widget.post.comments.length){
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(bottom: 10),
          child: RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              text: (widget.post.comments[index].username).toString()+ ": ",
              style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
              ),
              children: <TextSpan>[
                    TextSpan(
                      text: widget.post.comments[index].body,
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
      ]
    );
    } else{
      return
      newComment!=null
        ? Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(bottom: 5),
          child: RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                      text: username+ ": ",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: newComment,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        )

                      ]
              )
          ),
        )
          : Container(
              width: MediaQuery.of(context).size.width,
              height: 15,
              child: Row(
                      children: <Widget>[
                          Text(
                             username+ ": ",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                                fontSize: 14,
                            ),
                          ),
                          FlatButton(
                            padding: EdgeInsets.only(top:1, left:1),
                            onPressed: () async {
                              newComment = await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return triggerKeyboardComment(context, widget.post.id);
                                },
                              );
                              setState(() {
                                newComment != null
                                    ? newCommentInt=1
                                    : newCommentInt =0;
                              });
                            },
                            child:Text("Add a comment...", style:TextStyle(color: Colors.black26), textAlign: TextAlign.left,  ),
                          )
                      ]
            ),
          );
    }
     }
     ),
                      ),
                  ],
                )
                  ),
            Divider(),
              ]
          )
      ),

    );
    }

}



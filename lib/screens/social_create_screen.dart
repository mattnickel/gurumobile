import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:share/share.dart';
import 'package:provider/provider.dart';
import 'package:circular_check_box/circular_check_box.dart';

import '../row_widgets/image_row.dart';
import '../services/social_api.dart';
import '../models/social_index_model.dart';

class SocialCreate extends StatefulWidget {
  String group;
  SocialCreate({this.group});

  @override
  _SocialCreateState createState() => _SocialCreateState();
}

class _SocialCreateState extends State<SocialCreate> {
  File betterImage;
  String setGroup;
  bool _isChecked = false;

  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 1,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          title: Text("Create Social Post",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        body:
        ChangeNotifierProvider<SocialIndexModel>(
          create: (context)=> SocialIndexModel(),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.all(20),
              child: SingleChildScrollView(
                reverse: true,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom:15.0),
                      child: ImageRow(),
                    ),
                    Visibility(
                      visible: widget.group.length > 2,
                      child: Row(
                        children: [
                          Text("Post to:", style: TextStyle(fontSize:16),),
                          CircularCheckBox(
                              value: !_isChecked,
                              checkColor: Colors.white,
                              activeColor: Color(0xFF09ebcc),
                              inactiveColor: Colors.black54,
                              disabledColor: Colors.grey ,
                              onChanged: (val) => this.setState(() {
                                _isChecked= !_isChecked;
                              }) ),
                          Text("Social Feed", style: TextStyle(fontSize:16),),
                          CircularCheckBox(
                              value: _isChecked,
                              checkColor: Colors.white,
                              activeColor: Color(0xFF09ebcc),
                              inactiveColor: Colors.black54,
                              disabledColor: Colors.grey ,
                              onChanged: (val) {
                                setState(() {
                                  _isChecked = !_isChecked;
                                });
                                _isChecked
                                    ? setGroup = widget.group
                                    : setGroup = null;
                              }),
                          Text("${widget.group}", style: TextStyle(fontSize:16),),
                        ],
                      )
                    ),
                Consumer<SocialIndexModel>(builder:(context, socialIndex, child) {
                  return Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
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
                            fillColor: Colors.grey,
                          ),
                          keyboardType: TextInputType.multiline,
                          maxLines: 3,
                          onChanged: (text) {
                            socialIndex.setSocialCaption(text);
                          },
                        ),
                      ),
                    ],
                  );
                }),

                Consumer<SocialIndexModel>(builder:(context, socialIndex, child) {

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 150,
                        height: 50,
                        child: RaisedButton(
                          onPressed: !socialIndex.mediaExists
                              ? null
                              : () async {
                            socialIndex.convertedImageFile != null
                            ? Share.shareFiles([socialIndex.convertedImageFile.path], text: socialIndex.caption)
                            : Share.shareFiles([socialIndex.mediaFile.path],
                                text: socialIndex.caption);
                          },
                          elevation: 0.2,
                          color: Color(0xff09eebc),
                          disabledColor: Color.fromRGBO(0, 238, 188, 0.25),
                          child: Text("Share to...", style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 16)),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0)),
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: 150,
                        height: 50,
                        child: Consumer<SocialIndexModel>(
                            builder: (context, socialIndex, child) {
                              return RaisedButton(
                                onPressed: !socialIndex.mediaExists || socialIndex.caption == null
                                    ? null
                                    : () async {
                                  socialIndex.setLoading(true);
                                  if(socialIndex.convertedImageFile != null) {
                                    await savePost(
                                        message: socialIndex.caption,
                                        isVideo: false,
                                        media: socialIndex.convertedImageFile,
                                        group: setGroup
                                        );
                                    Navigator.pop(context, 'yep');
                                  }else if(socialIndex.mediaFile != null) {
                                    if(socialIndex.isVideo){
                                      await savePost(
                                          message: socialIndex.caption,
                                          isVideo: true,
                                          media: socialIndex.mediaFile,
                                          group: setGroup);
                                      Navigator.pop(context, 'yep');
                                    }else {
                                      await savePost(
                                          message: socialIndex.caption,
                                          media: socialIndex.mediaFile,
                                          group: setGroup);
                                      Navigator.pop(context, 'yep');
                                    }
                                  }else {
                                    return null;
                                  }
                                },
                                elevation: 0.2,
                                color: Color(0xff09eebc),
                                disabledColor: Color.fromRGBO(0, 238, 188, 0.25),
                                child: socialIndex.isLoading
                                    ? Center(child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white70)
                                ))

                                    : Text("Post", style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 16)),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0)),
                              );
                            }
                        ),
                      )
                    ],
                  );
                }),
                    Container(
                      height: 10,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:sidebar_animation/row_widgets/image_row.dart';
import 'package:provider/provider.dart';
import 'package:sidebar_animation/services/social_api.dart';
import '../models/social_index_model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show get;


class SocialCreate extends StatelessWidget {
  File betterImage;
  // final ScrollController _scrollController = ScrollController();
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
                    Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.width - 40,
                          width: MediaQuery.of(context).size.width - 40,
                        ),
                        ImageRow(),
                  ],
                ),

                Consumer<SocialIndexModel>(builder:(context, socialIndex, child) {

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
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
                          onPressed: !socialIndex.imageExists
                              ? null
                              : () async {
                            socialIndex.convertedImageFile != null
                            ? Share.shareFiles([socialIndex.convertedImageFile.path], text: socialIndex.caption)
                            : Share.shareFiles([socialIndex.imageFile.path],
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
                                onPressed: !socialIndex.imageExists || socialIndex.caption == null
                                    ? null
                                    : () async {
                                  socialIndex.setLoading(true);
                                  if(socialIndex.convertedImageFile != null) {
                                    await savePost(
                                        message: socialIndex.caption,
                                        image: socialIndex.convertedImageFile,
                                        );
                                    Navigator.pop(context, 'yep');
                                  }else if(socialIndex.imageFile != null) {
                                    await savePost(
                                        message: socialIndex.caption,
                                        image: socialIndex.imageFile);
                                    Navigator.pop(context, 'yep');
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

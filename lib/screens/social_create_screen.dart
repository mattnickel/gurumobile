import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:sidebar_animation/services/social_api.dart';

class SocialCreate extends StatefulWidget {
  @override

  _SocialCreateState createState() => _SocialCreateState();
}
class _SocialCreateState extends State<SocialCreate> {
  final ScrollController _scrollController = ScrollController();
  // FocusNode _focusNode = new FocusNode();
  final picker = ImagePicker();
  String pickedPath;
  var image;
  var pickedFile;
  bool isLoading = false;
  final messageController = TextEditingController();

  getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      pickedPath = pickedFile.path;
      image = pickedFile;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text("Create Social Post",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
      ),
      body:GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              children: [

                Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .width - 40,
                    child:
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(18.0),
                          child:
                          Container(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .width - 40,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width - 40,
                              child: DecoratedBox(
                                decoration: image == null
                                    ? BoxDecoration(
                                  color: Colors.black12,
                                ) : BoxDecoration(
                                    image: DecorationImage(
                                        image: FileImage(
                                            File(pickedPath)),
                                        fit:BoxFit.cover
                                    )
                                ),
                              )
                          ),
                        ),
                        Center(
                          child:
                          image == null
                              ? Icon(
                            Icons.photo_size_select_actual_outlined,
                            size: 100,
                            color: Colors.white,)
                              : Container(),
                        ),

                        Positioned(
                          top: 30,
                          right: 30,
                          child: image == null
                            ? FloatingActionButton(
                              child:
                              Icon(Icons.file_upload),
                              backgroundColor: Color(0xFF09eebc),
                              onPressed: () async{
                                print("add photo");
                                getImage();
                                setState(() {});
                              })
                            : FloatingActionButton(
                              child:
                              Icon(Icons.cancel),
                              backgroundColor: Colors.black45,
                              onPressed: () async{
                                setState(() {
                                  pickedPath = null;
                                  image = null;
                                });
                              }),
                        ),
                      ],
                    )
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25.0),
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
                    onChanged: (tex) {
                      setState(() {

                      });
                    },
                  ),
                ),
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: 50.0,
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  margin: EdgeInsets.only(top: 5.0, bottom:MediaQuery
                      .of(context)
                      .size
                      .width/3),
                  child: RaisedButton(
                    onPressed: messageController.text == '' || image == null ? null :
                        ()async {
                      setState((){isLoading = true;});
                      await savePost(
                          messageController.text, image);
                      Navigator.pop(context, 'yep');
                    },
                    elevation: 0.2,
                    color: Color(0xff09eebc),
                    disabledColor: Color.fromRGBO(0, 238, 188, 0.25),
                    child: isLoading
                        ? Center(child:CircularProgressIndicator())

                        :Text("Create Post", style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 16)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0)),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
}
}

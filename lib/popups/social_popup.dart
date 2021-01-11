import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:sidebar_animation/services/social_api.dart';

socialPopup(BuildContext context) {
  final picker = ImagePicker();
  String pickedPath;
  var image;
  var pickedFile;
  bool isLoading = false;
  final messageController = TextEditingController();



  return StatefulBuilder(
      builder: (context, setState) {
        getImage() async {
          final pickedFile = await picker.getImage(source: ImageSource.gallery);
          setState(() {
            pickedPath = pickedFile.path;
            image = pickedFile;
          });
        }
        return AlertDialog(
          content: Container(
            width: MediaQuery
                .of(context)
                .size
                .width - 80,
            height: 580,
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Row(
                      children: [
                        Text(
                          "Create Social Post",
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Colors.black87,
                            fontSize: 18,
                          ),
                        ),
                        Spacer(),
                        Container(
                          width: 50,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(icon: Icon(Icons.cancel,
                                color: Colors.black54),
                              onPressed: () {
                                setState(() {
                                  pickedPath = null;
                                  pickedFile = null;
                                  image = null;
                                });
                                Navigator.pop(context, 'yep');
                              },
                            ),
                          ),
                        ),
                      ],
                    )),
                Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .width - 125,
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
                                  .width - 125,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width - 125,
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
                          top: 90,
                          right: 65,
                          child: FloatingActionButton(
                              child:
                              Icon(Icons.file_upload),
                              backgroundColor: Color(0xFF09eebc),
                              onPressed: () async{
                                  print("add photo");
                                  getImage();
                                  setState(() {});
                              }
                          ),
                        ),
                      ],
                    )
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25.0),
                  child: TextField(
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
                  margin: EdgeInsets.only(top: 5.0),
                  child: RaisedButton(
                    onPressed: messageController.text == ''|| image == null ? null :
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
        );
      }
  );
}

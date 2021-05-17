import 'package:flutter/material.dart';
import '../models/social_index_model.dart';

openDrawerBelow(context, socialIndex) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 320,
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    "assets/images/menu_background.png"),
                fit: BoxFit.cover,
              ),
            // borderRadius: BorderRadius.only(
            //   topLeft: Radius.circular(25.0),
            //   topRight: Radius.circular(25.0),
            // ),
          ),
                      child: Stack(
                        alignment: Alignment(0, 0),
                        overflow: Overflow.visible,
                        children: <Widget>[
                          Positioned(
                            child: ListView(
                              physics: NeverScrollableScrollPhysics(),
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: ListTile(
                                    title: Text(
                                      "Upload Photo from Library",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    leading: Icon(
                                      Icons.photo_size_select_actual_outlined,
                                      color: Colors.white,
                                    ),
                                    onTap: () async{
                                      await socialIndex.getImage();
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ),
                                Divider(color: Colors.white30, height: 3),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: ListTile(
                                    title: Text(
                                      "Take a Photo",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    leading: Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                    ),
                                    onTap: () async{
                                      await socialIndex.createImage();
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ),
                                Divider(color: Colors.white30, height: 3),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: ListTile(
                                    title: Text(
                                      "Upload a video (max: 1 min)",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    leading: Icon(
                                      Icons.ondemand_video_sharp,
                                      color: Colors.white,
                                    ),
                                      onTap: () async{
                                        await socialIndex.getVideo();
                                        Navigator.of(context).pop();
                                      },
                                  ),
                                ),
                                Divider(color: Colors.white30, height: 3),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: ListTile(
                                    title: Text(
                                      "Create a video (max: 1 min)",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    leading: Icon(
                                      Icons.video_call_sharp,
                                      color: Colors.white,
                                    ),
                                    onTap: () async{
                                      await socialIndex.createVideo();
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ),

                              ],
                            ),
                          )
                        ],
                      ));


      });
}
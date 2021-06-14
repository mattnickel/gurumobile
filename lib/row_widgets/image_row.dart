import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sidebar_animation/bottom_drawers/post_drawer.dart';

import '../models/social_index_model.dart';
import 'image_tile_blank.dart';
import 'image_tiles.dart';

class ImageRow extends StatelessWidget {

  Future<List>getSavedLibrary() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String savedImages = prefs.getString("socialLibrary");
    if (savedImages != null) {
      return json.decode(savedImages);
    } else return null;
  }

    @override
  Widget build(BuildContext context) {
    return
      Column(
          children: <Widget>[
            Row(children: [
              Container(
                margin: EdgeInsets.only(bottom:10.0),
                child: Text(
                    "Social Library",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    )
                ),
              ),
              Spacer(),
              Container(
                child: Icon(
                  Icons.chevron_right,
                  color: Color(0xFF00ebcc),
                ),
              ),
            ],
            ),

            Container(
                child: Consumer<SocialIndexModel>(builder:(context, socialIndex, child){
                    return FutureBuilder<List>(
                        future: getSavedLibrary(),
                        builder:(context, snapshot) {
                            return Wrap(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom:20.0),
                                  height: 100,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: snapshot.data == null ? 1 : snapshot
                                          .data.length +
                                          1,
                                      itemBuilder: (context, index) {
                                        if (index == 0) {
                                          return GestureDetector(
                                            child: ImageTileBlank(
                                                selected: socialIndex.value == 0
                                                    ? true
                                                    : false),
                                            onTap: () {
                                              socialIndex.value = 0;
                                              socialIndex.cancelImage();

                                            },
                                          );
                                        } else {
                                          return GestureDetector(
                                              child: ImageTiles(
                                                  snapshot.data[index - 1],
                                                  socialIndex.value == index
                                                      ? true
                                                      : false
                                              ),
                                              onTap: () {
                                                socialIndex.setSocialIndex(index);
                                                socialIndex.setSocialImage(
                                                    snapshot.data[index - 1]);
                                                socialIndex.setImageExists(true);
                                              }
                                          );
                                        }
                                      }
                                  ),
                                ),
                                Container(
                                    height: MediaQuery
                                        .of(context)
                                        .size
                                        .width - 40,
                                    child: Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(18.0),
                                                child:
                                                Container(
                                                    constraints: BoxConstraints(maxWidth: 800, maxHeight: 800),
                                                    height: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width - 40,
                                                    width: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width - 40,
                                                    child: socialIndex.value == 0
                                                        ? Stack( children: [
                                                          Container(
                                                            decoration:
                                                              socialIndex.mediaFile == null
                                                              ? BoxDecoration(color: Colors.black12,)
                                                              : BoxDecoration(image:
                                                                  DecorationImage(
                                                                    image: socialIndex.thumbnail != null ? MemoryImage(socialIndex.thumbnail) : FileImage(socialIndex.mediaFile),
                                                                    fit: BoxFit.cover,
                                                                    ),
                                                              ),
                                                            child: Center(
                                                              child: socialIndex.mediaFile == null
                                                                ? Icon(
                                                                    Icons.photo_size_select_actual_outlined,
                                                                    size: 100,
                                                                    color: Colors.white,
                                                                ): Container()
                                                          ),

                                                        ),
                                                        Positioned(
                                                          top: 30,
                                                          right: 30,
                                                          child: socialIndex.mediaFile == null
                                                              ? FloatingActionButton(
                                                              child: Icon(
                                                                  Icons.add,
                                                                  color: Colors.white
                                                              ),
                                                              backgroundColor: Color(0xFF09eebc),
                                                              onPressed: () async{
                                                                print("add photo");
                                                                openDrawerBelow(context, socialIndex);

                                                              }
                                                          )
                                                              : FloatingActionButton(
                                                              child: Icon(
                                                                  Icons.cancel,
                                                                  color: Colors.white),
                                                              backgroundColor: Colors.black12,
                                                              elevation:0,
                                                              onPressed: (){
                                                                socialIndex.cancelImage();
                                                              }
                                                          ),
                                                        )
                                                      ],
                                                    ) : Container(
                                                      decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                              image: NetworkImage(snapshot.data[socialIndex.value-1],),
                                                              fit:BoxFit.cover
                                                          )
                                                      ),
                                                    )
                                                ),



                                              )
                                          ],

                                      ),
                                )
                            ]);
                          }
      );
                }
                    )

                )


          ]
      );
  }
}

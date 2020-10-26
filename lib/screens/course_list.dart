import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sidebar_animation/media_widgets/playlist_manager.dart';
import 'package:sidebar_animation/models/training_module_course_model.dart';
import 'package:sidebar_animation/media_widgets/flick_manager.dart';
import 'course_list_items.dart';

class CourseList extends StatelessWidget {

  TrainingModule module;
  CourseList({ this.module});
  int next = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Container(
            margin: EdgeInsets.only(top: 0.0),
            child: ListView(
                children: <Widget>[
                  Stack(
                   alignment: Alignment.topCenter,
                      children: <Widget>[
                        SizedBox(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          height: 560.0,
                        ),
                        Container(
                          height: 490,
                          child: CachedNetworkImage(
                            imageUrl: module.coverPhoto,
                            imageBuilder: (context, imageProvider) =>
                                Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                        colorFilter: ColorFilter.mode(
                                            Colors.black38, BlendMode.darken)),
                                  ),
                                ),
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                        Positioned(
                            top: 20,
                            left: -20,
                            child: RawMaterialButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              elevation: 2.0,
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 25.0,
                                color: Colors.white,
                              ),
                              // padding: EdgeInsets.all(15.0),
                              // shape: CircleBorder(),
                            )
                        ),
                        Positioned(
                          top: 375,
                          left: 20,
                          child: Text(
                              module.title,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  color: Colors.white)
                          ),
                        ),
                        Positioned(
                          top: 410,
                          left: 20,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width - 20,
                          child: Text(
                              module.description,
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white)
                          ),
                        ),
                        Positioned(
                            top: 470,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(18.0),
                                child: Card(
                                  margin: EdgeInsets.all(0),
                                  child:
                                  Container(
                                    padding: EdgeInsets.all(16),
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    // height:5000,
                                    child: Row(
                                      children: [
                                        Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Course Contents",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      fontSize: 24,
                                                      color: Colors.black)
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(right:8.0),
                                                    child: Icon(Icons.schedule,
                                                        color: Colors.grey,
                                                      size: 18.0,),
                                                  ),
                                                  Text("Chapters: ${module.videos.length}",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.grey),
                                                  ),
                                                ],
                                              )
                                            ]
                                        ),
                                        Spacer(),
                                        FloatingActionButton(
                                          child: Icon(Icons.play_arrow,
                                            size: 25.0,
                                            color: Colors.black,
                                          ),
                                          backgroundColor: Color(0xFF00ebcc),
                                          onPressed: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (_) {
                                              return PlaylistManager(module.videos, 0);
                                            }));
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                )
                            )
                        ),
                      ]
                  ),

                  ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 1000),
                    child: ListView.builder(
                      itemCount: module.videos.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return
                          module.videos.length > 0 ?
                          CourseListItems(
                          moduleVideos: module.videos,
                          index: index,
                        )
                              : null;
                      },
                    ),
                  ),
                ]
            )
        )
    );
  }
}
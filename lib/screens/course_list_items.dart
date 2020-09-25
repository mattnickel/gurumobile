import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sidebar_animation/media_widgets/flick_manager.dart';



class CourseListItems extends StatelessWidget {

  List<dynamic> moduleVideos;
  int index;
  bool hasWatched = false;
  CourseListItems({ this.moduleVideos, this.index});
  Container _connectingDots(){
    return
    hasWatched
    ?  Container(
        color: Color.fromRGBO(0,238,188, 0.25),
        height: 100,
        width: 2,
        child: VerticalDivider())
    :  Container(
        color: Colors.grey,
        height: 100,
        width: 2,
        child: VerticalDivider());
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[

        Expanded(
          child: Column(
            children: [
                  Padding(
                    padding: const EdgeInsets.only(left:40.0),
                    child: Row(
                      children: [
                       Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: (hasWatched)
                              ? Icon(
                                  Icons.trip_origin,
                                  size: 20.0,
                                  color: Color(0xFF00ebcc))
                              : Icon(
                                  Icons.trip_origin,
                                  size: 20.0,
                                  color: Colors.grey,),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right:8.0),
                          child: Icon(Icons.ondemand_video),
                        ),
                        Text(
                          moduleVideos[index].title.length > 1
                              ? moduleVideos[index].title
                              :" ",
                          style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.black)
                        ),
                      ]
                    )
                  ),

                   Row(
                     children: [
                       SizedBox(
                         width: 49,
                         height: 50.0,
                       ),
                       _connectingDots(),
                       Padding(
                         padding: const EdgeInsets.only(left:20.0, top:8.0, bottom:20,),

                         child: Container(
                           width: MediaQuery.of(context).size.width * 0.6,
                           child: Text(
                                  moduleVideos[index].description,
                                  style: TextStyle(
                                    color: Colors.black,
                                  )
                                ),
                         ),
                       ),
                     ],
                   ),
                  ],
                ),
        )
      ],
    );

  }
}
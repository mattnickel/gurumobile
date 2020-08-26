import 'package:flutter/material.dart';
import '../media_widgets/stream_video.dart';
import '../row_widgets/vimeo_row.dart';
import '../row_widgets/video_row.dart';
import '../row_widgets/guru_row.dart';

class NextSteps extends StatelessWidget{
  String category;
  List<String> videos = <String>[];
  List<String> gurus = <String>['guru1.png', 'guru2.png', 'guru3.png'];

  @override
  Widget build(BuildContext context){
    return ListView(
      children:<Widget>[
        VideoRow(category:"For Today", videos:videos),
        GuruRow(category: "Recommended Gurus", gurus:gurus),
        VideoRow(category:"Continue Watching", videos:videos),
      ],
      );
  }

}



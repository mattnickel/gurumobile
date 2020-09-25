import 'package:flutter/material.dart';
import '../row_widgets/course_row.dart';
import '../row_widgets/video_row.dart';


class Library extends StatelessWidget{
	String category;
	List<String> videos = <String>[];
	List<String> trainingModules = <String>[];

	@override

	Widget build(BuildContext context){
			return
		 		ListView(
					padding: const EdgeInsets.only(top:40),
				  children:<Widget>[
				  	VideoRow(category:"Trending Videos", videos:videos),
				  	CourseRow(category: "Recommended Courses", trainingModules:trainingModules),
				  	VideoRow(category:"Recommended Videos", videos:videos),
				  ],
				);
	}

}
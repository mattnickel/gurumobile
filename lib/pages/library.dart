import 'package:flutter/material.dart';
import '../row_widgets/course_row.dart';
import '../row_widgets/video_row.dart';



class Library extends StatelessWidget{
	String category;
	List<String> videos = <String>['video1.png', 'video2.png', 'video3.png'];
	List<String> courses = <String>['course1.png', 'course2.png', 'course3.png'];

	@override

	Widget build(BuildContext context){
			return
		 		ListView(
						padding: const EdgeInsets.only(top:40),
				  children:<Widget>[
				  	VideoRow(category:"Trending Videos", videos:videos),
				  	CourseRow(category: "Recommended Courses", courses:courses),
				  	VideoRow(category:"Recommended Videos", videos:videos),
				  ],
				);
	}

}
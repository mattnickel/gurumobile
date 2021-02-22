// import 'dart:html';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sidebar_animation/models/categories_model.dart';
import 'package:sidebar_animation/services/api_calls2.dart';
import '../row_widgets/course_row.dart';
import '../row_widgets/video_row.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;



class Library extends StatefulWidget{
  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
	List<String> videos = <String>[];
	List<String> trainingModules = <String>[];
	List<String> videoCategories = <String>[];
	int index;

	@override
	initState(){
		super.initState ();
	}


	@override
	Widget build(BuildContext context) {
		return
			FutureBuilder<List<VideoCategory>>(
					future: getCategories(http.Client()),
					builder: (context, snapshot) {
						if (snapshot.connectionState == ConnectionState.done) {
							if (snapshot.hasError) print(snapshot.error);
							return snapshot.hasData

									? ListView.builder(
										padding: const EdgeInsets.only(top:40),
										itemCount: snapshot.data.length+1,
										itemBuilder: (context, index){
											if (index < snapshot.data.length){
													return VideoRow(category: snapshot.data[index].name);
												}else{
												return Container(
													height:100
												);
											}
							}
									)
									: Container();
						}else{
							return Container();
						}
					}
			);
	}
	// Widget build(BuildContext context){
	// 		return
	// 	 		ListView.builder(
	// 				padding: const EdgeInsets.only(top:40),
	// 				itemCount: videoCategories.length,
	// 				itemBuilder: (context, index){
	// 					return VideoRow(category:videoCategories[index], videos:videos);
	// 				},
	//
	// 			  // children:<Widget>[
	// 			  // 	VideoRow(category:"Reducing Negativity", videos:videos),
	// 			  // 	CourseRow(category: "Recommended Courses", trainingModules:trainingModules),
	// 			  // 	VideoRow(category:"Recommended Videos", videos:videos),
	// 			  // ],
	// 			);
	// }
}
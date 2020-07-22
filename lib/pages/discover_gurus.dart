import 'package:flutter/material.dart';
import 'package:sidebar_animation/row_widgets/guru_row.dart';

import '../row_widgets/course_row.dart';
import '../row_widgets/video_row.dart';



class Discover_gurus extends StatelessWidget{
	String category;
	List<String> gurus = <String>['guru1.png', 'guru2.png', 'guru3.png'];
	List<String> gurus2 = <String>['guru3.png', 'guru1.png', 'guru2.png'];

	@override

	Widget build(BuildContext context){
		return
			ListView(
				children:<Widget>[
					GuruRow(category:"Recommended Gurus", gurus:gurus),
					GuruRow(category:"Discover Gurus", gurus:gurus2),
					GuruRow(category:"New Gurus", gurus:gurus),

				],
			);
	}

}
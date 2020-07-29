import 'package:flutter/material.dart';
import '../row_widgets/post_tiles.dart';

class Social extends StatelessWidget{
	String category;
	List<String> posts = ["post1.png", "post2.png", "post3.png"];

	@override

	Widget build(BuildContext context){
		return Container(
			margin: EdgeInsets.only(left: 10.0, bottom:30.0),
			child: ListView.builder(
				scrollDirection: Axis.vertical,
				itemCount: posts == null ? 0 : posts.length,
				itemBuilder: (context, index) {
					return PostTiles(
							posts: posts,
							index: index,
					);
				},
			)
		);
	}
}

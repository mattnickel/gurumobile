import 'package:flutter/material.dart';
import 'package:sidebar_animation/row_widgets/guru_row.dart';

import '../row_widgets/course_row.dart';
import '../row_widgets/video_row.dart';
import 'discover_gurus.dart';
import 'my_guru.dart';

class Gurus extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return
			DefaultTabController(
				length: 2,
				child: Column(
						children: <Widget> [
							Container(
								constraints: BoxConstraints.expand(height: 30),
								width: 50,
								alignment: Alignment.bottomLeft,
								margin: const EdgeInsets.only(top: 10.0, bottom: 30.0),
								child:
								TabBar(
									indicatorColor: Color(0xFF00ebcc),
									indicatorSize: TabBarIndicatorSize.label,
									unselectedLabelColor: Colors.black26,
									isScrollable: true,
									tabs: <Widget> [
										Container(
												alignment: Alignment.centerLeft,
												width: 100,
												child: Text(
													"Discover",
													style: TextStyle(
															fontWeight: FontWeight.bold,
															fontSize: 18),
												)


										),
										Container(
												alignment: Alignment.centerLeft,
												width: 100,
												child: Text("My Guru",
													style: TextStyle(
															fontWeight: FontWeight.bold,
															fontSize: 18),)

										),
									],
								),
							),
							Expanded(
									child: Container(
										child: TabBarView(
											children: [
												Discover_gurus(),
												My_guru(),
											],
										),
									)
							)
						]
				),
			);
	}
}


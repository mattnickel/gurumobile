import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'next_steps.dart';
import 'stats.dart';

import '../sidebar/sidebar_layout.dart';

class HomePage extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return SafeArea(
			child: Scaffold(
				appBar: AppBar(
					title: Image.asset("assets/images/logo.png", fit: BoxFit.cover),
					),
				drawer: SideBarMenu(),
				bottomNavigationBar: FloatingNavbar(
					onTap: null,
					backgroundColor: Colors.white,
					borderRadius: 30,
					selectedItemColor: Colors.redAccent,
					selectedBackgroundColor: null,
					unselectedItemColor: Colors.black54,
					currentIndex: 0,
					items: [
						FloatingNavbarItem(icon: Icons.home, title: 'Home'),
						FloatingNavbarItem(icon: Icons.video_library, title: 'Library'),
						FloatingNavbarItem(icon: Icons.person, title: 'MyGuru'),
						FloatingNavbarItem(icon: Icons.insert_photo, title: 'Social'),
					],
				),
			body: DefaultTabController(
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
										indicatorColor: Colors.redAccent,
										indicatorSize: TabBarIndicatorSize.label,
										unselectedLabelColor: Colors.black26,
										isScrollable: true,
										tabs: <Widget> [
											Container(
													alignment: Alignment.centerLeft,
													width: 100,
													child: Text(
															"Next Steps",
																style: TextStyle(
																		fontWeight: FontWeight.bold,
																		fontSize: 18),
															)


											),
											Container(
													alignment: Alignment.centerLeft,
													width: 100,
													child: Text("Statistics",
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
										NextSteps(),
										Stats(),
									],
								),
							)
						)
					]
				),
			),
				extendBody: true,
		)
		);
	}
}
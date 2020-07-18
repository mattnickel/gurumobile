import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../sidebar/sidebar_layout.dart';

class HomePage extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
				appBar: AppBar(
					title: Image.asset("assets/images/logo.png", fit: BoxFit.cover),
					),
				drawer: SideBarMenu(),
				bottomNavigationBar: FloatingNavbar(
					onTap: null,
					backgroundColor: Colors.grey[800],
					borderRadius: 30,
					selectedItemColor: Colors.redAccent,
					selectedBackgroundColor: null,
					unselectedItemColor: Colors.white,
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
							constraints: BoxConstraints.expand(height: 50),
							width: 50,
							alignment: Alignment.bottomLeft,

							child:
								TabBar(
										indicatorColor: Colors.redAccent,
										indicatorSize: TabBarIndicatorSize.label,
										isScrollable: true,
										tabs: <Widget> [
											Container(
													alignment: Alignment.centerLeft,
													width: 100,
													child: Text("Next Steps")

											),
											Container(
													alignment: Alignment.centerLeft,
													width: 100,
													child: Text("Statistics")

											),
										],
								),
							),
						Expanded(
							child: Container(
								child: TabBarView(
									children: [
										Text("Next Steps"),
										Text("Statistics")
									],
								),
							)
						)
					]
				),
			),
				extendBody: true,
		);
	}
}
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:sidebar_animation/bloc/navagation_bloc/navagation_bloc.dart';

class HomePage extends StatelessWidget with NavigationStates{
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(),
			drawer: Drawer(

			),
			extendBody: true,
			bottomNavigationBar: FloatingNavbar(
				onTap: (int val) {
					//returns tab id which is user tapped
				},
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
			body:
			    Stack(
						children: <Widget> [
			      Text(
			      	"Home",
			      	style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28),
			      ),
					],
			  ),
		);
	}
}
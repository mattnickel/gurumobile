import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/navbar_tab_selected_model.dart';

import '../sidebar/sidebar_layout.dart';


class FrameworkPage extends StatelessWidget{
	@override
	Widget build(BuildContext context) {
		return ChangeNotifierProvider<NavbarTabSelectedModel>(
		create: (context) => NavbarTabSelectedModel(),
		  child: Consumer<NavbarTabSelectedModel>(
				builder: (context, model, child) =>
					SafeArea(
						child: Scaffold(
							appBar: AppBar(
								title: Image.asset("assets/images/logo.png", fit: BoxFit.cover),
								),
							drawer: SideBarMenu(),
							bottomNavigationBar: FloatingNavbar(
								onTap: (int index){
									model.currentTab = index;
								},
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
						body: model.currentScreen,
							extendBody: true,
					)
				),
			),
		);
	}
}
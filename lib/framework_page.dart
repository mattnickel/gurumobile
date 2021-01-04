import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notification_permissions/notification_permissions.dart';
import './services/local_notifications_manager.dart';
import 'models/navbar_tab_selected_model.dart';

import 'sidebar/sidebar_layout.dart';


class FrameworkPage extends StatefulWidget{

	@override
  _FrameworkPageState createState() => _FrameworkPageState();
}



class _FrameworkPageState extends State<FrameworkPage> {


	final localNotifications = LocalNotificationsManager.init();

	@override
	Widget build(BuildContext context) {
		return ChangeNotifierProvider<NavbarTabSelectedModel>(
		create: (context) => NavbarTabSelectedModel(),
		  child: Consumer<NavbarTabSelectedModel>(
				builder: (context, model, child) =>
					Scaffold(
							resizeToAvoidBottomInset: false,
						resizeToAvoidBottomPadding:false,
							appBar: AppBar(
								title: Image.asset("assets/images/lmlogo.png", fit: BoxFit.cover),
								),
							drawer: SideBarMenu(),
							bottomNavigationBar:

							Container(
								height: 70,
								margin: EdgeInsets.only(bottom: 20, left: 20, right:20),
								decoration: BoxDecoration(
									color: Colors.white,
									borderRadius: BorderRadius.only(
											topLeft: Radius.circular(35),
											topRight: Radius.circular(35),
											bottomLeft: Radius.circular(35),
											bottomRight: Radius.circular(35)
									),
									boxShadow: [
										BoxShadow(
											color: Colors.black.withOpacity(0.15),
											spreadRadius: 5,
											blurRadius: 7,
											offset: Offset(0, 3), // changes position of shadow
										),
									],
								),
							  child: SingleChildScrollView(
										physics: NeverScrollableScrollPhysics(),
							    child: FloatingNavbar(
							      	onTap: (int _index){
							      		model.currentTab = _index;
							      	},
							      	backgroundColor: Colors.white,
							      	borderRadius: 100,
							      	selectedItemColor: Color(0xFF09eebc),
							      	selectedBackgroundColor: null,
							      	unselectedItemColor: Colors.black54,
							      	currentIndex: (model.currentTab),
							      	items: [
							      		FloatingNavbarItem(icon: Icons.home, title: 'Home', ),
							      		FloatingNavbarItem(icon: Icons.video_library, title: 'Library'),
							      		FloatingNavbarItem(icon: Icons.insert_photo, title: 'Social'),
							      	],
							      ),
							  ),
							),

							body: model.currentScreen,
							extendBody: true,
					)
				),
			);
	}
}
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
	final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
	FlutterLocalNotificationsPlugin();
	NotificationAppLaunchDetails notificationAppLaunchDetails;

}

class _NotificationsState extends State<Notifications> {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
				extendBodyBehindAppBar: true,
			appBar: AppBar(
				elevation: 0,
				iconTheme: IconThemeData(
					color: Colors.white, //change your color here
				),
				title: Text("Notifications",
					style: TextStyle(color: Colors.white),
				),
				backgroundColor: Colors.transparent,
			),
				body: Container(
					decoration: BoxDecoration(
							image: DecorationImage(
								image: AssetImage("assets/images/menu_background.png"),
								fit: BoxFit.cover,
							)
					),
					padding: const EdgeInsets.symmetric(horizontal: 20),
				  child: Center(
			child: Text(
				  "Notifications",
				  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28),
			),
		),
				),
		);
	}
}
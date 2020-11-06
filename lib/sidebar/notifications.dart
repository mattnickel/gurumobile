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
				body: Center(
			child: Text(
				"Notifications",
				style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28),
			),
		),
		);
	}
}
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'package:app_settings/app_settings.dart';
import 'package:sidebar_animation/pages/home.dart';
import 'package:sidebar_animation/pages/next_steps.dart';

import '../services/local_notifications_manager.dart';
import '../helpers/database_helpers.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
	final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
	FlutterLocalNotificationsPlugin();
	NotificationAppLaunchDetails notificationAppLaunchDetails;
}

class _NotificationsState extends State<Notifications> with WidgetsBindingObserver{
	Future<String> permissionStatusFuture;
	bool habitsCheck;
	bool messagesCheck = true;
	bool contentCheck = true;
	final localNotifications = LocalNotificationsManager.init();


	var permGranted = "granted";
	var permDenied = "denied";
	var permUnknown = "unknown";
	var permProvisional = "provisional";

	@override
	void initState() {
		super.initState();
		initPlatformState();
		permissionStatusFuture = getCheckNotificationPermStatus();
		WidgetsBinding.instance.addObserver(this);
		_checkForActive();
	}
	Future<void> initPlatformState() async {
		// If the widget was removed from the tree while the asynchronous platform
		// message was in flight, we want to discard the reply rather than calling
		// setState to update our non-existent appearance.
		if (!mounted) return;
	}
	/// When the application has a resumed status, check for the permission
	/// status
	@override
	void didChangeAppLifecycleState(AppLifecycleState state) {
		if (state == AppLifecycleState.resumed) {
			setState(() {
				permissionStatusFuture = getCheckNotificationPermStatus();
				print(permissionStatusFuture);
			});
		}
	}

	/// Checks the notification permission status
	Future<String> getCheckNotificationPermStatus() {
		return NotificationPermissions.getNotificationPermissionStatus()
				.then((status) {
			switch (status) {
				case PermissionStatus.denied:
					return permDenied;
				case PermissionStatus.granted:
					return permGranted;
				case PermissionStatus.unknown:
					return permUnknown;
				case PermissionStatus.provisional:
					return permProvisional;
				default:
					return null;
			}
		});
	}
	AlertDialog areYouSurePopup(context){
		return AlertDialog(
		contentPadding: EdgeInsets.only(left: 25, right: 25, bottom: 15),
		title: Center(
			child: Padding(
				padding: EdgeInsets.only(bottom: 15),
					child:Column(
						children:<Widget>[
							Text("Are you sure?",
								textAlign	: TextAlign.center,
								style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
							),
							Row(children:<Widget>[
								Container(
									height: 20,
								)
							]),
							Text("To no longer receive notifications, you must disable in device Settings.",
								textAlign: TextAlign.center,
								style: TextStyle(fontSize: 16),)
						],
					),
				),
		),
		shape: RoundedRectangleBorder(
				borderRadius: BorderRadius.all(Radius.circular(20.0))
				),
		content: Container(
			height: 60,
		  child: Column(
		    children: [
		    	Divider(
						height: 5,
					),
					IntrinsicHeight(
		        child: Row(
						mainAxisAlignment: MainAxisAlignment.spaceEvenly,
		          children: [
		            TextButton(
		            	child: Text('Settings',
		            		style: TextStyle(color: Colors.black,
		            			fontSize: 18),
		            		),
		            onPressed: () async {
		            	Navigator.pop(context, 'yep');
									AppSettings.openNotificationSettings();
		            },
		  			),
							VerticalDivider(
							),
		        		TextButton(
		        			child: Text('Cancel',
		        				style: TextStyle(color: Color(0xff09eebc),
		        						fontWeight: FontWeight.bold,
		        						fontSize: 18),
		        			),

		        			onPressed: () async {
		        				Navigator.pop(context, 'yep');
		        			},
		        		),
		          ],

		        ),
		      ),
		    ],
		  ),
		)
		);
	}
	AlertDialog askAgainPopup(context){
		return AlertDialog(
				contentPadding: EdgeInsets.only(left: 25, right: 25, bottom: 20),
				title: Center(
					child: Padding(
						padding: EdgeInsets.only(bottom: 15),
						child: Column(
						  children: [
						    Text(
						    	"Turn on notifications for \"Limitless Minds.\"",
						    	textAlign: TextAlign.center,
						    	style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
						    ),
								Row(
										children:<Widget>[
											Container(
												height: 20,
												)
										]),
								Text("You can turn on notifications for this app in Settings.",
									textAlign: TextAlign.center,
									style: TextStyle(fontSize: 16),)
						  ],
						),
					),
				),
				shape: RoundedRectangleBorder(
						borderRadius: BorderRadius.all(Radius.circular(20.0))
				),
				content: Container(
					child:  RaisedButton(
									child: Text(
										'Go to settings',
										style: TextStyle(color: Colors.white,
												fontWeight: FontWeight.bold,
												fontSize: 16),
									),
									color: Color(0xff09eebc),
									disabledColor: Color.fromRGBO(0,238,188, 0.25),
									shape: RoundedRectangleBorder(
										borderRadius: BorderRadius.circular(30.0),
									),
									onPressed: () async {
										Navigator.pop(context, 'yep');
										AppSettings.openNotificationSettings();
									},
								),
							),
						);
		}

	void _checkForActive() async {
		DatabaseHelper helper = DatabaseHelper.instance;
		bool _check = await helper.anyActive();
		setState(() {
		    habitsCheck = _check;
		});
	}
	setHabitsInactive(){
		DatabaseHelper helper = DatabaseHelper.instance;
		helper.setAllInactive();
		var inactive = localNotifications.cancelAllNotifications;
	}
	@override
	Widget build(BuildContext context) {
		bool isGranted;
		return Scaffold(
				extendBodyBehindAppBar: true,
			appBar: AppBar(
				elevation: 0,
				iconTheme: IconThemeData(
					color: Colors.white, //change your color here
				),
				title: Text("Manage Notifications",
					style: TextStyle(color: Colors.white),
				),
				backgroundColor: Colors.transparent,
			),
				body: Stack(
				  children: [
				    Container(
				    	decoration: BoxDecoration(
				    			image: DecorationImage(
				    				image: AssetImage("assets/images/menu_background.png"),
				    				fit: BoxFit.cover,
				    			)
				    	),
				      child: FutureBuilder(
								future: permissionStatusFuture,
									builder: (context, snapshot) {
									// if we are waiting for data, show a progress indicator
								if (snapshot.connectionState == ConnectionState.waiting) {
									return CircularProgressIndicator();
								}
								if (snapshot.hasData) {

								// The permission is granted, then just show the text
								if (snapshot.data == permGranted) {
								 isGranted = true;


								} else {
									isGranted = false;
									habitsCheck = false;
									messagesCheck = false;
									contentCheck = false;

								}

								// else, we'll show a button to ask for the permissions
								return ListView(
									children:<Widget>[

		Container(
		margin:const EdgeInsets.only(top:100),
		padding: const EdgeInsets.only(left: 20),
		height:60,
		decoration: BoxDecoration(
		color: Colors.white38,
		border: Border(
		bottom: BorderSide(
		color: Colors.black38,
		),
		)
		),
		child: Row(
		children: [
		// SizedBox(
		// 	width:100,
		// 	height: 100,
		// ),
		Text(
		"Allow Notifications",
		style: TextStyle(fontSize: 18, color: Colors.white),
		),
		Spacer(),
		Switch(
		value: isGranted,

		onChanged: (value) async {
		// updateIt(widget.habits[widget.index].id, value);
		if (value == true) {
			// print('false');
			// isGranted=true;
			await showDialog(
				    	context: context,
				    	builder: (BuildContext context) {
				    		return askAgainPopup(context);
				    	}
			);
		}else{
			await showDialog(
				    	context: context,
				    	builder: (BuildContext context) {
				    		return areYouSurePopup(context);
				    	}
			);
		}
		// cancelIt(widget.habits[widget.index].id);
		// }else {
		// print('true');
		// // restoreIt();
		// allCheck=1;
		// }

		},
		activeTrackColor: Color(0xFF9fe7d7),
		activeColor: Color(0xFF00ebcc),
		),
		],
		),
		),
		Container(
		margin:const EdgeInsets.only(top:0),
		padding: const EdgeInsets.only(left:20),
		height:60,
		decoration: BoxDecoration(
		color: Colors.white12,
		border: Border(
		bottom: BorderSide(
		color: Colors.black38,
		),
		)

		),
		child: Row(
		children: [
		// SizedBox(
		// 	width:100,
		// 	height: 100,
		// ),
		Text(
		"Content Notifications",
		style: TextStyle(fontSize: 18, color: Colors.white),
		),
		Spacer(),
		Switch(
		value: contentCheck,
		onChanged: (value)async {
		// updateIt(widget.habits[widget.index].id, value);
		if (value == false) {
		print('false');
		contentCheck=false;
		// cancelIt(widget.habits[widget.index].id);
		}else {
		print('true');
		contentCheck=true;
		}
		setState(() {

		});
		},
		activeTrackColor: Color(0xFF9fe7d7),
		activeColor: Color(0xFF00ebcc),
		),
		],
		),
		),
		Container(
		margin:const EdgeInsets.only(top:0),
		padding: const EdgeInsets.only(left: 20),
		height:60,
		decoration: BoxDecoration(
		color: Colors.white12,
		border: Border(
		bottom: BorderSide(
		color: Colors.black38,
		),
		)
		),
		child: Row(
		children: [
		// SizedBox(
		// 	width:100,
		// 	height: 100,
		// ),
		Text(
		"Message Notifications",
		style: TextStyle(fontSize: 18, color: Colors.white),
		),
		Spacer(),
		Switch(
		value: messagesCheck,
		onChanged: (value)async {
		// updateIt(widget.habits[widget.index].id, value);
		if (value == false) {
		print('false');
		messagesCheck = false;
		// cancelIt(widget.habits[widget.index].id);
		}else {
		print('true');
		messagesCheck= true;
		// restoreIt();
		}
		setState(() {});
		},
		activeTrackColor: Color(0xFF9fe7d7),
		activeColor: Color(0xFF00ebcc),
		),
		],
		),

		),
		Container(
		margin:const EdgeInsets.only(top:0),
		padding: const EdgeInsets.only(left: 20),
		height:60,
		decoration: BoxDecoration(
		color: Colors.white12,
		border: Border(
		bottom: BorderSide(
		color: Colors.black38,
		),
		)
		),
		child: Row(
		children: [
		// SizedBox(
		// 	width:100,
		// 	height: 100,
		// ),
		Text(
		"Habit Notifications",
		style: TextStyle(fontSize: 18, color: Colors.white),
		),
		Spacer(),
		Switch(
		value: habitsCheck,
		onChanged: (value)async {
		// updateIt(widget.habits[widget.index].id, value);
		if (value == false) {
		print('false');
		setHabitsInactive();
		habitsCheck = false;
		}else {
		print('true');
		// restoreIt();
		habitsCheck = true;
		}
		setState(() {});
		},
		activeTrackColor: Color(0xFF9fe7d7),
		activeColor: Color(0xFF00ebcc),
		),
		],
		),
		)
		],
		);
		}
		return Text("No permission status yet");
		}
				    ),
		),
						// Positioned(
						// 		top:55,
						// 		right:0,
						// 		child: FlatButton(
						// 			child:Icon(Icons.close, color: Colors.white,),
						// 		onPressed: (){
						//
						// 		Navigator.popAndPushNamed(context, '/framework' );
						// 			},
						// ))
				  ],
				)
		);
	}
}
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sidebar_animation/helpers/database_helpers.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
	final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
	FlutterLocalNotificationsPlugin();
	NotificationAppLaunchDetails notificationAppLaunchDetails;

}

class _NotificationsState extends State<Notifications> {
	int habitsCheck=1;
	int messagesCheck =0;
	int contentCheck=0;
	int allCheck =0;

	void _check() async {
		DatabaseHelper helper = DatabaseHelper.instance;
		List<Habit> habitList = await helper.queryAll();
		habitsCheck = habitList.length;
	}

	@override
  void initState(){
    super.initState();
    // _check();
    // messagesCheck = 0;
    // contentCheck =0;
    // void positionValue = flickManager.flickVideoManager.videoPlayerController.value.position;
  }

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
					// padding: const EdgeInsets.symmetric(horizontal: 20),
				  child: ListView(
						children:<Widget>[
				      // Center(
							// 	child: Text(
				      // 		"Notifications",
				      // 		style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28),
							// 	),
							// ),
							Container(
								margin:const EdgeInsets.only(top:50),
								padding: const EdgeInsets.only(left: 10),
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
							  			"Show All Notifications",
							  			style: TextStyle(fontSize: 18, color: Colors.white),
							      ),
										Spacer(),
										Switch(
											value:  allCheck > 0,
											onChanged: (value)async {
												// updateIt(widget.habits[widget.index].id, value);
												if (value == false) {
													print('false');
													allCheck=0;
													// cancelIt(widget.habits[widget.index].id);
												}else {
													print('true');
													// restoreIt();
													allCheck=1;
												}

												setState(() {
													// widget.isSwitched = value;
													// print( widget.isSwitched);
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
								padding: const EdgeInsets.only(left:10),
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
											value:  contentCheck>0,
											onChanged: (value)async {
												// updateIt(widget.habits[widget.index].id, value);
												if (value == false) {
													print('false');
													contentCheck=0;
													// cancelIt(widget.habits[widget.index].id);
												}else {
													print('true');
													contentCheck=1;
												}

												setState(() {
													// widget.isSwitched = value;
													// print( widget.isSwitched);
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
								padding: const EdgeInsets.only(left: 10),
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
											value:  messagesCheck > 0,
											onChanged: (value)async {
												// updateIt(widget.habits[widget.index].id, value);
												if (value == false) {
													print('false');
													messagesCheck=0;
													// cancelIt(widget.habits[widget.index].id);
												}else {
													print('true');
													messagesCheck=1;
													// restoreIt();
												}

												setState(() {
													// widget.isSwitched = value;
													// print( widget.isSwitched);
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
								padding: const EdgeInsets.only(left: 10),
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
											value:  habitsCheck >0,
											onChanged: (value)async {
												// updateIt(widget.habits[widget.index].id, value);
												if (value == false) {
													print('false');
													// cancelAll();
													habitsCheck = 0;
												}else {
													print('true');
													// restoreIt();
													habitsCheck = 1;
												}

												setState(() {
													// widget.isSwitched = value;
													// print( widget.isSwitched);
												});

											},
											activeTrackColor: Color(0xFF9fe7d7),
											activeColor: Color(0xFF00ebcc),
										),
									],
								),
							)
				    ],
				  ),
				),
		);
	}
}
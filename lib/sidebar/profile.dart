import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();

}

class _ProfileState extends State<Profile> {
	final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
	String firstName;
	Future <List> setProfileInfo() async {
		final SharedPreferences prefs = await SharedPreferences.getInstance();
		String firstName = prefs.getString("first_name");
		print(firstName);
		String tagLine = prefs.getString("tag_line") ??
				"Add a tagline to people get to know you better";
		String avatarUrl = prefs.getString("avatar_url") ?? "no";
		List userInfo = [tagLine, firstName, avatarUrl];
		print(userInfo);
		return userInfo;
	}
	@override
	Widget build(BuildContext context) {
		return
			FutureBuilder<List<dynamic>>(
				future: setProfileInfo(),
				builder: (context, snapshot) {
					if (snapshot.connectionState == ConnectionState.done) {
						return Scaffold(
							extendBodyBehindAppBar: true,
							appBar: AppBar(
								elevation: 0,
								iconTheme: IconThemeData(
									color: Colors.white, //change your color here
								),
								title: Text("Profile",
									style: TextStyle(color: Colors.white),
								),
								backgroundColor: Colors.transparent,
							),
							body: Stack(
									children: [
										Container(
											decoration: BoxDecoration(
													image: DecorationImage(
														image: AssetImage(
																"assets/images/menu_background.png"),
														fit: BoxFit.cover,
													)
											),
											padding: const EdgeInsets.symmetric(horizontal: 20),

										),
										Positioned(
											bottom: 0,
											child: ClipRRect(
												borderRadius: BorderRadius.circular(18.0),
												child: Container(
													// margin: EdgeInsets.symmetric(horizontal: 20),
													padding:EdgeInsets.only(top: 100, bottom:170),
													decoration: BoxDecoration(
															color: Colors.white54
													),
													height: MediaQuery.of(context).size.height*2/3,
													width: MediaQuery
															.of(context)
															.size
															.width,
													// height: MediaQuery.of(context).size.height/1.5,
													child: Column(
														children: <Widget>[
															Form(
																key: _formKey,
																child: Column(
																	children: [
																		new Container(
																			padding: EdgeInsets.symmetric(horizontal:70.0, vertical:5),
																			child: new TextFormField(
																				style: TextStyle(color: Colors.white),
																				// decoration: InputDecoration(fillColor: Colors.orange, filled: true),

																				initialValue: snapshot.data[1],
																				decoration: const InputDecoration(labelText: "YOUR FIRST NAME", labelStyle: TextStyle(color: Colors.white), hintText: "What do people call you?"),
																				autocorrect: false,
																				// controller: _firstNameController,
																				onChanged: (String value) {
																					firstName = value;
																				},
																			),
																		),
																		Container(
																			padding: EdgeInsets.symmetric(horizontal:70.0, vertical:5),
																			child: new TextFormField(
																				style: TextStyle(color: Colors.white),
																				initialValue: snapshot.data[0],
																				decoration: const InputDecoration(labelText: "YOUR TAG LINE", hintText: "What do you want people to know about you?"),
																				autocorrect: false,
																				// controller: _firstNameController,
																				onChanged: (String value) {
																					firstName = value;
																				},
																			),
																		),
																		Container(
																			padding: EdgeInsets.symmetric(horizontal:70.0, vertical:5),
																			child: new TextFormField(
																				style: TextStyle(color: Colors.white),
																				initialValue: "matt@test.com",
																				decoration: const InputDecoration(labelText: "YOUR EMAIL ADDRESS", hintText: "Email address"),
																				autocorrect: false,
																				// controller: _firstNameController,
																				onChanged: (String value) {
																					firstName = value;
																				},
																			),
																		),
																		Container(
																			padding: EdgeInsets.symmetric(horizontal:70.0, vertical:5),
																			child: new TextFormField(
																				style: TextStyle(color: Colors.white),
																				obscureText: true,
																				initialValue: "123456",
																				decoration: const InputDecoration(labelText: "YOUR PASSWORD", hintText: "Enter a new password"),
																				autocorrect: false,
																				// controller: _firstNameController,
																				onChanged: (String value) {
																					firstName = value;
																				},
																			),
																		),
																	],
																),
															),
														],
													),
												),
											),
										),
										Container(
											margin: EdgeInsets.only(top: 100),
											width: MediaQuery
													.of(context)
													.size
													.width,
											height: MediaQuery
													.of(context)
													.size
													.height / 2.5,
											child: Center(
												child: ClipRRect(
													borderRadius: BorderRadius.circular(200.0),
													child: Image.asset("assets/images/guru1.png",
														width: 200,
														height: 200,
														fit: BoxFit.cover,
													),
												),
											),
										),

										Align(
											alignment: Alignment.topCenter,
											child: Container(
												margin: EdgeInsets.only(top: MediaQuery
														.of(context)
														.size
														.height / 2.25),
												child: TextButton(
													child: Text("Update Photo",
														style: TextStyle(fontSize: 18,),),
													onPressed: () {},
												),
											),
										)
									]
							),
						);
					} else {
		return Container();
		}
		}
			);
		}
}
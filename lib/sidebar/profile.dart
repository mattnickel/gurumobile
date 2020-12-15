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
				"Add a tagline";
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
								title: Text("Update Profile",
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
										ListView(
										  children: [
												Stack(
													children: [
														Container(
															margin: EdgeInsets.only(top: 100),
															child: ClipRRect(
																borderRadius: BorderRadius.circular(18.0),
																child: Container(
																	// margin: EdgeInsets.only(top: 100),
																	height: MediaQuery.of(context).size.height,
																	width: MediaQuery
																			.of(context)
																			.size
																			.width,
																	// height: MediaQuery.of(context).size.height/1.5,
																	child: ListView(
																		children: <Widget>[
																			Container(
																				padding:EdgeInsets.only(top: 10, bottom:170),
																				decoration: BoxDecoration(
																						color: Colors.white
																				),
																				height: MediaQuery.of(context).size.height,
																				width: MediaQuery
																						.of(context)
																						.size
																						.width,
																			  child: ClipRRect(
																					borderRadius: BorderRadius.circular(18.0),
																			    child: Container(
																			      child: Form(
																			      	key: _formKey,
																			      	child: Column(
																			      		children: [
																			      			Container(
																			      				width: MediaQuery
																			      						.of(context)
																			      						.size
																			      						.width,
																			      				padding:EdgeInsets.only(right:40),
																			      				child:
																			      				Align(
																			      					alignment:Alignment.topRight,
																			      					child: TextButton(
																			      						child:Text("Save",
																			      							style: TextStyle(fontSize: 18, color:Color(0XFF09EEBC) ),
																			      						),
																			      						onPressed: (){},
																			      					),

																			      				),

																			      			),
																			      			Divider(),
																			      			Container(
																			      				padding: EdgeInsets.only(left:70.0,right:70.0, bottom:5),
																			      				child: new TextFormField(
																			      					style: TextStyle(color: Colors.black, fontSize: 18),
																			      					// decoration: InputDecoration(fillColor: Colors.orange, filled: true),
																			      					initialValue: snapshot.data[1],
																			      					decoration: const InputDecoration(labelText: "YOUR FIRST NAME", hintText: "What do people call you?"),
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
																			      					style: TextStyle(color: Colors.black, fontSize: 18),
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
																			      					style: TextStyle(color: Colors.black, fontSize: 18),
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
																			      					style: TextStyle(color: Colors.black, fontSize: 18),
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
																			    ),
																			  ),
																			),
																		],
																	),
																),
															),
														),
														Container(
															margin: EdgeInsets.only(top: 25),
															width: MediaQuery
																	.of(context)
																	.size
																	.width,
															// height: MediaQuery
															// 		.of(context)
															// 		.size
															// 		.height / 2.5,
															child: Center(
																child: CircleAvatar(
																	child:
																	snapshot.data[2].length > 3
																			? NetworkImage("$snapshot.data[2]")
																			: Icon(
																		Icons.person,
																		color: Colors.white,
																		size: 75,
																	),
																	radius: 60,
																	backgroundColor: Color(0XFF09eebc),
																),

																// ClipRRect(
																// 	borderRadius: BorderRadius.circular(200.0),
																// 	child:
																//
																// 	Image.asset("assets/images/guru1.png",
																// 		width: 180,
																// 		height: 180,
																// 		fit: BoxFit.cover,
																// 	),
															),
														),
														Positioned(
															top:30,
															right:MediaQuery
																	.of(context)
																	.size
																	.width*1/3.7,
															child: FloatingActionButton(
																child: Icon(Icons.photo_size_select_actual_outlined, color: Color(0xFF09EECA),size: 24,),
																backgroundColor: Colors.white,
																onPressed: () {},
															),
														),
													],
												),

										  ],
										),




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
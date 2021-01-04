import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sidebar_animation/services/api_posts.dart';
import 'dart:io';
import 'package:progress_indicator_button/button_stagger_animation.dart';
import 'package:progress_indicator_button/progress_button.dart';


class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();

}

class _ProfileState extends State<Profile> {
	File _image;
	final picker = ImagePicker();
	String _pickedPath;
	final _firstNameController = TextEditingController();
	final tagLineController = TextEditingController();
	final emailController = TextEditingController();
	final passwordController = TextEditingController();
	bool textChanged = false;

	final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
	String userId;
	String name;
	String firstName;
	String tagLine;
	String email;
	String password;
	String avatarUrl;

	Future getImage() async {
		final pickedFile = await picker.getImage(source: ImageSource.gallery, maxHeight: 240.0,
			maxWidth: 240.0);

		setState(() {
			if (pickedFile != null) {
				_pickedPath = pickedFile.path;
				_image = File(pickedFile.path);
			} else {
				print('No image selected.');
			}
		});
	}

		Future <List> getUserInfo() async {
			final SharedPreferences prefs = await SharedPreferences.getInstance();
			firstName = prefs.getString("firstName");
			print(firstName);
			tagLine = prefs.getString("tagLine") ??
					"Add a tagline";
			email = prefs.getString("email");
			password = prefs.getString("password");
			avatarUrl = prefs.getString("avatarUrl") ?? "no";
			userId = prefs.getString("userId");
			List userInfo = [tagLine, firstName, email, avatarUrl, password];
			return userInfo;
		}
		Future saveImage(updated) async{
			final SharedPreferences prefs = await SharedPreferences.getInstance();
			prefs.setString("avatarUrl", updated);
			print('savedImage');
			setState()async {
				avatarUrl= updated;
				_image = null;
			}

		}
		Future saveUserInfo() async {
			final SharedPreferences prefs = await SharedPreferences.getInstance();
			prefs.setString("firstName", firstName);
			prefs.setString("email", email);
			prefs.setString("tagLine", tagLine);
		}
		@override
		void initState() {
			super.initState();
			_firstNameController.text = firstName;
			tagLineController.text = tagLine;
			emailController.text = email;
			passwordController.text = password;
		}

		@override
		Widget build(BuildContext context) {
			return
				FutureBuilder<List<dynamic>>(
						future: getUserInfo(),
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
																			height: MediaQuery
																					.of(context)
																					.size
																					.height,
																			width: MediaQuery
																					.of(context)
																					.size
																					.width,
																			// height: MediaQuery.of(context).size.height/1.5,
																			child: ListView(
																				children: <Widget>[
																					Container(
																						padding: EdgeInsets.only(
																								top: 10, bottom: 170),
																						decoration: BoxDecoration(
																								color: Colors.white
																						),
																						height: MediaQuery
																								.of(context)
																								.size
																								.height,
																						width: MediaQuery
																								.of(context)
																								.size
																								.width,
																						child: ClipRRect(
																							borderRadius: BorderRadius
																									.circular(18.0),
																							child: Container(
																								child: Form(
																									key: _formKey,
																									child: Column(
																										children: [
																									Align(
																										alignment: Alignment.topRight,
																											  child: Container(
																											  	width: MediaQuery
																											  			.of(context)
																											  			.size
																											  			.width/3,

																											  		child: ProgressButton(
																											  		borderRadius: BorderRadius.all(Radius.circular(18)),
																											  			strokeWidth: 2,
																											  			color: Color(
																											  					0xff00eebc),
																											  			child:
																											  			// Padding(
																											  				// padding: const EdgeInsets
																											  				// 		.only(
																											  				// 		left: 10.0,
																											  				// 		right: 10,
																											  				// 		top: 10.0,
																											  				// 		bottom: 10.0),
																											  				// child:
																											  				Text(
																											  						("Save")
																											  								.toUpperCase(),
																											  						style: TextStyle(
																											  								color: Colors
																											  										.white,
																											  								fontSize: 18,
																											  								fontWeight: FontWeight
																											  										.bold)),
																											  			// ),
																											  			// shape: RoundedRectangleBorder(
																											  			// 		borderRadius: BorderRadius
																											  			// 				.circular(
																											  			// 				18.0)),

																											  			onPressed: (AnimationController controller) async {
																																List update = [
																																	userId,
																																	firstName,
																																	tagLine,
																																	email
																																];

																																if (textChanged !=
																																		false) {
																																	controller
																																			.forward();
																																	await updateUser(
																																			update);
																																	await saveUserInfo();
																																	await Future
																																			.delayed(
																																			Duration(
																																					seconds: 2), () {});
																																	controller
																																			.reset();
																																}
																																else
																																if (_image !=
																																		null) {
																																	controller
																																			.forward();
																																	String updated = await postImage(
																																			_image);
																																	saveImage(
																																			updated);
																																	await Future
																																			.delayed(
																																			Duration(
																																					seconds: 3), () {});
																																	controller
																																			.reset();
																																}
																															}

																											  		),

																											  	),

																											  ),

																											Divider(),
																											Container(
																												padding: EdgeInsets
																														.only(left: 70.0,
																														right: 70.0,
																														bottom: 5),
																												child: new TextFormField(
																													style: TextStyle(
																															color: Colors
																																	.black,
																															fontSize: 18),
																													// decoration: InputDecoration(fillColor: Colors.orange, filled: true),
																													initialValue: snapshot
																															.data[1],
																													decoration: const InputDecoration(
																															labelText: "YOUR FIRST NAME",
																															hintText: "What do people call you?"),
																													autocorrect: false,
																													// controller: _firstNameController,
																													onChanged: (
																															String value) {
																														if(firstName != value) {
																															firstName = value;
																															print(value);
																															textChanged =
																															true;
																														}
																													},
																												),
																											),
																											Container(
																												padding: EdgeInsets
																														.symmetric(
																														horizontal: 70.0,
																														vertical: 5),
																												child: new TextFormField(
																													style: TextStyle(
																															color: Colors
																																	.black,
																															fontSize: 18),
																													initialValue: snapshot
																															.data[0],
																													decoration: const InputDecoration(
																															labelText: "YOUR TAG LINE",
																															hintText: "What do you want people to know about you?"),
																													autocorrect: false,
																													// controller: tagLineController,
																													onChanged: (
																															String value) {
																														if (value != tagLine) {
																															tagLine = value;
																															textChanged =
																															true;
																															print(tagLine);
																														}
																													},
																												),
																											),
																											Container(
																												padding: EdgeInsets
																														.symmetric(
																														horizontal: 70.0,
																														vertical: 5),
																												child: new TextFormField(
																													style: TextStyle(
																															color: Colors
																																	.black,
																															fontSize: 18),
																													initialValue: email,
																													decoration: const InputDecoration(
																															labelText: "YOUR EMAIL ADDRESS",
																															hintText: "Email address"),
																													autocorrect: false,
																													// controller: emailController,
																													onChanged: (
																															String value) {
																														if(email != value) {
																															email = value;
																															textChanged =
																															true;
																														}
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
																	child:
																		_image != null
																		? Center(child: CircleAvatar(
																			radius: 70,
																				backgroundImage:   Image.file(_image).image,
																			)
							)
																		: Center(
																		child:
																		avatarUrl.length > 10
																				? CircleAvatar(
																				radius: 70,
																				backgroundColor: Colors.white,
																				child: CircleAvatar(
																					backgroundImage: NetworkImage(
																							snapshot.data[3]),
																					radius: 60,
																				)
																		)
																				: CircleAvatar(
																			child: Icon(
																				Icons.person,
																				color: Colors.white,
																				size: 75,
																			),
																			radius: 60,
																			backgroundColor: Color(0XFF09eebc),
																		),
																	),
																),
																Positioned(
																	top: 30,
																	right: MediaQuery
																			.of(context)
																			.size
																			.width * 1 / 3.7,
																	child: FloatingActionButton(
																			child: Icon(
																				Icons.photo_size_select_actual_outlined,
																				color: Color(0xFF09EECA), size: 24,),
																			backgroundColor: Colors.white,
																			onPressed: () {
																				getImage();
																			}
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

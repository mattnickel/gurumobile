import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image/image.dart' as img;
import 'package:sidebar_animation/blocs/join.dart';
import 'package:sidebar_animation/helpers/fix_rotation.dart';

import '../services/api_posts.dart';
import 'dart:io';
import 'package:progress_indicator_button/progress_button.dart';
import 'package:http/http.dart' as http;


class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();

}

class _ProfileState extends State<Profile> {
	File _image;
	final picker = ImagePicker();
	final _usernameController = TextEditingController();
	final tagLineController = TextEditingController();
	final emailController = TextEditingController();
	final passwordController = TextEditingController();

	bool textChanged = false;
	http.Client client;

	final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
	String userId;
	String name;
	String username;
	String tagLine;
	String email;
	String password;
	String avatarUrl;
	String group;


	@override
	void dispose() {
		_usernameController.dispose();
		tagLineController.dispose();
		emailController.dispose();
		passwordController.dispose();
		super.dispose();
	}

	Future getImage() async {
		final pickedFile = await picker.getImage(source: ImageSource.gallery, maxHeight: 200.0,
			maxWidth: 200.0);
		if (pickedFile != null && pickedFile.path != null) {
			File better = await fixImageRotation(pickedFile.path);
			setState((){
				_image = better;
			});
		}
	}

		Future <List> getUserInfo() async {
			final SharedPreferences prefs = await SharedPreferences.getInstance();
			username = prefs.getString("username");
			print(username);
			tagLine = prefs.getString("tagLine") ??
					"Add a tagline";
			email = prefs.getString("email");
			password = prefs.getString("password");
			avatarUrl = prefs.getString("avatarUrl") ?? "no";
			userId = prefs.getString("userId");
			group = prefs.getString("group") ?? "";
			List userInfo = [tagLine, username, email, avatarUrl, password];
			return userInfo;
		}
		Future saveImageLocally(postedImage) async{
			final SharedPreferences prefs = await SharedPreferences.getInstance();
			prefs.setString("avatarUrl", postedImage);
			avatarUrl = postedImage ?? "no";
			print(avatarUrl);
			setState((){
				_image = null;
			});

		}
		Future saveUserInfo() async {
			final SharedPreferences prefs = await SharedPreferences.getInstance();
			prefs.setString("username", username);
			prefs.setString("email", email);
			prefs.setString("tagLine", tagLine);
		}

		@override
		void initState() {
			super.initState();
			_usernameController.text = username;
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
																												width: 120,
																													height: 40,
																													margin: EdgeInsets.only(right:15),
																													child: ProgressButton(
																													borderRadius: BorderRadius.all(Radius.circular(18)),
																														// strokeWidth: 2,
																														color: Color(
																																0xff00eebc),
																														child:
																															Text(
																																	"Save",
																																	style: TextStyle(
																																			color: Colors
																																					.white,
																																			fontSize: 18,
																																			fontWeight: FontWeight
																																					.bold)),
																														onPressed: (AnimationController controller) async {
																															controller
																																	.forward();
																															if (textChanged == true) {
																																List update = [userId, username, tagLine, email];
																																await updateUser(update);
																																await saveUserInfo();
																															}
																															else if (_image != null) {
																																String postedImage = await postImage(_image, client);
																																await saveImageLocally(postedImage);

																															}
																															controller
																																	.reset();
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
																															focusedBorder: UnderlineInputBorder(
																																borderSide: BorderSide(color: Color(0xFF09EECA)),
																															),
																															helperText: "USERNAME",
																															hintText: "What do people call you?",
																															hintStyle: TextStyle(
																																fontSize: 14),
																													),
																													autocorrect: false,
																													// controller: _firstNameController,
																													onChanged: (
																															String value) {
																														if(username != value) {
																															username = value;
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
																															focusedBorder: UnderlineInputBorder(
																																borderSide: BorderSide(color: Color(0xFF09EECA)),
																															),
																															helperText: "TAGLINE",
																															hintText: "What do you want people to know about you?",
																															hintStyle: TextStyle(
																																fontSize: 14),
																													),
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
																															focusedBorder: UnderlineInputBorder(
																																borderSide: BorderSide(color: Color(0xFF09EECA)),
																															),
																															helperText: "EMAIL",
																															hintText: "Email address",
																															hintStyle: TextStyle(
																																fontSize: 14),
																													),
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
																										Join(group: group)

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

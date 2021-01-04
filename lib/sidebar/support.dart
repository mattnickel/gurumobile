import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Support extends StatefulWidget {
  @override
  _SupportState createState() => _SupportState();

}

class _SupportState extends State<Support> {
	final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
	final issueController = TextEditingController();
	final descriptionController = TextEditingController();
	// final _emailController = TextEditingController();
	bool _isEnabled;

	@override
	void initState() {
		super.initState();
		_isEnabled = false;
		issueController.addListener(_enableSignin);
		descriptionController.addListener(_enableSignin);

	}
	_enableSignin() {
		setState(() {
			_isEnabled = true;
		});
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
				title: Text("Support",
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
					padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
				  child: Column(
				    children: [
				    	Container(
								height: 150,
								width: MediaQuery
										.of(context)
										.size
										.width,
							),
					ClipRRect(
						borderRadius: BorderRadius.circular(18.0),
				        child: Container(
						// padding:EdgeInsets.only(top: 10, bottom:10),
								decoration: BoxDecoration(
									color: Colors.white
								),
								height: 450,
								width: MediaQuery.of(context)
								.size
								.width,
						child:  Container(
								child: Form(
									key: _formKey,
									child: Column(
										children: [
											Container(
												height: 100,
												width: MediaQuery
														.of(context)
														.size
														.width,
												padding:EdgeInsets.only(top:20),
												child: Center(child: Text("How can we help you?",
												style: TextStyle(
													fontSize: 22,
													fontWeight: FontWeight.w800,
													color: Color(0xFF00ebcc),
												))),
											),
							Divider(),
							ClipRRect(
								borderRadius: BorderRadius.circular(18.0),
								child:
											Container(
												padding: EdgeInsets.only(left:70.0,right:70.0, bottom:5),
												child: new TextFormField(
													style: TextStyle(color: Colors.black, fontSize: 18),
													// decoration: InputDecoration(fillColor: Colors.orange, filled: true),
													decoration: const InputDecoration(labelText: "ISSUE NAME", hintText: "What's the issue?"),
													autocorrect: false,
													controller: issueController,
													onChanged: (String value) {
														setState(){
															_isEnabled = true;
														};
														// firstName = value;
													},
												),
											),
							),
											Container(
												// height: 150,
												padding: EdgeInsets.only(left:70.0,right:70.0, bottom:5),
												child:  SizedBox(
													height:150,
												  child: TextFormField(
														controller: descriptionController,
														validator: (value){
															if(value.isEmpty){
																return 'Password cannot be empty';
															}
															return null;
														},
												    	keyboardType: TextInputType.multiline,
												    	maxLines: 5,
												    	style: TextStyle(color: Colors.black, fontSize: 18),
												    	decoration: const InputDecoration(labelText: "DESCRIBE THE ISSUE", hintText: "Give us a little more information."),
												    	autocorrect: true,

												    	// onChanged: (String value) {
															// 	print(value);
												    	// 	setState(value){
												    	// 		print(value);
															// 		_isEnabled = true;
															// 	};
												    	// },
												    ),
												),
											),
											// Container(
											// 	padding: EdgeInsets.symmetric(horizontal:70.0, vertical:5),
											// 	child: new TextFormField(
											// 		style: TextStyle(color: Colors.black, fontSize: 18),
											// 		// initialValue: "matt@test.com",
											// 		decoration: const InputDecoration(labelText: "YOUR EMAIL ADDRESS", hintText: "Email address"),
											// 		autocorrect: false,
											// 		controller: _emailController,
											// 		onChanged: (String value) {
											//
											// 		},
											// 	),
											// ),
											Divider(),
											Padding(
											  padding: const EdgeInsets.only(top: 28.0),
											  child: RaisedButton(
											  			color: Color(0xFF00ebcc),
											  		child: Padding(
											  				padding: const EdgeInsets.only(left: 20.0, right:20, top:10.0, bottom:10.0),
											  				child: Text("Submit to support",
											  				style: TextStyle(
											  					fontSize: 16,
											  					color: Colors.white,
											  				))),
											  		shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
											  		onPressed: issueController.text == "" || descriptionController.text == "" ? null : (){
																print(true);
																// postToDb();
																// popUpConfirmation();

														}),
											)
										],
									),
								),
							),
						),
				      ),
				    ],
				  ),

				),
		);
	}
}
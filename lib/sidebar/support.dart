import 'package:flutter/material.dart';
import 'package:sidebar_animation/services/api_posts.dart';

class Support extends StatefulWidget {
  @override
  _SupportState createState() => _SupportState();

}

class _SupportState extends State<Support> {
	final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
	final messageController = TextEditingController();
	bool isLoading = false;

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
				body: GestureDetector(
					onTap: () {
						FocusScope.of(context).requestFocus(new FocusNode());
					},
					child: Container(
				  	height: MediaQuery
				  		.of(context)
				  		.size
				  		.height,
				  	decoration: BoxDecoration(
				  			image: DecorationImage(
				  				image: AssetImage("assets/images/menu_background.png"),
				  				fit: BoxFit.cover,
				  			)
				  	),
				  	// padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
				    child: SingleChildScrollView(
				  		// reverse: true,
				        child:
				        	Column(
				        	  children: [
				        	    Container(
				  							margin: EdgeInsets.only(top:130),
				  							width: MediaQuery
				  						.of(context)
				  						.size
				  						.width,
				  					child: ClipRRect(
				  		borderRadius: BorderRadius.circular(18.0),
				            child: Container(
				  		// padding:EdgeInsets.only(top: 10, bottom:10),
				  				decoration: BoxDecoration(
				  					color: Colors.white
				  				),
				  				height: 370,
				  				width: MediaQuery.of(context)
				  				.size
				  				.width,
				  		child:  Container(
				  				child: Form(
				  					key: _formKey,
				  					child: Column(
				  						children: [
				  							Container(
				  								height: 60,
				  								width: MediaQuery
				  										.of(context)
				  										.size
				  										.width,
				  								padding:EdgeInsets.only(top:20),
				  								child: Center(child: Text("Send us a message!",
				  								style: TextStyle(
				  									fontSize: 22,
				  									fontWeight: FontWeight.w800,
				  									color: Colors.black87,
				  								))),
				  							),
				  							Container(
				  								width: MediaQuery
				  										.of(context)
				  										.size
				  										.width,
				  								// height: 150,
				  								padding: EdgeInsets.all(20.0),
				  								child:  SizedBox(
				  									height:200,
				  								  // width:300,
				  								  child: TextField(
				  										// focusNode: _focusNode,
				  										controller: messageController,
				  										decoration: InputDecoration(
				  											enabledBorder: OutlineInputBorder(
				  												borderSide: BorderSide(
				  													color: Colors.black26,
				  												),
				  												borderRadius: BorderRadius.circular(18.0),
				  											),
				  											hintText: "If something isn't working right, let us know...",
				  											fillColor: Colors.grey,
				  										),
				  										keyboardType: TextInputType.multiline,
				  										maxLines: 10,
				  										onChanged: (tex) {
				  											setState(() {

				  											});
				  										},
				  									),
				  								),
				  							),

				  							RaisedButton(
				  										color: Color(0xFF00ebcc),
				  									child:  isLoading
																		? CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.white))
																		:Text("Submit to support",
				  									style: TextStyle(
				  										fontSize: 16,
				  										color: Colors.white,
				  									)),
				  									shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
				  									onPressed: messageController.text == "" ? null : () async{
																setState(() {
																	isLoading = true;
																});
																await submitSupportTicket(messageController.text);
																await Future.delayed(Duration(seconds: 2), () {});
																Navigator.pop(context, 'yep');
															},

												)
				  						],
				  					),
				  				),
				  			),
				  		),
				          ),
		),
				      ],
				    ),

				  ),
		),
				)
		);
	}
}

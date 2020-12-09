import 'package:flutter/material.dart';

class Terms extends StatefulWidget {
  @override
  _TermsState createState() => _TermsState();

}

class _TermsState extends State<Terms> {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
				extendBodyBehindAppBar: true,
			appBar: AppBar(
				elevation: 0,
				iconTheme: IconThemeData(
					color: Colors.white, //change your color here
				),
				title: Text("Terms",
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
				  "Terms",
				  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28),
			),
		),
				),
		);
	}
}
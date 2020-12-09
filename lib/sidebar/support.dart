import 'package:flutter/material.dart';

class Support extends StatefulWidget {
  @override
  _SupportState createState() => _SupportState();

}

class _SupportState extends State<Support> {
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
					padding: const EdgeInsets.symmetric(horizontal: 20),
				  child: Center(
			child: Text(
				  "Support",
				  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28),
			),
		),
				),
		);
	}
}
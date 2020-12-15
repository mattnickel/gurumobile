import 'package:flutter/material.dart';
import 'package:sidebar_animation/pages/stats.dart';
import 'package:sidebar_animation/sidebar/termsTab.dart';

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
					style: TextStyle(color: Colors.white
					),
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
				      child: DefaultTabController(
				    		length: 2,
				    		child: ListView(
				    				children: <Widget> [
				    					Container(
				    						height: 500,
				    						constraints: BoxConstraints.expand(height: 30),
				    						width: 50,
				    						// alignment: Alignment.bottomLeft,
				    						margin: const EdgeInsets.only(top: 10.0, bottom: 30.0),
				    						child:
				    						TabBar(
				    							indicatorColor: Color(0xFF00ebcc),
				    							indicatorSize: TabBarIndicatorSize.label,
				    							unselectedLabelColor: Colors.white38,
													labelColor: Colors.white,
				    							isScrollable: true,
				    							tabs: <Widget> [
				    								Container(
				    										alignment: Alignment.centerLeft,
				    										width: 100,
				    										child: Text(
				    											"Terms",

				    											style: TextStyle(
				    													fontWeight: FontWeight.bold,
				    													fontSize: 20,
				    												),
				    										)


				    								),
				    								Container(
				    										alignment: Alignment.centerLeft,
				    										width: 100,
				    										child: Text("Privacy",
				    											style: TextStyle(
				    													fontWeight: FontWeight.bold,
				    													fontSize: 20,
				    											)
				    										)
				    								),
				    							],
				    						),
				    					),
				    					Container(
				    							height: MediaQuery
				    							.of(context)
				    							.size
				    							.height,
				    								width:  MediaQuery
				    										.of(context)
				    										.size
				    										.width,
				    								child: TabBarView(
				    									children: [
				    										TermsTab("Terms and Conditions"),
				    										TermsTab("Privacy Policy")
				    									],
				    								),
				    							)
				    					// )
				    				]
				    		),
				    	)
				    ),
				  ],
				),
		);
	}
}
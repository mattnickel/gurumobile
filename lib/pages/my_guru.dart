import 'package:flutter/material.dart';

class My_guru extends StatelessWidget{
	@override
	Widget build(BuildContext context) {
		return Center(
			child: Text(
				"You have not picked a guru yet",
				style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28),
			),
		);
	}
}
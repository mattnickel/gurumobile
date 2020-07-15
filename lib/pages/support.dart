import 'package:flutter/material.dart';
import 'package:sidebar_animation/bloc/navagation_bloc/navagation_bloc.dart';

class SupportPage extends StatelessWidget with NavigationStates{
	@override
	Widget build(BuildContext context) {
		return Center(
			child: Text(
				"Support",
				style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28),
			),
		);
	}
}
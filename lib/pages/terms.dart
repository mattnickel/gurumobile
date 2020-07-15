import 'package:flutter/material.dart';
import 'package:sidebar_animation/bloc/navagation_bloc/navagation_bloc.dart';

class TermsPage extends StatelessWidget with NavigationStates{
	@override
	Widget build(BuildContext context) {
		return Center(
			child: Text(
				"Terms",
				style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28),
			),
		);
	}
}
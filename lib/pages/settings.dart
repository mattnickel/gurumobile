import 'package:flutter/material.dart';
import '../bloc/navagation_bloc/navagation_bloc.dart';

class SettingsPage extends StatelessWidget with NavigationStates{
  @override
  Widget build(BuildContext context) {
  	return Center(
  		child: Text(
  			"Settings",
  			style: TextStyle( fontWeight: FontWeight.w900, fontSize:28),
  		),
  	);
  }
 }
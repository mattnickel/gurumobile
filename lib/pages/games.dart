import 'package:flutter/material.dart';
import 'package:sidebar_animation/row_widgets/big_game_row.dart';


class Games extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return

			ListView(
				padding: const EdgeInsets.only(top:40),
				children:<Widget>[
					BigGameRow(category:"Brain Games"),


				],
			);
	}
}


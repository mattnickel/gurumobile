import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sidebar_animation/bloc/navagation_bloc/navagation_bloc.dart';

import './sidebar_two.dart';
import '../pages/home.dart';

class SideBarLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider<NavigationBloc>(
          create: (context) => NavigationBloc(),
          child: Stack(
            children: <Widget>[
              BlocBuilder<NavigationBloc, NavigationStates>(
                builder: (context, navigationStates) {
                  return navigationStates as Widget;
                },
              ),
              SideBarSimple(),
            ],
          ),
        )
    );
  }
}

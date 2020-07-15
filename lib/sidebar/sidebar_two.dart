import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import '../bloc/navagation_bloc/navagation_bloc.dart';

import 'menu_item.dart';



class SideBarSimple extends StatefulWidget {
  @override
  _SideBarSimpleState createState() => _SideBarSimpleState();
}

class _SideBarSimpleState extends State<SideBarSimple> with SingleTickerProviderStateMixin{
  AnimationController _animationController;
  StreamController<bool> isSidebarOpenedStreamController;
  Stream<bool> isSidebarOpenedStream;
  StreamSink<bool> isSidebarOpenedSink;
  final _animatedDuration = const Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: _animatedDuration);
    isSidebarOpenedStreamController = PublishSubject<bool>();
    isSidebarOpenedStream = isSidebarOpenedStreamController.stream;
    isSidebarOpenedSink = isSidebarOpenedStreamController.sink;
  }

  @override
  void dispose() {
    _animationController.dispose();
    isSidebarOpenedStreamController.close();
    isSidebarOpenedSink.close();
    super.dispose();
  }

  void onIconPressed() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;
    if (isAnimationCompleted) {
      _animationController.reverse();
      isSidebarOpenedSink.add(false);
    } else {
      _animationController.forward();
      isSidebarOpenedSink.add(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.of(context).size.width;

    return StreamBuilder<Object>(
        initialData: false,
        stream: isSidebarOpenedStream,
        builder: (context, isSidebarOpenedAsync) {
        return AnimatedPositioned(
            duration: _animatedDuration,
            top: 0,
            bottom:0,
            left: isSidebarOpenedAsync.data ? 0 : -screenwidth,
            right: isSidebarOpenedAsync.data ? 0: screenwidth - 45,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      color: Colors.grey[800],
                      child: Column(
                        children:<Widget>[
                          Row(
                            children:<Widget>[
                             SizedBox(
                              width:100,
                              height: 100,
                            ),
                            ]
                          ),

                          ListTile(
                            title: Text(
                              "Harry Wilson",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30, fontWeight:
                                  FontWeight.w800
                              ),
                            ),
                            subtitle: Text(
                              "President of Limitless Minds",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w200
                                  ),
                            ),
                            leading: CircleAvatar(
                              child: Icon(
                                Icons.perm_identity,
                                color: Colors.white,
                              ),
                            radius: 40,
                          ),
                          ),
                          Divider(
                            height:60,
                            thickness: 0.5,
                            color: Colors.white,
                            indent: 40,
                            endIndent: 40,
                          ),
                          MenuItem(
                            icon: Icons.notifications,
                            title: "Notifications",
                            onTap: () {
                              onIconPressed();
                              BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.NotificationsClickedEvent);
                            }
                          ),
                          MenuItem(
                              icon: Icons.perm_identity,
                              title: "Profile",
                              onTap: () {
                                onIconPressed();
                                BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.ProfileClickedEvent);
                              }
                          ),
                          MenuItem(
                              icon: Icons.settings,
                              title: "Settings",
                              onTap: () {
                                onIconPressed();
                                BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.SettingsClickedEvent);
                              }
                          ),
                          MenuItem(
                              icon: Icons.account_circle,
                              title: "Account",
                              onTap: () {
                                onIconPressed();
                                BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.AccountClickedEvent);
                              }
                          ),
                          MenuItem(
                              icon: Icons.live_help,
                              title: "Support",
                              onTap: () {
                                onIconPressed();BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.SupportClickedEvent);
                              }
                          ),
                          MenuItem(
                              icon: Icons.filter_none,
                              title: "Terms",
                              onTap: () {
                                onIconPressed();
                                BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.TermsClickedEvent);
                              }
                          ),
                      ]
                    )
                  ),
                ),
                Align(
                  alignment: Alignment(0, -0.9),
                  child: GestureDetector(
                    onTap: (){
                      onIconPressed();
                    },
                    child: ClipPath(
                      clipper: CustomMenuClipper(),
                      child: Container(
                        width: 35,
                        height: 110,
                        color: Colors.grey[800],
                        alignment: Alignment.center,
                        child: AnimatedIcon(
                          progress: _animationController.view,
                          icon: AnimatedIcons.menu_close,
                          color: Colors.white,
                        )
                      ),
                    ),
                  ),
                ),
              ],
            )
        );
      }
    );
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }

}



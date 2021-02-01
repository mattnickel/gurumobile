import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sidebar_animation/sidebar/profile.dart';
import 'package:sidebar_animation/sidebar/support.dart';
import 'package:sidebar_animation/sidebar/terms.dart';

import '../services/api_login.dart';
import 'menu_item.dart';
import 'notifications.dart';


class SideBarMenu extends StatefulWidget {
  @override
  _SideBarMenuState createState() => _SideBarMenuState();
}
class _SideBarMenuState extends State<SideBarMenu> {
  String username;
  String initial;
  String tagLine;
  String avatarUrl;
  List userInfo;

  Future <List> setProfileInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    username = prefs.getString("username");
    initial = username.substring(0,0);
    tagLine = prefs.getString("tagLine") ??
        "Add a tagline...";
    avatarUrl = prefs.getString("avatarUrl") ?? "no";
    userInfo = [tagLine, username, avatarUrl];
    return userInfo;
  }
  String received;
  int id =0;
  bool loading = false;

  void refreshData() {
    id++;
  }

  FutureOr onGoBack(dynamic value) {
    refreshData();
    setState(() {});
  }

  @override
  void initState() {
    setProfileInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
      FutureBuilder<List<dynamic>>(
          future: setProfileInfo(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) print(snapshot.error);

              return
                Drawer(child:
                Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              "assets/images/menu_background.png"),
                          fit: BoxFit.cover,
                        )
                    ),
                    padding: const EdgeInsets.only(left: 20, right:10),
                    child:
                    ListView(
                        children: <Widget>[
                          Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 100,
                                  height: 100,
                                ),
                              ]
                          ),
                          ListTile(
                            title:
                            snapshot.data[1] != null ?
                            Text(
                              snapshot.data[1],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20, fontWeight:
                              FontWeight.w800
                              ),
                            )
                            :Text(
                              "unknown",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20, fontWeight:
                              FontWeight.w800
                              ),
                            ),
                            subtitle: Text(
                              snapshot.data[0],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w200
                              ),
                            ),
                            leading:
                              snapshot.data[2].length > 3
                              ? CircleAvatar(
                                  backgroundImage: NetworkImage(snapshot.data[2]),
                                  radius: 40,
                                )

                              : CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundColor: Color(0xff00eebc),
                                  child: Text(
                                      initial,
                                      style: GoogleFonts.roboto(
                                        textStyle: TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.white,
                                        )
                                      ),
                                  ),
                                ),
                            ),
                          ),

                          Divider(
                            height: 60,
                            thickness: 0.5,
                            color: Colors.white,
                            indent: 40,
                            endIndent: 40,
                          ),
                          MenuItem(
                              icon: Icons.notifications,
                              title: "Notifications",
                              onTap: () async{
                                Route route = MaterialPageRoute(
                                    builder: (context) => Notifications());
                                Navigator.push(context, route).then(onGoBack);
                              }
                          ),
                          MenuItem(
                              icon: Icons.perm_identity,
                              title: "Profile",
                              onTap: () async {
                                Route route = MaterialPageRoute(
                                  builder: (context) => Profile(),
                                );
                                Navigator.push(context, route).then(onGoBack);
                              }
                          ),
                          // MenuItem(
                          //   icon: Icons.settings,
                          //   title: "Settings",
                          //   onTap: () {
                          //   }
                          // ),
                          // MenuItem(
                          //   icon: Icons.account_circle,
                          //   title: "Account",
                          //   onTap: () {
                          //   }
                          // ),
                          MenuItem(
                              icon: Icons.live_help,
                              title: "Support",
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Support()),
                                );
                              }
                          ),
                          MenuItem(
                              icon: Icons.filter_none,
                              title: "Terms",
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Terms()),
                                );
                              }
                          ),
                          MenuItem(
                              icon: Icons.logout,
                              title:"Logout",
                              loading: loading,
                              onTap: () {
                                setState(() {
                                  loading=true;
                                });
                                signOut(context);
                              }
                          ),
                        ]
                    )
                ),
                );
            } else {
              return Container();
            }
          }
      );
  }
}

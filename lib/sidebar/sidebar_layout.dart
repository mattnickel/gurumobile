import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/api_login.dart';
import 'menu_item.dart';
import 'notifications.dart';


class SideBarMenu extends StatefulWidget {
  @override
  _SideBarMenuState createState() => _SideBarMenuState();
}
class _SideBarMenuState extends State<SideBarMenu>{
  String firstName;
  String tagLine;
  String avatarUrl;

  Future <List> readName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String firstName = prefs.getString("first_name");
    String tagLine= prefs.getString("tag_line")??
        "Add a tagline to people get to know you better";
    String avatarUrl= prefs.getString("avatar_url")?? "no";
    List userInfo = [tagLine, firstName, avatarUrl];
    print(userInfo);
    return userInfo;
  }


  @override
  void initState() {
    super.initState();
    readName().then((value) {
      setState(() {
        tagLine = value[0];
        firstName = value[1];
        avatarUrl = value[2];
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return firstName == null
    ? Text('Loading')
    : Drawer( child:
      Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/menu_background.png"),
              fit: BoxFit.cover,
            )
          ),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child:
          ListView(
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
                  firstName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30, fontWeight:
                    FontWeight.w800
                  ),
                ),
                subtitle: Text(
                  tagLine,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w200
                  ),
                ),
                leading: CircleAvatar(
                  child:
                    avatarUrl.length > 3
                        ? NetworkImage("$avatarUrl")
                        : Icon(
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
              onTap: () {print("here");
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Notifications()),
              );
              }
            ),
            MenuItem(
              icon: Icons.perm_identity,
              title: "Profile",
              onTap: () {

              }
            ),
            MenuItem(
              icon: Icons.settings,
              title: "Settings",
              onTap: () {
              }
            ),
            MenuItem(
              icon: Icons.account_circle,
              title: "Account",
              onTap: () {
              }
            ),
            MenuItem(
              icon: Icons.live_help,
              title: "Support",
              onTap: () {
              }
            ),
            MenuItem(
              icon: Icons.filter_none,
              title: "Terms",
              onTap: () {
              }
          ),
              MenuItem(
                  icon: Icons.logout,
                  title: "Logout",
                  onTap: () {
                    signOut(context);
                  }
              ),
          ]
         )
        ),

    );
  }


}

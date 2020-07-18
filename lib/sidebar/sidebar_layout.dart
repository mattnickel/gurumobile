import 'package:flutter/material.dart';

import 'menu_item.dart';

class SideBarMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer( child:
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: Colors.grey[800],
        child:
          Column(
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
          ]
         )
        ),

    );
  }
}

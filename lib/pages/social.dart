import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sidebar_animation/helpers/stateful_wrapper.dart';
import 'package:sidebar_animation/social_streams/social_feed.dart';

class Social extends StatefulWidget{

  @override
  _SocialState createState() => _SocialState();
  }

  class _SocialState extends State<Social> {
  String group= "My group";

  Future <String> _getGroup()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      group = prefs.getString("group")?? '';
    });

    print("here");
    return null;
  }
  @override
  void initState() {
    super.initState();
    _getGroup();
  }


  @override
  Widget build(BuildContext context) {
    return
      DefaultTabController(
          length: 2,
          child: Column(
              children: <Widget>[
                Container(
                  constraints: BoxConstraints.expand(height: 30),
                  width: 50,
                  alignment: Alignment.bottomLeft,
                  margin: const EdgeInsets.only(top: 10.0, bottom: 30.0),
                  child:
                  TabBar(
                    indicatorColor: Color(0xFF00ebcc),
                    indicatorSize: TabBarIndicatorSize.label,
                    unselectedLabelColor: Colors.black26,
                    isScrollable: true,
                    tabs: <Widget>[
                      Container(
                          alignment: Alignment.centerLeft,
                          width: 120,
                          child: Text(
                            "Social Feed",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          )


                      ),
                      Visibility(
                        visible: group != '',
                        child: Container(
                            alignment: Alignment.centerLeft,
                            width: 150,
                            child: Text(group,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            )

                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                    child: Container(
                      child: TabBarView(
                        children: [
                          SocialFeed(groupFeed: group,),
                          SocialFeed(groupFeed: group, group: group),
                        ],
                      ),
                    )
                )

              ]
          )
      );
  }
}

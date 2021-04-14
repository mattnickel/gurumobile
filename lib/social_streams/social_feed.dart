import 'package:flutter/material.dart';
import 'package:progress_indicator_button/progress_button.dart';
import 'package:sidebar_animation/models/social_post_model.dart';
import 'package:sidebar_animation/row_widgets/post_tiles.dart';
import 'package:sidebar_animation/screens/social_create_screen.dart';

class SocialFeed extends StatefulWidget{
  String group;
  String groupFeed;
  SocialFeed({this.group, this.groupFeed});
  @override
  _SocialFeed createState() => _SocialFeed();
}

class _SocialFeed extends State<SocialFeed> {
  final scrollController = ScrollController();
  SocialPostList posts;
  bool scrolling = false;
  int page = 0;

  initState(){
    posts = SocialPostList(group:widget.group);
    scrollController.addListener(() {
      if(scrollController.position.maxScrollExtent == scrollController.offset){
        if(page==0){
          page=1;
        }
        posts.loadMore(page+=1);
      }
      if(scrollController.offset >= 500){
        scrolling = true;
      } else {
        scrolling = false;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: posts.stream,
        builder:(BuildContext _context, AsyncSnapshot _snapshot)
    {
      if (!_snapshot.hasData) {
        return Container(
            child: Center(child: Container(child: Stack(
              children: [
                SizedBox(
                  height: MediaQuery
                      .of(context)
                      .size
                      .width,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                ),
                Center(child: CircularProgressIndicator()),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Text("Checking for new posts")),
              ],
            )))
        );
      } else {
        return Stack(
            children: [
              Container(
                  padding: EdgeInsets.only(bottom: 40),
                  margin: EdgeInsets.only(left: 10.0, bottom: 30.0),
                  child: RefreshIndicator(
                    onRefresh: posts.refresh,
                    child: ListView.builder(
                      controller: scrollController,
                      scrollDirection: Axis.vertical,
                      itemCount: _snapshot.data == null ? 0 : _snapshot.data
                          .length + 1,
                      itemBuilder: (context, index) {
                        if (index < _snapshot.data.length) {
                          return PostTiles(
                            post: _snapshot.data[index],
                          );
                        } else if (posts.hasMore) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 32.0),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        } else {
                          return Padding(
                              padding: EdgeInsets.symmetric(vertical: 32.0),
                              child: Center(
                                child: Text("End of Posts"),
                              )
                          );
                        }
                      },
                    ),
                  )
              ),
              Visibility(
                visible: scrolling,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(top: 18.0),
                    child: SizedBox(
                      width: 160,
                      height: 40,
                      child: ProgressButton(
                          borderRadius: BorderRadius.all(Radius.circular(18)),
// strokeWidth: 2,
                          color: Color(
                              0xff09eebc),
                          child:
                          Row(
                            children: [
                              Icon(Icons.arrow_upward, color: Colors.white),
                              Spacer(),
                              Text(
                                  ("Back to top"),
                                  style: TextStyle(
                                      color: Colors
                                          .white,
                                      fontSize: 18,
                                      fontWeight: FontWeight
                                          .bold)),
                            ],
                          ),
                          onPressed: (AnimationController controller) async {
                            controller.forward();


                            scrollController.animateTo(
                              0.0,
                              curve: Curves.easeOut,
                              duration: const Duration(milliseconds: 300),
                            );

                            setState(() {
                              scrolling = false;
                            });
                            controller
                                .reset();
                          }
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                  bottom: 160,
                  right: 45,
                  child: FloatingActionButton(
                      child:
                      Icon(Icons.add, color: Colors.white),

                      backgroundColor: Color(0xFF09eebc),
                      onPressed: () async {
                        await Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context) => SocialCreate(group:widget.groupFeed)));
// checkForNewPosts();
                      }
                  )
              ),
            ]
        );
      }
    });
  }
}
import 'package:flutter/material.dart';
import 'package:progress_indicator_button/progress_button.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sidebar_animation/models/social_post_model.dart';
import 'package:sidebar_animation/popups/social_popup.dart';
import 'package:sidebar_animation/screens/social_create_screen.dart';
import 'package:sidebar_animation/services/social_api.dart';
import '../row_widgets/post_tiles.dart';
import 'package:http/http.dart' as http;

class Social extends StatefulWidget{

  @override
  _SocialState createState() => _SocialState();
}

class _SocialState extends State<Social> {
  final scrollController = ScrollController();
  SocialPostList posts;
  var mostRecent;
  int page = 0;

  checkForNewPosts()async{
    mostRecent = await mostRecentPostTime(http.Client());
    print("Most Recent: $mostRecent");

    setState(() {});
  }

  @override

  initState(){
    posts = SocialPostList();
    scrollController.addListener(() {
      if(scrollController.position.maxScrollExtent == scrollController.offset){
        if(page==0){
          page=1;
        }
        posts.loadMore(page+=1);
      }
    });
    checkForNewPosts();
    // setState(() {});
    super.initState();
  }


  @override
  Widget build(BuildContext context){

    return StreamBuilder(
      stream: posts.stream,
      builder: (BuildContext _context, AsyncSnapshot _snapshot){
        if (! _snapshot.hasData) {
          return Container(
              child: Center(child: Container(child: Stack(
                children: [
                  SizedBox(
                    height:MediaQuery.of(context).size.width,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Center(child: CircularProgressIndicator()),
                  Align(
                      alignment:Alignment.bottomCenter,
                      child: Text("Checking for new posts")),
                ],
              )))
          );
        }else{
          return Stack(
              children: [
                Container(
                    padding: EdgeInsets.only(bottom: 40),
                    margin: EdgeInsets.only(left: 10.0, bottom:30.0),
                    child: RefreshIndicator(
                      onRefresh: posts.refresh,
                      child: ListView.builder(
                        controller: scrollController,
                        scrollDirection: Axis.vertical,
                        itemCount: _snapshot.data == null ? 0 : _snapshot.data.length +1,
                        itemBuilder: (context, index) {
                          if (index < _snapshot.data.length){
                            return PostTiles(
                              post: _snapshot.data[index],
                            );
                          } else if (posts.hasMore) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 32.0),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          } else{
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
                          visible: mostRecent != _snapshot.data[0].time,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: EdgeInsets.only(top:18.0),
                              child: SizedBox(
                                width: 160,
                                height:40,
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
                                            ("New Posts"),
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

                                      await Future
                                          .delayed(
                                          Duration(
                                              seconds: 1), () {});

                                     posts.refresh();
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
                                Icon(Icons.add),

                                backgroundColor: Color(0xFF09eebc),
                                onPressed: ()async{
                                  await Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => SocialCreate())).then((value) {
                                    var posts = checkForNewPosts();
                                  });
                                  // checkForNewPosts();
                                }
                            )
                        ),
                      ]
                  );


                }

              }
    );
  }
}

import 'package:flutter/material.dart';
import 'package:progress_indicator_button/progress_button.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
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
	bool updated;
	var date;
	var mostRecent;
	RefreshController _refreshController = RefreshController(initialRefresh: false);

	void _onRefresh() async{
		print("refresh");
		await updateSocial(http.Client());
		await Future.delayed(Duration(milliseconds: 1000));
		setState(() {

		});
		_refreshController.refreshCompleted();
  }

	void _onLoading() async{
		await Future.delayed(Duration(milliseconds: 1000));
		_refreshController.loadComplete();
		if(mounted)
			setState(() {

			});
		_refreshController.loadComplete();

}

	@override

	initState(){
		super.initState();
		checkForNewPosts();
		setState(() {});
		// final newPosts = DateTime.parse(mostRecentPostTime(http.Client()));
		// print (newPosts);

	}
	checkForNewPosts()async{
		mostRecent = await mostRecentPostTime(http.Client());
			print("Most Recent: $mostRecent");
			setState(() {});
	}


	Widget build(BuildContext context){

		bool needUpdate = false;
		return Scaffold(
		  body: FutureBuilder<List<SocialPost>>(
		  			future: fetchSocial(http.Client()),
		  			builder: (context, snapshot) {

		if(snapshot.connectionState == ConnectionState.done) {
		if(snapshot.hasError)print(snapshot.error);
		if (snapshot.hasData) {
			print(snapshot.data[0].time);

		return Stack(
		  children: [
		  Container(
		  margin: EdgeInsets.only(left: 10.0, bottom:30.0),
		  child: SmartRefresher(
				controller:_refreshController,
				onLoading: _onLoading,
				onRefresh: _onRefresh,
				enablePullDown: true,
				enablePullUp: true,
				child: ListView.builder(
		    scrollDirection: Axis.vertical,
		    itemCount: snapshot.data == null ? 0 : snapshot.data.length,
		    itemBuilder: (context, index) {
		    return PostTiles(
		    posts: snapshot.data,
		    index: index,
		    );
		    },
		    ),
		  )
		  ),
		  Visibility(
		  visible: mostRecent != snapshot.data[0].time,
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
		  updateSocial(http.Client());
		  await Future
		  		.delayed(
		  Duration(
		  seconds: 2), () {});
		  controller
		  		.reset();
		  setState(() {});
		  }
		  ),
		  ),
		  ),
		  ),
		  ),
		  Positioned(
		  bottom: 160,
		  right: 25,
		  child: FloatingActionButton(
		  child:
		  Icon(Icons.add),

		  backgroundColor: Color(0xFF09eebc),
		  onPressed: (){
		  	Navigator.push(context,
		  		MaterialPageRoute(builder: (context) => SocialCreate())).then((value) {
					var posts = checkForNewPosts();
				});
		  	// checkForNewPosts();
		  }
		  )
		  ),
		  ]
		  );


		  					} else {
		  						return Container(
		  						child: Center(child: Text("No Social posts"))
		  					);
		  					}
		  				} else { return Container(
		  						child: Center(child: Container(child: Stack(
		  							children: [
		  								SizedBox(
		  									height: 100,
		  									width: 100,
		  								),
		  								Center(child: CircularProgressIndicator()),
		  								Align(
													alignment:Alignment.bottomCenter,
													child: Text("Checking for new posts")),
		  							],
		  						)))
		  				);
		  				}
		  	}
		  )
	);
	}
}

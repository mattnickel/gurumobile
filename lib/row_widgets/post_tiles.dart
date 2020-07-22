import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PostTiles extends StatelessWidget {

  List<String> posts;
  int index;

 PostTiles({ this.posts, this.index});

  @override
  Widget build(BuildContext context) {
    return Wrap(
        children: <Widget>[
          Container(
              margin: const EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width - 40,
              child: Column(
                children: <Widget>[
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right:10),
                        child: Icon(Icons.account_circle,
                            size: 64,
                          ),
                      ),
                      Column(
                        children: [
                          Text(
                            "Author Name",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                )
                            ),
                          Align(
                                alignment: Alignment.topLeft ,
                            child: Text(
                              "Author Tagline"
                              ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "2 hrs ago",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black26,
                            ),
                          ),
                        ],
                      ),
                    ]
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(18.0),
                    child:
                      Image.asset(
                        "assets/images/" + posts[index],
                        width: MediaQuery.of(context).size.width - 40,
                        height: MediaQuery.of(context).size.width - 40,
                        fit: BoxFit.cover,
                      )
                  ),

                    ],
                  )
              )
        ],
    );
  }
}


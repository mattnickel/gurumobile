import 'package:flutter/material.dart';

import 'guru_tiles.dart';

class GuruRow extends StatelessWidget {
  String category;
  List<String> gurus;
  int index;

 GuruRow({ this.category, this.gurus, this.index});
  @override
  Widget build(BuildContext context) {
    return
    Column(
        children: <Widget>[
          Row(children: [
            Container(
              margin: EdgeInsets.only(left: 20.0, bottom:10.0),
              child: Text(
                  category,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  )
              ),
            ),
            Spacer(),
            Container(
              child: Icon(
                Icons.chevron_right,
                color: Color(0xFF00ebcc),
              ),
            ),
          ],
          ),
          Container(
              margin: EdgeInsets.only(left: 10.0, bottom:30.0),
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: gurus == null ? 0 : gurus.length,
                itemBuilder: (context, index) {
                  return GuruTiles(
                    gurus: gurus,
                    index: index,
                  );
                },
              )
          ),
        ]
    );
  }
}
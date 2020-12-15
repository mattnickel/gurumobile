import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TermsTab extends StatelessWidget{
  String title;
  String termsInfo;

  TermsTab(this.title);

  Future <String> _getInfo(title) async{
    title == "Terms and Conditions"
        ? termsInfo = await rootBundle.loadString('assets/text/terms.txt')
        : termsInfo = await rootBundle.loadString('assets/text/privacy.txt');
    return termsInfo;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder <String>(
        future: _getInfo(title),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ClipRRect(
                  borderRadius: BorderRadius.circular(18.0),
                  child: Container(
                    // margin: EdgeInsets.symmetric(horizontal: 40),
                    padding: EdgeInsets.only(top:20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: ListView(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topCenter,
                            child: Text(title,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                            )),
                          ),
                          Container(
                              padding: EdgeInsets.all(20.0),
                              child: Text(snapshot.data)
                          )
                        ]
                    ),
                  ),
                );
          } else {
            return Container();
          }
        }
    );
  }
}
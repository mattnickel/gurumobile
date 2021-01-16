import 'package:flutter/material.dart';

AlertDialog termsPopup(title, info, context) {
  return AlertDialog(
      contentPadding: EdgeInsets.only(left: 25, right: 25),
      title: Center(
        child: Padding(
          padding:EdgeInsets.only(bottom: 15),
          child: Text(
            title,
            style: TextStyle(fontSize:18,fontWeight: FontWeight.bold ),

          ),),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      content: Container(
        child: SingleChildScrollView(
            child: Column(
                children: <Widget>[
                  Container(
                    child: Text(info) ,

                  ),
                ]
            )
        ),
      ),
      actions: <Widget>[
        Container(
          width:MediaQuery.of(context).size.width,
          child: Align(
            alignment: Alignment.center,
            child:
            Container(
              width: MediaQuery.of(context).size.width * 0.60,
              child: RaisedButton(
                child: Text(
                  'CONTINUE',

                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),

                ),
                color: Color(0xff00eebc),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                onPressed: () {
                  //saveIssue();
                  Navigator.of(context).pop();
                },
              ),
            ),

          ),
        ),
      ]
  );

}
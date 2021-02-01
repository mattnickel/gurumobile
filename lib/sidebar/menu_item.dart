import 'package:flutter/material.dart';

import 'notifications.dart';

class MenuItem extends StatelessWidget {

  final IconData icon;
  final String title;
  final Function onTap;
  final bool loading;

  const MenuItem({Key key, this.icon, this.title, this.onTap, this.loading=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child:
        FlatButton(
          child: Row(
            children: <Widget>[
              Icon(
                  icon,
                  color: Colors.white,
                  size:24,
              ),
              SizedBox(
                width: 20,
              ),
              loading
                  ? CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.white30) )
                  : Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 22,
                  color: Colors.white,
                )
              )
            ],
        ),

      ),
    ),
    );
  }
}
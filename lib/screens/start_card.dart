import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class StartCard extends StatelessWidget {

  String title1;
  String title2;
  String description;
  String startImage;

  StartCard({ this.title1, this.title2, this.description, this.startImage});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
            width: MediaQuery.of(context).size.width,
            height:MediaQuery.of(context).size.height,
            child: Image.asset(
              "assets/images/${startImage}",
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
        ),
        Positioned(
        top: 60,
        left:25,
          child: RichText(

            text: TextSpan(
                text: title1.toUpperCase(),
                style: GoogleFonts.roboto(
                  textStyle:TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                children: <TextSpan>[
                TextSpan(text:" "),
                  TextSpan(
                    text:
                      title2.toUpperCase(),
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                          color: Color(0xFF09ebcc),
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                        )
                      ),
                  ),
                        ]
                  )
              ),
          ),
        Positioned(
          top: 108,
          left:25,
          child: Padding(
            padding: const EdgeInsets.only(right:40),
            child: Container(
              width: MediaQuery.of(context).size.width - 40,
              child: Text(
                  description.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.white),
                  ),
            ),
          )
          ),

      ],
    );
  }
}


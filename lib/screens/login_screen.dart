
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sidebar_animation/framework_page.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  SharedPreferences sharedPreferences;
  Image backgroundImage;
  bool _isLoading = false;
  bool _isEnabled = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    emailController.addListener( _enableSignin);
    passwordController.addListener(  _enableSignin);
  }

  _enableSignin() {
      setState(() {
        _isEnabled = true;
      });
   }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/adventure.png'),
                  fit:BoxFit.cover
              )
          ),
        child: _isLoading ? Center (
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text("Logging In...",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      )),
                )
              ],
            )) : ListView(
          children: <Widget>[
            headerSection(),
            textSection(),
            buttonSection(),
          ],
        ),
      ),
    );
  }

  _moveForward() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => FrameworkPage()), (
        Route<dynamic> route) => false);
  }

  signIn(String email, pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'email': email,
      'password': pass
    };
    var jsonResponse;
    var response = await http.post("YOUR_BASE_URL", body: data);
    if(response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if(jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
        sharedPreferences.setString("token", jsonResponse['token']);
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => FrameworkPage()), (Route<dynamic> route) => false);
      }
    }
    else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }
  }

  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.only(top: 5.0),
      child: RaisedButton(
        onPressed:  emailController.text == "" || passwordController.text == "" ? null : () {
          setState(() {
            _isLoading = true;
          });
          _moveForward();
          signIn(emailController.text, passwordController.text);
        },
        elevation: 0.2,
        color: Color(0xffFF6051),
        disabledColor: Color.fromRGBO(255,96,81, 0.5),
        child: Text("Sign In", style: TextStyle(color: Colors.white)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      ),
    );
  }


  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }


  Container textSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: TextField(
                  controller: emailController,
                  cursorColor: Colors.black54,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors.black54),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
                    prefixIcon: Icon(Icons.email, color: Colors.black54),
                    filled:true,
                    fillColor: Colors.white,
                    focusColor: Colors.white,
                    hintText: "Email",
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      borderSide: BorderSide(color: Color(00000000)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      borderSide: BorderSide(color: Color(0xffFF6051)),
                    ),
                    hintStyle: TextStyle(color: Colors.black54),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: passwordController,
                cursorColor: Colors.black54,
                obscureText: true,
                style: TextStyle(color: Colors.black54),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
                  prefixIcon: Icon(Icons.lock, color: Colors.black54),
                  filled:true,
                  fillColor: Colors.white,
                  focusColor: Colors.white,
                  hintText: "Password",
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    borderSide: BorderSide(color: Color(00000000)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    borderSide: BorderSide(color: Color(0xffFF6051)),
                  ),
                  hintStyle: TextStyle(color: Colors.black54),
                ),
              ),
            ],
          ),
    );
  }

  Container headerSection() {
    return Container(
      margin: EdgeInsets.only(top: 200.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
//      child: Text("Sign In",
//          style: TextStyle(
//              color: Color(0xff606060),
//              fontSize: 30.0,
//              fontWeight: FontWeight.bold
//          )
//      ),
    );
  }
}


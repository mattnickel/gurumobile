
import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sidebar_animation/framework_page.dart';
import 'package:sidebar_animation/popups/terms_popup.dart';
import 'package:sidebar_animation/screens/reset_password.dart';
import 'package:sidebar_animation/screens/signup_screen.dart';
import 'package:sidebar_animation/services/api_login.dart';



class LoginPage extends StatefulWidget {
final String errorMessage;
const LoginPage(this.errorMessage);
  @override

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  SharedPreferences prefs;
  Image backgroundImage;
  bool _isLoading = false;
  bool _isEnabled = false;
  String email;
  String privacyInfo;
  String termsInfo;
  Future<String> loadAsset(String s) async {
    return await rootBundle.loadString(s);
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getEmail();
    // Start listening to changes.
    emailController.addListener(_enableSignin);
    passwordController.addListener(_enableSignin);
  }
  _getEmail() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString("email");
    if (email != null) {
      print("here");
      setState(() {
        emailController.text = email;
      });

    }
  }
  _enableSignin() {
      setState(() {
        _isEnabled = true;
      });
   }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(

              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/adventure3.png'),
                      fit:BoxFit.cover
                  )
              ),
            child: _isLoading ? Center (
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.black54),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text("Logging In...",
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                          )),
                    )
                  ],
                )) : ListView(
              children: <Widget>[
                headerSection(),
                newUserSection(),
                formSection(),
                errorSection(),
                buttonSection(),
                forgotPasswordSection(),

              ],
            ),

          ),
          termsSection(),
        ],
      ),

    );
  }
  Align forgotPasswordSection(){
    return Align(
      alignment: Alignment.center,
      child: FlatButton(child:
      Text(
        'Forgot Password?',
        style: TextStyle(
          color: Colors.black54,
          decoration: TextDecoration.underline,
        ),
      ),
        onPressed: (){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ResetPassword()));
        },),
    );
  }
  Padding newUserSection(){
    return Padding(
      padding: const EdgeInsets.only(left:25.0),
      child: Row(
          children:<Widget>[
            Text('New user?', style: TextStyle(
                color: Colors.black54
            ),
            ),
            FlatButton(child:
            Text(
              'Sign up',
              style: TextStyle(
                color: Colors.black54,
                decoration: TextDecoration.underline,
              ),
            ),
              onPressed: (){
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => SignupPage("")), (Route<dynamic> route) => false);
              },)
          ]
      ),
    );
  }
  Positioned termsSection(){
    return Positioned(
      bottom: 0,
      right: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        color:Colors.white70,
        child: Align(
            alignment:Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0, top:10.0),
              child: RichText(
                  textAlign: TextAlign.center,
                  text:TextSpan(
                      text: "By logging in, you're agreeing to our \n",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: "Terms of Use",
                            recognizer: new TapGestureRecognizer()
                              ..onTap = () async {
                                termsInfo = await rootBundle.loadString('assets/text/terms.txt');
                                await showDialog(
                                    context:context,
                                    builder:(BuildContext context){
                                      return termsPopup("Terms of Use", termsInfo, context);
                                    }
                                );
                              },
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            )
                        ),
                        TextSpan(
                          text: " and ",
                        ),
                        TextSpan(
                            text: "Privacy Policy",
                            recognizer: new TapGestureRecognizer()
                              ..onTap = () async{
                                privacyInfo = await rootBundle.loadString('assets/text/privacy.txt');
                                print("here");
                                await showDialog(
                                    context:context,
                                    builder:(BuildContext context){
                                      return termsPopup("Privacy Policy", privacyInfo, context);
                                    }
                                );

                              },
                            style: TextStyle(
                              decoration: TextDecoration.underline,)
                        ),
                        TextSpan(
                          text: ".",
                        ),
                      ]
                  )
              ),
            )
        ),
      ),
    );
  }
  Container errorSection(){
    return Container(
        child:
          widget.errorMessage.length > 1
         ? Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Icon(Icons.error_outline), SizedBox(width: 5.0),
                  Text(
                  widget.errorMessage
                  ),
                ],
              ),
          ))
          : null,
    );
  }
  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.only(top: 0),
      child: RaisedButton(
        onPressed:  emailController.text == "" || passwordController.text == "" ? null : () {
          setState(() {
            _isLoading = true;
          });
          signIn(emailController.text, passwordController.text, context, prefs);
        },
        elevation: 0.2,
        color: Color(0xff00eebc),
        disabledColor: Color.fromRGBO(0,238,188, 0.25),
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


  Container formSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: TextFormField(
                  controller: emailController,
                  validator: (value){
                    if(value.isEmpty){
                    return 'Email cannot be empty';
                    }
                    return null;
                  },
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
                      borderSide: BorderSide(color: Color(0xff00eebc)),
                    ),
                    hintStyle: TextStyle(color: Colors.black54),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: passwordController,
                validator: (value){
                  if(value.isEmpty){
                    return 'Password cannot be empty';
                  }
                  return null;
                },
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
                    borderSide: BorderSide(color: Color(0xff00eebc)),
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
      margin: EdgeInsets.only(top: 100.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0),
     child: Text("Welcome back!",
         style: TextStyle(
             color: Color(0xff606060),
             fontSize: 30.0,
             fontWeight: FontWeight.bold
         )
     ),
    );
    //
  }
}


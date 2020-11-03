
import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sidebar_animation/services/api_login.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'login_screen.dart';



class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormBuilderState> _formBKey = GlobalKey<FormBuilderState>();
  SharedPreferences prefs;
  Image backgroundImage;
  bool _isLoading = false;
  bool _isEnabled;
  String privacyInfo;
  String termsInfo;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _isEnabled = false;
    // Start listening to changes.
    emailController.addListener(_enableSignin);
    passwordController.addListener( _enableSignin);
    firstNameController.addListener( _enableSignin);

  }
  _enableSignin() {
    setState(() {
      _isEnabled = true;
    });
  }
  Future<String> loadAsset(String s) async {
    return await rootBundle.loadString(s);
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
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
                  child: Text("Signing Up...",
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      )),
                )
              ],
            )) : ListView(
          children: <Widget>[
            headerSection(),
            formSection(),
            passwordInfoSection(),
            buttonSection(),
            termsSection()

          ],
        ),
      ),
    );
  }
  Padding termsSection(){
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Align(
        alignment:Alignment.bottomCenter,
        child: RichText(
            textAlign: TextAlign.center,
          text:TextSpan(
            text: "By signing up, you're agreeing to our \n",
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
                      showDialog(
                        context:context,
                        builder:(BuildContext context){
                          return infoPopup("Terms of Use", termsInfo);
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
                      showDialog(
                          context:context,
                          builder:(BuildContext context){
                            return infoPopup("Privacy Policy", privacyInfo);
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
        )
      ),
    );
  }
  Padding signupInstead(){
   return Padding(
     padding: const EdgeInsets.only(left:23.0),
     child: Row(
          // mainAxisAlignment: MainAxisAlignment.left,
          children:<Widget>[
            Text('Already Signed Up?', style: TextStyle(
                color: Colors.black54
            ),
            ),
            FlatButton(child:
            Text(
              'Log in',
              style: TextStyle(
                color: Colors.black54,
                decoration: TextDecoration.underline,
              ),
            ),
              onPressed: (){
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginPage("")), (Route<dynamic> route) => false);
              },)
          ]
      ),
   );
  }
  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.only(top: 5.0),
      child: RaisedButton(
        onPressed: emailController.text == "" || passwordController.text == "" || firstNameController.text == "" ? null : () {
          if (_formBKey.currentState.validate()) {
            signUp(emailController.text, passwordController.text, firstNameController.text, context);
          };
        },
        elevation: 0.2,
        color: Color(0xff00eebc),
        disabledColor: Color.fromRGBO(0,238,188, 0.25),
        child: Text("Sign Up", style: TextStyle(color: Colors.white)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      ),
    );
  }
Container passwordInfoSection(){
    return Container(
      // width: MediaQuery.of(context).size.width,
      height: 40.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35.0),
          child: Text(
            "Your password must be 6 or more characters long & contain a mix of upper & lower case letters, numbers, and symbols.",
              style: TextStyle(color: Colors.black54, fontSize: 12)
          ),
        )
    );
}
  AlertDialog infoPopup(title, info) {
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


  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    super.dispose();
  }


  Container formSection() {
    return Container(
      padding: EdgeInsets.only(top: 15, bottom: 10, left:20, right:20),
      child: FormBuilder(
        key: _formBKey,
        child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: FormBuilderTextField(
                    keyboardType: TextInputType.text,
                    maxLines:1,
                    attribute:"firstName",
                    controller: firstNameController,
                    validators: [FormBuilderValidators.required(),FormBuilderValidators.maxLength(25) ],
                    cursorColor: Colors.black54,
                    style: TextStyle(color: Colors.black54),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
                      prefixIcon: Icon(Icons.person_rounded, color: Colors.black54),
                      filled:true,
                      fillColor: Colors.white,
                      focusColor: Colors.white,
                      hintText: "First Name",
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
                Container(
                  alignment: Alignment.center,
                  child: FormBuilderTextField(
                    attribute:"email",
                    controller: emailController,
                    validators: [FormBuilderValidators.email(),FormBuilderValidators.required()],
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
                Container(
                  child: FormBuilderTextField(
                    attribute:"password",
                    controller: passwordController,
                    validators:[FormBuilderValidators.pattern(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$', errorText: "Invalid password: A capital letter, number, and symbol required"), FormBuilderValidators.required(), FormBuilderValidators.min(6)],
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
                ),
              ],
            ),
      ),
    );
  }

  Stack headerSection() {
    double topHeight =  MediaQuery.of(context).size.height/15;
    return Stack(
      children: [
        Container(
          // margin: EdgeInsets.only(top: 150.0),
          padding: EdgeInsets.only(top:topHeight, left: 20.0),
         height: 120,
         width: double.infinity,
         child: Text("Get Started!",
             style: TextStyle(
                 color: Color(0xff606060),
                 fontSize: 30.0,
                 fontWeight: FontWeight.bold
             )
         ),
        ),
        Positioned(
          bottom: 10,
             child: signupInstead(),
        )
      ],
    );
  }
}


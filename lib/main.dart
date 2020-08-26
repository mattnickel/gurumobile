import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './screens/splash_page.dart';





void main() {
  SharedPreferences.setMockInitialValues({});
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primaryColor: Colors.white
        ),
        home: SplashPage()
    );
  }
}
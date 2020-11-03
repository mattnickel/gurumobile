import 'package:flutter/material.dart';
import 'package:sidebar_animation/screens/set_goals.dart';

// import 'package:sidebar_animation/screens/set_goals.dart';
// import 'package:sidebar_animation/screens/start_screen.dart';
import './screens/splash_page.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {

  @override

  Widget build(BuildContext context) {
    return new MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            primaryColor: Colors.white,
            splashColor: Color(0xFF00ebcc),
          ),
          home: SplashPage()
          // home: SetGoals()
      );
  }
}

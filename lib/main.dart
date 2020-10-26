import 'package:flutter/material.dart';
import 'package:sidebar_animation/framework_page.dart';
import 'package:sidebar_animation/screens/splash_app.dart';
import 'package:sidebar_animation/screens/start_screen.dart';
import './screens/splash_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MainApp());

}

class MainApp extends StatelessWidget {


  @override

  Widget build(BuildContext context) {
    return

      MaterialApp(

          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            primaryColor: Colors.white,
            splashColor: Color(0xFF00ebcc),
          ),
          home: StartScreen()
      );
  }
}

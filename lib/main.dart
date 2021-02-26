import 'package:flutter/material.dart';
import 'package:sidebar_animation/pages/home.dart';
import './screens/splash_page.dart';
import 'framework_page.dart';
import 'package:firebase_core/firebase_core.dart';

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {

  @override

  Widget build(BuildContext context) {
    return new MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
              // Define the default brightness and colors.

              brightness: Brightness.light,
              primaryColor: Colors.white,
              accentColor: Color(0xFF09ebcc),
            colorScheme: ColorScheme.light(
              primary: Color(0xFF09ebcc),
              onPrimary: Colors.white,
                secondary: Colors.white,
              // surface:Colors.black,
              // onSurface:  Color(0xFF00ebcc),
            ),



            ),



          home: SplashPage(),
          // home: SetGoals(),
          routes: <String, WidgetBuilder>{
            '/home': (BuildContext context) => new HomePage(),
            '/framework':(BuildContext context) => new FrameworkPage(),
          }
      );
  }
}

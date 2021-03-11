import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sidebar_animation/pages/home.dart';
import './screens/splash_page.dart';
import 'framework_page.dart';
import 'package:firebase_core/firebase_core.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  // SharedPreferences.setMockInitialValues({});
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override

  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Center(
            child: Text("Looks like something went wrong")
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
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
          );;
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.black54),
        );
      },
    );
  }
}

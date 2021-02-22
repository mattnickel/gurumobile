import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sidebar_animation/pages/home.dart';
import 'package:sidebar_animation/screens/set_goals.dart';
import './screens/splash_page.dart';
import 'framework_page.dart';

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // var initializationSettingsAndroid =
  // AndroidInitializationSettings('lm_app_logo');
  // var initializationSettingsIOS = IOSInitializationSettings(
  //     requestAlertPermission: true,
  //     requestBadgePermission: true,
  //     requestSoundPermission: true,
  //     onDidReceiveLocalNotification:
  //         (int id, String title, String body, String payload) async {});
  // var initializationSettings = InitializationSettings(
  //     android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  // await flutterLocalNotificationsPlugin.initialize(initializationSettings,
  //     onSelectNotification: (String payload) async {
  //       if (payload != null) {
  //         debugPrint('notification payload: ' + payload);
  //       }
  //     });
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

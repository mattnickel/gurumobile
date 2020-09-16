import 'package:flutter/material.dart';
import './screens/splash_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';






Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  final storage = FlutterSecureStorage();

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
        home: SplashPage()
    );
  }
}
import 'package:flutter/material.dart';
// import 'package:testing_firebase_login/pages/auth_page.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:login_page/pages/auth_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Urbanist',
        scaffoldBackgroundColor: Colors.blueGrey,
        brightness: Brightness.dark,
      ),
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
    );
  }
}

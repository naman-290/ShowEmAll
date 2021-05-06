import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:streaming_app/screens/home.dart';
import 'package:streaming_app/screens/login.dart';
import 'package:streaming_app/screens/signup.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(
          seconds: 5,
          navigateAfterSeconds: homeScreen(),
          gradientBackground:
              LinearGradient(colors: [Colors.lightBlue, Colors.blueAccent]),
          title: new Text('Welcome to Streaming app ',
              style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
          styleTextUnderTheLoader: new TextStyle(),
          photoSize: 100.0,
          loaderColor: Colors.red),
    );
  }
}

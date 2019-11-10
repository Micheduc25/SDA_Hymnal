import 'package:flutter/material.dart';
import 'package:sda_hymnal/constants/hymsexample.dart';
import 'package:sda_hymnal/db/dbConnection.dart';
import 'package:sda_hymnal/screens/homeScreen.dart';
import 'package:sda_hymnal/screens/hymScreen.dart';
import 'package:sda_hymnal/screens/splashscreen.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  @override
  Widget build(BuildContext context) {
     
    return MaterialApp(
        routes: {
          'splash': (context) => SplashScreen(),
          'home': (context) => HomeScreen()
        },
        title: 'SDA Hym App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen());
  }
}

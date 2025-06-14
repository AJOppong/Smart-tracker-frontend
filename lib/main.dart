import 'package:flutter/material.dart';
import 'package:frontend/main_navigation.dart';
import 'home_screen.dart'; 


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      title: 'Smart Tracker',
      theme: ThemeData(
        primarySwatch: Colors.green, 
      ),
      home: HomeScreen(), // Tells the app to load the HomeScreen first
    );
  }
}

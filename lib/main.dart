// lib/main.dart
import 'package:flutter/material.dart';
import 'package:responsi_naura/screen/home_screen.dart';
import 'package:responsi_naura/screen/login_screen.dart';

void main() {
  runApp(AmiiboApp());
}

class AmiiboApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nintendo Amiibo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}
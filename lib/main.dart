import 'package:flutter/material.dart';
import 'package:responsi_naura/screen/home_screen.dart';
import 'package:responsi_naura/screen/login_screen.dart';
import 'package:responsi_naura/screen/register_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ' Nitendo Amiibo App',
      debugShowCheckedModeBanner: false, // Hilangkan label debug
      initialRoute: '/login', // Halaman pertama yang ditampilkan
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => HomeScreen(), // Pastikan route ke home benar
        // Tambahkan route untuk halaman lainnya jika diperlukan
      },
    );
  }
}

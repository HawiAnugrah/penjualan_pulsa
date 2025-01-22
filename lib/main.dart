import 'package:flutter/material.dart';
import 'screens/home_screen.dart'; // Sesuaikan dengan lokasi file HomeScreen Anda

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hapus label debug
      title: 'Jual Pulsa',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

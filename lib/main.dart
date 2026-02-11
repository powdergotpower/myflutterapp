import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'first_screen.dart';  // ← import your file

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Valentine's Day Surprise",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        scaffoldBackgroundColor: Colors.pink[50],
      ),
      home: const FirstScreen(),  // ← start with your beautiful screen
    );
  }
}

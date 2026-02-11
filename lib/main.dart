import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:valentines_app/book_screen.dart';
import 'package:valentines_app/home_screen.dart';
import 'package:valentines_app/second_screen.dart';
import 'package:valentines_app/third_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Valentine\'s Day Surprise',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        scaffoldBackgroundColor: Colors.pink[50],
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const IntroScreen(),
        '/home': (context) => const HomeScreen(),
        '/second': (context) => const SecondScreen(),
        '/third': (context) => const ThirdScreen(),
        '/book': (context) => const BookScreen(),
      },
    );
  }
}

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _playMusic();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  Future<void> _playMusic() async {
    await _audioPlayer.play(AssetSource('audio/love.mp3'), volume: 0.5);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background with floating hearts
          ...List.generate(10, (index) => Positioned(
                left: index * 40.0,
                child: Image.asset('assets/images/heart.png', width: 50)
                    .animate(
                      onPlay: (controller) => controller.repeat(),
                    )
                    .moveY(
                      begin: 800,
                      end: -100,
                      duration: const Duration(seconds: 5 + index),
                      curve: Curves.easeInOut,
                    ),
              )),
          const Center(
            child: Text(
              'Happy Valentine\'s Day Surprise!',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

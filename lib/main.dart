import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const ValentineApp());
}

class ValentineApp extends StatelessWidget {
  const ValentineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ValentineHome(),
    );
  }
}

class ValentineHome extends StatefulWidget {
  const ValentineHome({super.key});

  @override
  State<ValentineHome> createState() => _ValentineHomeState();
}

class _ValentineHomeState extends State<ValentineHome>
    with TickerProviderStateMixin {
  late AnimationController _textController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _textController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    _fadeAnimation =
        CurvedAnimation(parent: _textController, curve: Curves.easeIn);

    _textController.forward();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _showLetter() {
    showDialog(
      context: context,
      builder: (_) => const LoveLetterDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFE6EA),
      body: Stack(
        children: [
          // Background grid
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFFFE6EA), Color(0xFFFFD1DC)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          // Floating hearts
          const Positioned(
              top: 80, left: 40, child: Icon(Icons.favorite, color: Colors.pink, size: 30)),
          const Positioned(
              bottom: 120, right: 60, child: Icon(Icons.favorite, color: Colors.red, size: 40)),

          // Main Content
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // LEFT SIDE
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: const Text(
                          "Happy",
                          style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                    color: Colors.black,
                                    offset: Offset(2, 2),
                                    blurRadius: 3)
                              ]),
                        ),
                      ),
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: const Text(
                          "Valentine’s Day",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.pink,
                              shadows: [
                                Shadow(
                                    color: Colors.black,
                                    offset: Offset(2, 2),
                                    blurRadius: 3)
                              ]),
                        ),
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                        ),
                        onPressed: _showLetter,
                        icon: const Icon(Icons.mail),
                        label: const Text("Open My Heart"),
                      )
                    ],
                  ),
                ),

                // RIGHT SIDE
                Expanded(
                  flex: 6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 250,
                        height: 250,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black, width: 5),
                          image: const DecorationImage(
                            image: AssetImage("assets/love.jpg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        decoration: BoxDecoration(
                            color: Colors.pink,
                            borderRadius: BorderRadius.circular(30),
                            border:
                                Border.all(color: Colors.black, width: 2)),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.favorite, color: Colors.white),
                            SizedBox(width: 10),
                            Text(
                              "My Valentine",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 10),
                            Icon(Icons.favorite, color: Colors.white),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class LoveLetterDialog extends StatelessWidget {
  const LoveLetterDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(0xFFFFF0F5)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              "To My Love 💕",
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink),
            ),
            SizedBox(height: 20),
            Text(
              "You are the most beautiful part of my life. "
              "Every moment with you feels magical. "
              "On this Valentine’s Day, I just want you to know "
              "how deeply I love you. ❤️",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final ConfettiController _confettiController = ConfettiController(duration: const Duration(seconds: 3));
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    // Optional: play soft romantic music here
    // AudioPlayer().play(AssetSource('audio/soft_love.mp3'));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _onScreenTap(TapDownDetails details) {
    // Burst hearts on touch location
    _confettiController.play();

    // You can add more effects like scaling a heart at touch point if you want
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onScreenTap,
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            // Dreamy gradient background
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFFFE4E1), // misty rose
                    Color(0xFFFFC1CC),
                    Color(0xFFEE82EE), // violet
                    Color(0xFFF06292),
                  ],
                ),
              ),
            ),

            // Floating hearts (fall from top once, staggered)
            ...List.generate(18, (index) {
              final delay = 400 + (index * 180); // staggered start
              final left = 20 + _random.nextDouble() * (MediaQuery.of(context).size.width - 100);
              final duration = 5000 + _random.nextInt(4000); // 5-9 seconds fall

              return Positioned(
                left: left,
                top: -80,
                child: Image.asset(
                  'assets/images/heart.png', // different sizes/colors if you have variants
                  width: 36 + _random.nextDouble() * 24,
                  color: Colors.red.withOpacity(0.7 + _random.nextDouble() * 0.3),
                )
                    .animate(
                      delay: Duration(milliseconds: delay),
                      onComplete: (controller) => controller.reset(),
                    )
                    .fadeIn(duration: 800.ms)
                    .slideY(
                      begin: -1.2,
                      end: 2.5,
                      duration: Duration(milliseconds: duration),
                      curve: Curves.easeIn,
                    )
                    .fadeOut(delay: Duration(milliseconds: duration - 800)),
              );
            }),

            // Confetti burst on touch (customized to hearts)
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                colors: const [Colors.pinkAccent, Colors.redAccent, Colors.purpleAccent, Colors.white],
                numberOfParticles: 40,
                maxBlastForce: 60,
                minBlastForce: 20,
                emissionFrequency: 0.04,
                gravity: 0.3,
                // Optional: heart shape (advanced)
                createParticlePath: (size) => Path()
                  ..moveTo(size.width / 2, size.height)
                  ..cubicTo(size.width * 0.05, size.height * 0.25, 0, -size.height * 0.25, size.width / 2, size.height * 0.35)
                  ..cubicTo(size.width, -size.height * 0.25, size.width * 0.95, size.height * 0.25, size.width / 2, size.height),
              ),
            ),

            // Main content - centered, fades in sequence
            SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(flex: 2),

                    // Her photo in glowing circle
                    Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white.withOpacity(0.7), width: 4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.pinkAccent.withOpacity(0.6),
                            blurRadius: 25,
                            spreadRadius: 8,
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/love.jpg', // ← put her photo here
                          fit: BoxFit.cover,
                        ),
                      ),
                    ).animate().scaleXY(begin: 0.4, end: 1.0, duration: 1200.ms, curve: Curves.elasticOut).fadeIn(delay: 300.ms),

                    const SizedBox(height: 30),

                    // Main text - elegant & romantic
                    const Text(
                      "Happy Valentine's Day\nMy Love ❤️",
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        height: 1.15,
                        shadows: [
                          Shadow(blurRadius: 20, color: Colors.pinkAccent, offset: Offset(0, 4)),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ).animate().fadeIn(delay: 900.ms).slideY(begin: 0.4, end: 0, duration: 1000.ms, curve: Curves.easeOutCubic),

                    const Spacer(),

                    // Continue button - appears last
                    Padding(
                      padding: const EdgeInsets.only(bottom: 50),
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to next screen
                          // Navigator.pushNamed(context, '/second');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.9),
                          foregroundColor: Colors.redAccent,
                          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 18),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                          elevation: 12,
                          shadowColor: Colors.pinkAccent.withOpacity(0.5),
                        ),
                        child: const Text(
                          "Continue →",
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ).animate().fadeIn(delay: 1800.ms).scale(
                        begin: const Offset(0.8, 0.8),  // 80% scale on both X and Y
                        end: const Offset(1.0, 1.0),    // back to 100%
                        duration: const Duration(milliseconds: 800),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

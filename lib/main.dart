import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const ValentineApp());
}

class ValentineApp extends StatelessWidget {
  const ValentineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ValentineHome(),
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
  late AnimationController _heartController;
  late AnimationController _glowController;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _textController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    _heartController =
        AnimationController(vsync: this, duration: const Duration(seconds: 6))
          ..repeat();

    _glowController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat(reverse: true);

    _fadeAnimation =
        CurvedAnimation(parent: _textController, curve: Curves.easeIn);

    _slideAnimation = Tween<Offset>(
      begin: const Offset(-0.3, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
        parent: _textController, curve: Curves.easeOutCubic));

    _textController.forward();
  }

  @override
  void dispose() {
    _textController.dispose();
    _heartController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  void _showLetter() {
    showDialog(context: context, builder: (_) => const LoveLetterDialog());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFFE3EC), Color(0xFFFFC1D6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // Floating Hearts
          ...List.generate(
            15,
            (index) => _FloatingHeart(
              controller: _heartController,
              delay: index * 0.15,
            ),
          ),

          // Main Content
          Center(
            child: Row(
              children: [
                // LEFT SIDE
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: SlideTransition(
                          position: _slideAnimation,
                          child: const Text(
                            "Happy",
                            style: TextStyle(
                              fontSize: 52,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                    color: Colors.pinkAccent,
                                    blurRadius: 20,
                                    offset: Offset(0, 6))
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: const Text(
                          "Valentine’s Day",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFE91E63),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Gradient Button
                      _GradientButton(
                        text: "Open My Heart",
                        icon: Icons.mail,
                        onTap: _showLetter,
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
                      AnimatedBuilder(
                        animation: _glowController,
                        builder: (context, child) {
                          return Container(
                            width: 260,
                            height: 260,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: const LinearGradient(
                                colors: [
                                  Colors.pinkAccent,
                                  Colors.white,
                                  Colors.pink
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.pinkAccent.withOpacity(
                                      0.6 * _glowController.value),
                                  blurRadius: 40,
                                  spreadRadius: 8,
                                )
                              ],
                            ),
                            child: Container(
                              margin: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image:
                                      AssetImage("assets/love.jpg"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 30),

                      const _ValentineTag(),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// Floating Hearts
class _FloatingHeart extends StatelessWidget {
  final AnimationController controller;
  final double delay;

  const _FloatingHeart(
      {required this.controller, required this.delay});

  @override
  Widget build(BuildContext context) {
    final random = Random();
    final size = random.nextDouble() * 25 + 15;
    final left = random.nextDouble() *
        MediaQuery.of(context).size.width;

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        double progress = (controller.value + delay) % 1;
        return Positioned(
          bottom:
              progress * MediaQuery.of(context).size.height,
          left: left,
          child: Opacity(
            opacity: 1 - progress,
            child: Icon(
              Icons.favorite,
              color: Colors.pinkAccent.withOpacity(0.8),
              size: size,
            ),
          ),
        );
      },
    );
  }
}

// Gradient Button
class _GradientButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;

  const _GradientButton(
      {required this.text,
      required this.icon,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        gradient: const LinearGradient(
          colors: [Color(0xFFFF5C8D), Color(0xFFE91E63)],
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.pinkAccent,
            blurRadius: 15,
            offset: Offset(0, 8),
          )
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(40),
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.mail, color: Colors.white),
              const SizedBox(width: 10),
              Text(
                text,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Valentine Tag
class _ValentineTag extends StatefulWidget {
  const _ValentineTag();

  @override
  State<_ValentineTag> createState() => _ValentineTagState();
}

class _ValentineTagState extends State<_ValentineTag>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulse;

  @override
  void initState() {
    super.initState();
    _pulse =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween(begin: 1.0, end: 1.08).animate(_pulse),
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFF5C8D), Color(0xFFE91E63)],
          ),
          borderRadius: BorderRadius.circular(40),
        ),
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
      ),
    );
  }
}

class LoveLetterDialog extends StatelessWidget {
  const LoveLetterDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: const LinearGradient(
            colors: [Color(0xFFFFF0F5), Color(0xFFFFE3EC)],
          ),
        ),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
              "how deeply I love you.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

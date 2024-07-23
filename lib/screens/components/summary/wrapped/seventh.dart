import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class SeventhPage extends StatefulWidget {
  const SeventhPage({super.key});

  @override
  State<SeventhPage> createState() => _SeventhPageState();
}

class _SeventhPageState extends State<SeventhPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    
    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);
    
    _controller.forward();

    _confettiController = ConfettiController(duration: const Duration(seconds: 2));
    _confettiController.play();  // Start the confetti animation when the screen is displayed
  }

  @override
  void dispose() {
    _controller.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          'menu.dart',
        );
      },
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: AnimatedBuilder(
            animation: _opacityAnimation,
            builder: (context, child) {
              return Opacity(
                opacity: _opacityAnimation.value,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: ConfettiWidget(
                          confettiController: _confettiController,
                          blastDirection: 0,
                          shouldLoop: false,
                          colors: const [Color.fromARGB(255, 243, 105, 137), Color.fromARGB(255, 211, 39, 79), Color.fromARGB(255, 252, 19, 74), Color.fromARGB(255, 255, 157, 180)],  // Different colors of confetti
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: ConfettiWidget(
                          confettiController: _confettiController,
                          blastDirection: 0,
                          shouldLoop: false,
                          colors: const [Color.fromARGB(255, 243, 105, 137), Color.fromARGB(255, 211, 39, 79), Color.fromARGB(255, 252, 19, 74), Color.fromARGB(255, 255, 157, 180)],  // Different colors of confetti
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: ConfettiWidget(
                          confettiController: _confettiController,
                          blastDirection: 0,
                          shouldLoop: false,
                          colors: const [Color.fromARGB(255, 243, 105, 137), Color.fromARGB(255, 211, 39, 79), Color.fromARGB(255, 252, 19, 74), Color.fromARGB(255, 255, 157, 180)],  // Different colors of confetti
                        ),
                      ),
                      const Text(
                        'Muchas gracias',
                        style: TextStyle(fontSize: 24),
                      ),
                      const Text(
                        'por confiar en nosotros',
                        style: TextStyle(fontSize: 24),
                      ),
                      const Text(
                        '💕✨',
                        style: TextStyle(fontSize: 24),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: ConfettiWidget(
                          confettiController: _confettiController,
                          blastDirection: 0,
                          shouldLoop: false,
                          colors: const [Color.fromARGB(255, 243, 105, 137), Color.fromARGB(255, 211, 39, 79), Color.fromARGB(255, 252, 19, 74), Color.fromARGB(255, 255, 157, 180)],  // Different colors of confetti
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: ConfettiWidget(
                          confettiController: _confettiController,
                          blastDirection: 0,
                          shouldLoop: false,
                          colors: const [Color.fromARGB(255, 243, 105, 137), Color.fromARGB(255, 211, 39, 79), Color.fromARGB(255, 252, 19, 74), Color.fromARGB(255, 255, 157, 180)],  // Different colors of confetti
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ConfettiWidget(
                          confettiController: _confettiController,
                          blastDirection: 0,
                          shouldLoop: false,
                          colors: const [Color.fromARGB(255, 243, 105, 137), Color.fromARGB(255, 211, 39, 79), Color.fromARGB(255, 252, 19, 74), Color.fromARGB(255, 255, 157, 180)],  // Different colors of confetti
                        ),
                      ),
                    ]
                  ),
                )
              );

            },
          ),
        ),
      ),
    );
  }
}
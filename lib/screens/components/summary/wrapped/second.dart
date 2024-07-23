import 'package:flutter/material.dart';
import 'package:kissdate/root.dart';
import 'package:confetti/confetti.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late ConfettiController _confettiController;
  final ValueNotifier<int?> peopleCountThisYear = ValueNotifier<int?>(null);

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
          'third.dart',
        );
      },
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _opacityAnimation,
                builder: (context, child) {
                  return Opacity(
                    opacity: _opacityAnimation.value,
                    child: FutureBuilder<int>(
                      future: peopleController.countYear(
                          userId, DateTime.now().year),
                      builder:
                          (BuildContext context, AsyncSnapshot<int> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            peopleCountThisYear.value = snapshot.data;
                            return Column(
                              children: [
                                Text(
                                  'Has estado con ${snapshot.data} personas',
                                  style: const TextStyle(fontSize: 24),
                                ),
                                // Confetti widget
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: ConfettiWidget(
                                    confettiController: _confettiController,
                                    blastDirection: 0,
                                    shouldLoop: false,
                                    colors: const [Color.fromARGB(255, 243, 105, 137), Color.fromARGB(255, 211, 39, 79), Color.fromARGB(255, 252, 19, 74), Color.fromARGB(255, 255, 157, 180)],  // Different colors of confetti
                                  ),
                                ),
                              ]
                            );
                          }
                        }
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              AnimatedBuilder(
                animation: _opacityAnimation,
                builder: (context, child) {
                  return Opacity(
                    opacity:
                        _opacityAnimation.status == AnimationStatus.completed
                            ? 1.0
                            : 0.0,
                    child: FutureBuilder<int>(
                      future: peopleController.countYear(
                          userId, DateTime.now().year - 1),
                      builder: (BuildContext context,
                          AsyncSnapshot<int> snapshotLastYear) {
                        if (snapshotLastYear.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator(color: Colors.white);
                        } else {
                          if (snapshotLastYear.hasError) {
                            return Text('Error: ${snapshotLastYear.error}');
                          } else {
                            int difference = peopleCountThisYear.value! -
                                (snapshotLastYear.data ?? 0);

                            String flecha = '';

                            if (difference < 0) {
                              flecha = '↓';
                              difference = difference.abs();
                            }
                            else {
                              flecha = '↑';
                            }

                            return Text(
                              '$difference $flecha',
                              style: const TextStyle(fontSize: 24),
                            );
                          }
                        }
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

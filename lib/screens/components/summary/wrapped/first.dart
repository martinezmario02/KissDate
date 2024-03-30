import 'package:flutter/material.dart';

class Wrapped extends StatefulWidget {
  const Wrapped({super.key});

  @override
  State<Wrapped> createState() => _WrappedState();
}

class _WrappedState extends State<Wrapped> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

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
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            'second.dart');
        },
        child: AnimatedBuilder(
          animation: _opacityAnimation,
          builder: (context, child) {
            return Opacity(
              opacity: _opacityAnimation.value,
              child: const Center(
                child: Text(
                  'Este año...',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
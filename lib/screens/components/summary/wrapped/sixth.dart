import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:kissdate/root.dart';
import 'dart:async';

class SixthPage extends StatefulWidget {
  const SixthPage({super.key});

  @override
  State<SixthPage> createState() => _SixthPageState();
}

class _SixthPageState extends State<SixthPage>
    with SingleTickerProviderStateMixin {
  late Animation<double> _opacityAnimation;
  late AnimationController _controller;

  late Future<Map<String, double?>> _statsFuture;

  @override
  void initState() {
    super.initState();
    _statsFuture = wrappedController.genderStatistics(userId);

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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          'seventh.dart',
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
                    child: FutureBuilder<Map<String, double?>>(
                      future: _statsFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else {
                          var stats = snapshot.data!;

                          return Padding(
                            padding: const EdgeInsets.all(30.0),
                            child:  Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  '¿CUÁL ERA EL GÉNERO?',
                                  style: TextStyle(fontSize: 35, fontFamily: 'Header', color: Color.fromARGB(255, 252, 66, 128)),
                                ),
                                const SizedBox(height: 16),
                                SizedBox(
                                  height: 500, 
                                  child:AspectRatio(
                                    aspectRatio: 1,
                                    child: PieChart(
                                      PieChartData(
                                        sections: [
                                          PieChartSectionData(
                                            color: const Color.fromARGB(255, 177, 220, 255),
                                            value: stats['hombres'],
                                            title: 'Hombres (${stats['hombres']!.toInt()})',
                                            radius: 100,
                                          ),
                                          PieChartSectionData(
                                            color: const Color.fromARGB(255, 249, 182, 204),
                                            value: stats['mujeres'],
                                            title: 'Mujeres (${stats['mujeres']!.toInt()})',
                                            radius: 100,
                                          ),
                                          PieChartSectionData(
                                            color: const Color.fromARGB(255, 192, 104, 255),
                                            value: stats['noBinario'],
                                            title: 'No binario (${stats['noBinario']!.toInt()})',
                                            radius: 100,
                                          ),
                                        ],
                                        sectionsSpace: 0,
                                        centerSpaceRadius: 40,
                                      ),
                                    ),
                                  )
                                ),
                              ]
                            ),
                          );
                        }
                      },
                    ),
                  );
                },
              ),
            ]
          )
        ),
      ),
    );
  }
}

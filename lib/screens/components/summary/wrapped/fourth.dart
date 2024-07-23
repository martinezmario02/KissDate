import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:kissdate/root.dart';
import 'dart:async';
import 'dart:math';

class FourthPage extends StatefulWidget {
  const FourthPage({super.key});

  @override
  State<FourthPage> createState() => _FourthPageState();
}

class _FourthPageState extends State<FourthPage>
    with SingleTickerProviderStateMixin {
  late Animation<double> _opacityAnimation;
  late AnimationController _controller;

  late Future<Map<String, int?>> _statsFuture;

  @override
  void initState() {
    super.initState();
    _statsFuture = wrappedController.nationalityStatistics(userId);

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
          'fifth.dart',
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
                    child: FutureBuilder<Map<String, int?>>(
                      future: _statsFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else {
                          var stats = snapshot.data!;
                          var sections = <PieChartSectionData>[];

                          List<Color> pastelColors = [
                            const Color(0xFFFFC3E1), 
                            const Color(0xFFD4C2FC),
                            const Color(0xFFC3B2D7), 
                            const Color(0xFFC9A3E5), 
                            const Color(0xFFDFC2F4), 
                            const Color(0xFFFFD1DC), 
                            const Color.fromARGB(255, 253, 160, 207),
                            const Color.fromARGB(255, 216, 164, 190), 
                            const Color.fromARGB(255, 255, 137, 196), 
                            const Color.fromARGB(255, 224, 109, 167),
                            const Color.fromARGB(255, 192, 104, 255),
                            const Color.fromARGB(255, 140, 88, 177),
                          ];

                          stats.forEach((nationality, count) {
                            var randomPastelColor = pastelColors[Random().nextInt(pastelColors.length)];
                            sections.add(
                              PieChartSectionData(
                                color: randomPastelColor,
                                value: double.parse(count.toString()),
                                title: '$nationality (${count!.toInt()})',
                                radius: 100,
                              ),
                            );
                          });

                          return Padding(
                            padding: const EdgeInsets.all(30.0),
                            child:  Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Nacionalidades',
                                  style: TextStyle(fontSize: 35, fontFamily: 'Header', color: Color.fromARGB(255, 252, 66, 128)),
                                ),
                                const SizedBox(height: 16),
                                SizedBox(
                                  height: 500, 
                                  child:AspectRatio(
                                    aspectRatio: 1,
                                    child: PieChart(
                                      PieChartData(
                                        sections: sections,
                                        sectionsSpace: 0,
                                        centerSpaceRadius: 40,
                                      ),
                                    ),
                                  ),
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

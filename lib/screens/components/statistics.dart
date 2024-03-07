// RESUMEN / ESTADÍSTICAS

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:kissdate/root.dart';

class Summary extends StatefulWidget {
  const Summary({super.key, required this.titulo});

  final String titulo;

  @override
  State<Summary> createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  late Future<Map<String, double?>> _statsFuture;

  @override
  void initState() {
    super.initState();
    _statsFuture = peopleController.genderStatistics(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.titulo),
      ),
      body: FutureBuilder<Map<String, double?>>(
        future: _statsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            var stats = snapshot.data!;
            return AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      color: const Color.fromARGB(255, 177, 220, 255),
                      value: stats['hombres'],
                      title: 'Hombres (${stats['hombres']!.toInt()})' ,
                      radius: 100,
                    ),
                    PieChartSectionData(
                      color: const Color.fromARGB(255, 249, 182, 204),
                      value: stats['mujeres'],
                      title: 'Mujeres (${stats['mujeres']!.toInt()})',
                      radius: 100,
                    ),
                    PieChartSectionData(
                      color: const Color.fromARGB(255, 159, 224, 161),
                      value: stats['noBinario'],
                      title: 'No binario (${stats['noBinario']!.toInt()})',
                      radius: 100,
                    ),
                  ],
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

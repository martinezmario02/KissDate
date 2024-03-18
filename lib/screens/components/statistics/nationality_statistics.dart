import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:kissdate/root.dart';
import 'dart:async';
import 'dart:math';

/// Widget to show the summary of the list.
class NationalitySummary extends StatefulWidget {
  const NationalitySummary({super.key, required this.titulo});

  /// Title of the widget.
  final String titulo;

  @override
  State<NationalitySummary> createState() => _NationalitySummaryState();
}

/// State of the widget [Summary].
class _NationalitySummaryState extends State<NationalitySummary> {
  late Future<Map<String, int?>> _statsFuture;

  @override
  void initState() {
    super.initState();
    _statsFuture = statsController.nationalityStatistics(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.titulo),
      ),
      body: FutureBuilder<Map<String, int?>>(
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
              const Color(0xFFFFC3E1), // Rosa pastel
              const Color(0xFFFFDEB4), // Amarillo pastel
              const Color(0xFFC9FFE5), // Verde pastel
              const Color(0xFFD4A5A5), // Marrón pastel
              const Color(0xFFD0ECE7), // Azul pastel
              const Color(0xFFF9CBBC), // Melocotón pastel
              const Color(0xFFD4C2FC), // Morado pastel
              const Color(0xFFB5EAD7), // Verde menta pastel
              const Color(0xFFC3B2D7), // Lila pastel
              const Color(0xFFC4F5FC), // Azul claro pastel
              const Color(0xFFFFE0B2), // Naranja pastel
              const Color(0xFFB2F7EF), // Cian pastel
              const Color(0xFFE2FDB0), // Lima pastel
              const Color(0xFFC9A3E5), // Lavanda pastel
              const Color(0xFFDFC2F4), // Rosado pastel
              const Color(0xFFFFD1DC), // Salmón pastel
              const Color(0xFFB3E6FF), // Celeste pastel
              const Color(0xFFFFD3A5), // Beige pastel
              const Color(0xFFF1FFC4), // Amarillo claro pastel
              const Color(0xFFC4C4F3), // Azul violeta pastel
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

            return AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  sections: sections,
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
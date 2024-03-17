import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:kissdate/root.dart';

/// Widget to show the summary of the list.
class YearSummary extends StatefulWidget {
  const YearSummary({super.key, required this.titulo});

  /// Title of the widget.
  final String titulo;

  @override
  State<YearSummary> createState() => _YearSummaryState();
}

/// State of the widget [YearSummary].
class _YearSummaryState extends State<YearSummary> {
  late Future<Map<String, double?>> _statsFuture;

  @override
  void initState() {
    super.initState();
    _statsFuture = statsController.yearStatistics(userId);
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
            var sections = <PieChartSectionData>[];

            stats.forEach((year, count) {
              if (count != null && count > 0) {
                sections.add(PieChartSectionData(
                  color: Colors
                      .primaries[sections.length % Colors.primaries.length],
                  value: count,
                  title: '$year (${count.toInt()})',
                  radius: 100,
                ));
              }
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

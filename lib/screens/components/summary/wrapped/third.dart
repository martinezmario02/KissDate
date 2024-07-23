import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:kissdate/root.dart';

class ThirdPage extends StatefulWidget {
  const ThirdPage({super.key});

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class SalesData {
  final String category;
  final int amount;

  SalesData(this.category, this.amount);
}

class _ThirdPageState extends State<ThirdPage>
    with SingleTickerProviderStateMixin {
  late Animation<double> _opacityAnimation;
  late AnimationController _controller;

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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          'fourth.dart',
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
                      future: wrappedController.monthsStatistics(userId),
                      builder:
                          (BuildContext context, AsyncSnapshot<Map<String, double?>> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return Padding(
                              padding: const EdgeInsets.all(30.0),
                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    '¿Cómo fue cada mes?',
                                    style: TextStyle(fontSize: 35, fontFamily: 'Header', color: Color.fromARGB(255, 252, 66, 128)),
                                  ),
                                  const SizedBox(height: 16),
                                  SizedBox(
                                    height: 400, 
                                    child: charts.BarChart(
                                      _createSampleData(snapshot.data),
                                      animate: true,
                                      vertical: false,
                                    ),
                                  ),
                                ]
                              )
                            );
                          }
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

  static List<charts.Series<SalesData, String>> _createSampleData(Map<String, double?>? months) {
    final List<String> monthNames = ['ENE', 'FEB', 'MAR', 'ABR', 'MAY', 'JUN', 'JUL', 'AGO', 'SEP', 'OCT', 'NOV', 'DIC'];

    final data = months!.entries.map((entry) {
      int monthIndex = int.parse(entry.key.split('.')[0]) - 1;
      return SalesData(monthNames[monthIndex], entry.value!.toInt());
    }).toList();

    return [
      charts.Series<SalesData, String>(
        id: 'Sales',
        domainFn: (SalesData sales, _) => sales.category,
        measureFn: (SalesData sales, _) => sales.amount,
        data: data,
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(const Color.fromARGB(255, 255, 151, 186)),
      )
    ];
  }
}

import 'package:flutter/material.dart';

/// Widget to show the main menu.
class SummaryMenu extends StatefulWidget {
  const SummaryMenu({super.key, required this.titulo});

  /// Title of the widget.
  final String titulo;

  @override
  State<SummaryMenu> createState() => _SummaryMenuState();
}

/// State of the widget [SummaryMenu].
class _SummaryMenuState extends State<SummaryMenu> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.titulo),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 100,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/lib/screens/gender_resume.dart');
                  },
                  child: Text('Género', style: TextStyle(fontSize: screenWidth * 0.05)),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 100,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/lib/screens/age_resume.dart');
                  },
                  child: Text('Edad', style: TextStyle(fontSize: screenWidth * 0.05)),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 100,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                child: ElevatedButton(
                  onPressed: () {
                    //Navigator.pushNamed(context, '/lib/screens/resume.dart');
                  },
                  child: Text('Nacionalidad', style: TextStyle(fontSize: screenWidth * 0.05)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

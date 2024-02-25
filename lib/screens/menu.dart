import 'package:flutter/material.dart';

// Pantalla de inicio --> Menu principal

class MainMenu extends StatefulWidget {
  const MainMenu({super.key, required this.titulo});

  final String titulo;

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.titulo),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/lib/screens/people/add.dart');
              },
              child: const Text('Añadir a la lista'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/lib/screens/people/list.dart');
              },
              child: const Text('Lista'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/lib/screens/resume.dart');
              },
              child: const Text('Resumen / Estadísticas'),
            ),
          ],
        ),
      ),
    );
  }
}
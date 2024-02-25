import 'package:flutter/material.dart';
import 'screens/menu.dart';
import 'screens/people/add.dart';
import 'screens/people/list.dart';
import 'screens/resume.dart';

void main() {
  runApp(const KissDate());
}

class KissDate extends StatelessWidget {
  const KissDate({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kiss Date',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 243, 105, 137)),
        useMaterial3: true,
      ),
      home: const MainMenu(titulo: 'Kiss Date'),
      routes: {
        '/lib/screens/people/add.dart': (context) => const AddPerson(titulo: 'Añadir a la lista'),
        '/lib/screens/people/list.dart': (context) => const ListPeople(titulo: 'Lista'),
        '/lib/screens/resume.dart': (context) => const Summary(titulo: 'Resumen / Estadísticas'),
      }
    );
  }
}
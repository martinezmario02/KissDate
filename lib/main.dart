import 'package:flutter/material.dart';
import 'screens/menu.dart';
import 'screens/components/add.dart';
import 'screens/components/list.dart';
import 'screens/components/statistics.dart';
import 'screens/users/login.dart';

void main() {
  runApp(const KissDate());
}

class KissDate extends StatelessWidget {
  const KissDate({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Kiss Date',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 243, 105, 137)),
          useMaterial3: true,
        ),
        home: const Login(titulo: 'Kiss Date'),
        routes: {
          '/lib/screens/menu.dart': (context) =>
              const MainMenu(titulo: 'Kiss Date'),
          '/lib/screens/people/add.dart': (context) =>
              const AddPerson(titulo: 'Añadir a la lista'),
          '/lib/screens/people/list.dart': (context) =>
              const ListPeople(titulo: 'Lista'),
          '/lib/screens/resume.dart': (context) =>
              const Summary(titulo: 'Resumen / Estadísticas'),
        });
  }
}
import 'package:flutter/material.dart';
import 'package:kissdate/root.dart';
import 'screens/menu.dart';
import 'screens/components/add.dart';
import 'screens/components/list/list.dart';
import 'screens/components/statistics/gender_statistics.dart';
import 'screens/components/statistics/statistics_menu.dart';
import 'screens/components/statistics/age_statistics.dart';
import 'screens/authentication/login.dart';
import 'screens/authentication/register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  isLogged = await isLoggedStatus();
  runApp(KissDate(isLogged: isLogged));
}

class KissDate extends StatelessWidget {
  final bool isLogged;

  const KissDate({super.key, required this.isLogged});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Kiss Date',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 243, 105, 137)),
          useMaterial3: true,
        ),
        home: isLogged
            ? const MainMenu(titulo: 'Kiss Date')
            : const Login(titulo: 'Iniciar sesión'),
        routes: {
          '/lib/screens/main.dart': (context) =>
              const KissDate(isLogged: false),
          '/lib/screens/menu.dart': (context) =>
              const MainMenu(titulo: 'Kiss Date'),
          '/lib/screens/users/login.dart': (context) =>
              const Login(titulo: 'Iniciar sesión'),
          '/lib/screens/users/register.dart': (context) =>
              const Register(titulo: 'Registrarse'),
          '/lib/screens/people/add.dart': (context) =>
              const AddPerson(titulo: 'Añadir persona'),
          '/lib/screens/people/list.dart': (context) =>
              const ListPeople(titulo: 'Lista'),
          '/lib/screens/resume.dart': (context) =>
              const SummaryMenu(titulo: 'Resumen / Estadísticas'),
          '/lib/screens/gender_resume.dart': (context) =>
              const GenderSummary(titulo: 'Estadísticas por género'),
          '/lib/screens/age_resume.dart': (context) =>
              const AgeSummary(titulo: 'Estadísticas por edad'),
        });
  }
}

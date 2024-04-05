import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:kissdate/root.dart';
import 'package:kissdate/screens/menu.dart';
import 'package:kissdate/screens/components/add.dart';
import 'package:kissdate/screens/components/list/list.dart';
import 'package:kissdate/screens/components/list/profile.dart';
import 'package:kissdate/screens/components/summary/statistics/gender_statistics.dart';
import 'package:kissdate/screens/components/summary/statistics/age_statistics.dart';
import 'package:kissdate/screens/components/summary/statistics/nationality_statistics.dart';
import 'package:kissdate/screens/components/summary/statistics/year_statistics.dart';
import 'package:kissdate/screens/components/summary/wrapped/first.dart';
import 'package:kissdate/screens/components/summary/wrapped/second.dart';
import 'package:kissdate/screens/components/summary/wrapped/third.dart';
import 'package:kissdate/screens/components/summary/menu_summary.dart';
import 'package:kissdate/screens/authentication/login.dart';
import 'package:kissdate/screens/authentication/register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  isLogged = await isLoggedStatus();
  Logger.level = Level.info;
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
          'main.dart': (context) => const KissDate(isLogged: false),
          'menu.dart': (context) => const MainMenu(titulo: 'Kiss Date'),
          'login.dart': (context) => const Login(titulo: 'Inicio de sesión'),
          'register.dart': (context) => const Register(titulo: 'Registro'),
          'add.dart': (context) => const AddPerson(titulo: 'Añadir persona'),
          'list.dart': (context) => const ListPeople(titulo: 'Lista'),
          'profile.dart': (context) => const Profile(),
          'statistics_menu.dart': (context) =>
              const SummaryMenu(titulo: 'Resumen / Estadísticas'),
          'gender_statistics.dart': (context) =>
              const GenderSummary(titulo: 'Estadísticas por género'),
          'age_statistics.dart': (context) =>
              const AgeSummary(titulo: 'Estadísticas por edad'),
          'nationality_statistics.dart': (context) =>
              const NationalitySummary(titulo: 'Estadísticas por nacionalidad'),
          'year_statistics.dart': (context) =>
              const YearSummary(titulo: 'Estadísticas por año'),
          'wrapped.dart': (context) => const Wrapped(),
          'second.dart': (context) => const SecondPage(),
          'third.dart': (context) => const ThirdPage(),
        });
  }
}

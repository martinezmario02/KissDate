import 'package:flutter/material.dart';
import 'screens/menu.dart';
import 'screens/components/add.dart';
import 'screens/components/list.dart';
import 'screens/components/statistics.dart';
import 'screens/users/login.dart';
import 'screens/users/register.dart';


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
        home: const StartMenu(),
        routes: {
          '/lib/screens/menu.dart': (context) =>
              const MainMenu(titulo: 'Kiss Date'),
          '/lib/screens/users/login.dart': (context) =>
              const Login(titulo: 'Iniciar sesión'),
          '/lib/screens/users/register.dart': (context) =>
              const Register(titulo: 'Registrarse'),
          '/lib/screens/people/add.dart': (context) =>
              const AddPerson(titulo: 'Añadir a la lista'),
          '/lib/screens/people/list.dart': (context) =>
              const ListPeople(titulo: 'Lista'),
          '/lib/screens/resume.dart': (context) =>
              const Summary(titulo: 'Resumen / Estadísticas'),
        });
  }
}

// Tres botones: Iniciar sesión, Registrarse, Invitado
class StartMenu extends StatefulWidget {
  const StartMenu({super.key});

  @override
  State<StartMenu> createState() => _StartMenuState();
}

class _StartMenuState extends State<StartMenu> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Kiss Date'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 100,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/lib/screens/users/login.dart');
                  },
                  child: Row(
                    children: [
                      const SizedBox(width: 15),
                      const SizedBox(width: 15),
                      Text('Iniciar sesión',
                          style: TextStyle(fontSize: screenWidth * 0.05)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 100,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/lib/screens/users/register.dart');
                  },
                  child: Row(
                    children: [
                      const SizedBox(width: 15),
                      const SizedBox(width: 15),
                      Text('Registrarse',
                          style: TextStyle(fontSize: screenWidth * 0.05)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 100,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/lib/screens/menu.dart');
                  },
                  child: Row(
                    children: [
                      const SizedBox(width: 15),
                      const SizedBox(width: 15),
                      Text('Invitado',
                          style: TextStyle(fontSize: screenWidth * 0.05)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
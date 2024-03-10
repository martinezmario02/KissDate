import 'package:flutter/material.dart';

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
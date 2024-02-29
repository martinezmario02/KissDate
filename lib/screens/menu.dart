// MENU PRINCIPAL

import 'package:flutter/material.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key, required this.titulo});

  final String titulo;

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
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
              SizedBox(
                height: 100,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/lib/screens/people/add.dart');
                  },
                  // child: const Text('Añadir a la lista'),
                  child: Row(
                    children: [
                      const SizedBox(width: 15),
                      Image.asset('assets/icons/newPerson.png', width: screenWidth*0.16, height: screenWidth*0.16),
                      const SizedBox(width: 15),
                      Text('Añadir a la lista', style: TextStyle(fontSize: screenWidth*0.05)),
                    ],
                  )
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 100,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/lib/screens/people/list.dart');
                  },
                  // child: const Text('Añadir a la lista'),
                  child: Row(
                    children: [
                      const SizedBox(width: 15),
                      Image.asset('assets/icons/list.png', width: screenWidth*0.18, height: screenWidth*0.18),
                      const SizedBox(width: 8),
                      Text('Listado de personas', style: TextStyle(fontSize: screenWidth*0.05)),
                    ],
                  )
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 100,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/lib/screens/resume.dart');
                  },
                  // child: const Text('Añadir a la lista'),
                  child: Row(
                    children: [
                      const SizedBox(width: 15),
                      Image.asset('assets/icons/statistics.png', width: screenWidth*0.16, height: screenWidth*0.16),
                      const SizedBox(width: 15),
                      Text('Estadísticas', style: TextStyle(fontSize: screenWidth*0.05)),
                    ],
                  )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
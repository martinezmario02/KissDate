import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kissdate/root.dart';

/// Widget to show the main menu.
class MainMenu extends StatefulWidget {
  const MainMenu({super.key, required this.titulo});

  /// Title of the widget.
  final String titulo;

  @override
  State<MainMenu> createState() => _MainMenuState();
}

/// State of the widget [MainMenu].
class _MainMenuState extends State<MainMenu> {
  @override
  void initState() {
    super.initState();
    checkIfLoggedIn();
  }

  Future<void> checkIfLoggedIn() async {
    try {
      bool loggedIn = await isLoggedStatus();
      if (loggedIn) {
        int? id = await getUserId();
        if (id != null) {
          setState(() {
            isLogged = true;
            userId = id;
          });
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.titulo),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              if (value == 'cerrar_sesion') {
                checkLoggedStatus(false);
                isLogged = false;
                userId = -1;
                if (Navigator.canPop(context)) {
                  Navigator.pop(context, '/lib/screens/main.dart');
                } else {
                  Navigator.pushNamed(context, '/lib/screens/main.dart');
                }
              } else if (value == 'ajustes') {
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: 'ajustes',
                  child: ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Ajustes'),
                  ),
                ),
                const PopupMenuItem(
                  value: 'cerrar_sesion',
                  child: ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text('Cerrar sesión'),
                  ),
                )
              ];
            },
          )
        ],
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
                    Navigator.pushNamed(
                        context, '/lib/screens/people/add.dart');
                  },
                  child: Row(
                    children: [
                      const SizedBox(width: 15),
                      Image.asset('assets/icons/newPerson.png',
                          width: screenWidth * 0.16,
                          height: screenWidth * 0.16),
                      const SizedBox(width: 15),
                      Text('Añadir persona',
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
                    Navigator.pushNamed(
                        context, '/lib/screens/people/list.dart');
                  },
                  child: Row(
                    children: [
                      const SizedBox(width: 15),
                      Image.asset('assets/icons/list.png',
                          width: screenWidth * 0.18,
                          height: screenWidth * 0.18),
                      const SizedBox(width: 8),
                      Text('Listado de personas',
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
                    Navigator.pushNamed(context, '/lib/screens/resume.dart');
                  },
                  child: Row(
                    children: [
                      const SizedBox(width: 15),
                      Image.asset('assets/icons/statistics.png',
                          width: screenWidth * 0.16,
                          height: screenWidth * 0.16),
                      const SizedBox(width: 15),
                      Text('Estadísticas',
                          style: TextStyle(fontSize: screenWidth * 0.05)),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'screens/menu.dart';
import 'screens/components/add.dart';
import 'screens/components/list.dart';
import 'screens/components/statistics.dart';
import 'screens/register.dart';
import 'root.dart';

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

// Inicio de sesión
class Login extends StatefulWidget {
  const Login({super.key, required this.titulo});

  final String titulo;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> login() async {
    var resultado = await userController.login(
      _emailController.text,
      _passwordController.text,
    );
    if (resultado == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Usuario o contraseña incorrectos'),
        ),
      );
    } else {
      userId = resultado;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MainMenu(titulo: 'Kiss Date'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Inicio de sesión'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Correo'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce tu correo';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Contraseña'),
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce tu contraseña';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      login();
                    }
                  },
                  child: const Text('Iniciar sesión'),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Register(titulo: 'Registro'),
                    ),
                  );
                },
                child: const Text('¿No estás registrado? Regístrate aquí'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

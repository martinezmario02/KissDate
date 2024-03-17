import 'package:flutter/material.dart';
import 'package:kissdate/root.dart';
import 'package:kissdate/screens/menu.dart';

/// The login screen widget.
///
/// This widget allows users to log in to the Kiss Date app.
class Login extends StatefulWidget {
  /// The title of the login screen.
  final String titulo;

  /// Creates a [Login] widget.
  const Login({super.key, required this.titulo});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  /// Performs the login process.
  ///
  /// This method is called when the login button is pressed.
  /// It validates the user's input, performs the login operation, and
  /// navigates to the main menu screen if the login is successful.
  Future<void> login() async {
    var resultado = await userController.login(
      _emailController.text,
      _passwordController.text,
    );
    if (resultado == -1) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Usuario o contraseña incorrectos'),
        ),
      );
    } else {
      userId = resultado;
      checkLoggedStatus(true);
      isLogged = true;
      saveUserId(userId);
      Navigator.push(
        // ignore: use_build_context_synchronously
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
                  Navigator.pushNamed(context, 'register.dart');
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
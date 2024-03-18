import 'package:flutter/material.dart';
import 'package:kissdate/root.dart';

/// Widget to register a user.
class Register extends StatefulWidget {
  const Register({super.key, required this.titulo});

  /// Title of the widget.
  final String titulo;

  @override
  State<Register> createState() => _RegisterState();
}

/// State of the widget [Register].
class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _nameController = TextEditingController();
  final _birthdayController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _emailController = TextEditingController();

  DateTime date = DateTime.now();

  @override
  void dispose() {
    _userNameController.dispose();
    _nameController.dispose();
    _birthdayController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _emailController.dispose();

    super.dispose();
  }

  /// Registers a new user.
  Future<void> register() async {
    DateTime? birthday = _birthdayController.text.isNotEmpty
        ? DateTime.parse(_birthdayController.text)
        : null;
    String? email =
        _emailController.text.isNotEmpty ? _emailController.text : null;

    userController.addUser(_userNameController.text, _nameController.text,
        birthday, _passwordController.text, email);
  }

  /// Shows a date picker to select the user's birthday.
  Future<void> selectDate(BuildContext context) async {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme.copyWith(
        primary: const Color.fromARGB(255, 243, 105, 137),
        onPrimary: Colors.white);

    final DateTime? fechaSeleccionada = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(1950),
        lastDate: DateTime(2050),
        // Para cambiar el color del calendario:
        builder: (BuildContext context, Widget? child) {
          return Theme(
              data: ThemeData.light().copyWith(
                colorScheme: colorScheme,
              ),
              child: child!);
        });

    if (fechaSeleccionada != null && fechaSeleccionada != date) {
      setState(() {
        date = fechaSeleccionada;
        _birthdayController.text =
            '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.titulo),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _userNameController,
                decoration:
                    const InputDecoration(labelText: 'Nombre de usuario'),
                validator: validateUserName,
              ),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce tu nombre';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration:
                    const InputDecoration(labelText: 'Correo electrónico'),
                validator: validateEmail,
              ),
              TextFormField(
                controller: _birthdayController,
                onTap: () => selectDate(context),
                decoration:
                    const InputDecoration(labelText: 'Fecha de nacimiento'),
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Contraseña'),
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                validator: validatePassword,
              ),
              TextFormField(
                controller: _confirmPasswordController,
                decoration:
                    const InputDecoration(labelText: 'Confirmar Contraseña'),
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, confirma tu contraseña';
                  }
                  if (value != _passwordController.text) {
                    return 'Las contraseñas no coinciden';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      try {
                        register();
                        checkLoggedStatus(true);
                        isLogged = true;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Registro completado con éxito')),
                        );
                        logger.i(
                            'Nuevo usuario registrado: ${_userNameController.text}');
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Error al registrarse')));
                        logger.e(e);
                      }
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Registrarse'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Validate the email format.
  String? validateEmail(String? value) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (value != null && value.isNotEmpty && !emailRegex.hasMatch(value)) {
      return 'Por favor, introduce un correo electrónico válido';
    }

    return null;
  }

  /// Validate the password format.
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, introduce tu contraseña';
    }

    final passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');

    if (!passwordRegex.hasMatch(value)) {
      return 'Debe contener al menos una letra y un número (8 caracteres mínimo)';
    }

    return null;
  }
}

/// Validate the userName (it must be unique).
String? validateUserName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Por favor, introduce tu nombre de usuario';
  }

  return null;
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kissdate/screens/authentication/login.dart';
import 'package:kissdate/screens/authentication/register.dart';

void main() {
  testWidgets('Login screen validation test', (WidgetTester tester) async {
    // Build our widget and trigger a frame
    await tester.pumpWidget(
      const MaterialApp(
        home: Login(titulo: 'Inicio de sesión'), // Crea una instancia de Login
      ),
    );

    // Verify that the login screen has a title
    expect(find.text('Inicio de sesión'), findsOneWidget);

    // Tap the login button without entering any values
    await tester.tap(find.text('Iniciar sesión'));

    // Wait for the animation to finish
    await tester.pumpAndSettle();

    // Verify that the snackbar is displayed with the validation error message
    expect(find.text('Por favor, introduce tu correo'), findsOneWidget);
    expect(find.text('Por favor, introduce tu contraseña'), findsOneWidget);
  });

  testWidgets('Login screen navigation test', (WidgetTester tester) async {
    final routes = <String, WidgetBuilder>{
      'register.dart': (context) => const Register(titulo: 'Registro'),
    };

    // Build our widget and trigger a frame
    await tester.pumpWidget(
      MaterialApp(
        home: const Login(titulo: 'Inicio de sesión'),
        routes: routes,
      ),
    );

    // Verify that the login screen has a title
    expect(find.text('Inicio de sesión'), findsOneWidget);

    // Tap the register button
    await tester.tap(find.text('¿No estás registrado? Regístrate aquí'));

    // Wait for the animation to finish
    await tester.pumpAndSettle();

    // Verify that the register screen is pushed onto the navigator stack
    expect(find.text('Registrarse'), findsOneWidget);
  });
}
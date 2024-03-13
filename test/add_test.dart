import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kissdate/screens/components/add.dart';

void main() {
  testWidgets('AddPerson image selection test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: AddPerson(
            titulo: 'Añadir persona'), // Create an instance of AddPerson
      ),
    );

    // Verify that the AddPerson screen has a title
    expect(find.text('Añadir persona'), findsOneWidget);

    // Tap the select image button
    await tester.tap(find.text('Seleccionar Imagen'));

    // Wait for the image selection to finish
    await tester.pumpAndSettle();

    // Verify that the image is displayed
    expect(find.byType(Image), findsOneWidget);
  });
}

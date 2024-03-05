// AÑADIR UNA PERSONA A LA LISTA

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kissdate/root.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

// Nacionalidad
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';

class AddPerson extends StatefulWidget {
  const AddPerson({super.key, required this.titulo});

  final String titulo;

  @override
  State<AddPerson> createState() => _AddPersonState();
}

// Formulario para incluir datos sobre una persona
class _AddPersonState extends State<AddPerson> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _nationalityController = TextEditingController();

  final _relationshipController = TextEditingController();
  final _kissDateController = TextEditingController();

  final _observationsController = TextEditingController();

  DateTime date = DateTime.now();
  File? _image;

  Future<void> _selectImageFromGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _nationalityController.dispose();

    _relationshipController.dispose();
    _kissDateController.dispose();
    _observationsController.dispose();

    super.dispose();
  }

  Future<void> addToList() async {
    peopleController.addToList(
      userId,
      _nameController.text,
      int.parse(_ageController.text),
      _nationalityController.text,
      _relationshipController.text,
      DateTime.parse(_kissDateController.text),
      _observationsController.text,
    );
  }

  // Calendario para seleccionar la fecha del beso
  Future<void> selectDate(BuildContext context) async {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme.copyWith(
        primary: const Color.fromARGB(255, 243, 105, 137),
        onPrimary: Colors.white); // color para el calendario

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
        _kissDateController.text =
            '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.titulo),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Nombre'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, introduce un nombre';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _ageController,
                    keyboardType: TextInputType.number, // Teclado numérico
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly
                    ], // Solo números
                    decoration: const InputDecoration(labelText: 'Edad'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, introduce una edad';
                      }
                      final age = int.tryParse(value);
                      if (age == null || age <= 0) {
                        return 'La edad debe ser un número entero positivo';
                      }
                      return null;
                    },
                  ),
                  InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'Nacionalidad',
                    ),
                    child: CountryPickerDropdown(
                      initialValue: 'ES',
                      itemBuilder: (Country country) {
                        return Row(
                          children: <Widget>[
                            CountryPickerUtils.getDefaultFlagImage(country),
                            const SizedBox(width: 8),
                            Text(country.name),
                          ],
                        );
                      },
                      onValuePicked: (Country country) {
                        _nationalityController.text = country.name;
                      },
                    ),
                  ),
                  TextFormField(
                    controller: _relationshipController,
                    decoration: const InputDecoration(labelText: 'Relación'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, introduce una relación';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _kissDateController,
                    onTap: () => selectDate(context),
                    decoration:
                        const InputDecoration(labelText: 'Fecha del beso'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, introduce una fecha';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _observationsController,
                    decoration:
                        const InputDecoration(labelText: 'Observaciones'),
                  ),
                  _image != null
                      ? Image.file(
                          _image!,
                          width: 200,
                          height: 200,
                        )
                      : Container(),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _selectImageFromGallery,
                    child: const Text('Seleccionar Imagen'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          addToList();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Persona añadida a la lista')),
                          );
                          Navigator.pushNamed(
                              context, '/lib/screens/people/list.dart');
                        }
                      },
                      child: const Text('Añadir a la lista'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

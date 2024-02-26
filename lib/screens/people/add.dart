import 'package:flutter/material.dart';
import 'package:kissdate/screens/people/list.dart';

// Añadir una nueva persona a la lista

class AddPerson extends StatefulWidget {
  const AddPerson({Key? key, required this.titulo}) : super(key: key);

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
    userController.addToList(
      _nameController.text,
      int.parse(_ageController.text),
      _nationalityController.text,

      _relationshipController.text,
      DateTime.parse(_kissDateController.text),
      _observationsController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                decoration: const InputDecoration(labelText: 'Edad'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce una edad';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _nationalityController,
                decoration: const InputDecoration(labelText: 'Nacionalidad'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce una nacionalidad';
                  }
                  return null;
                },
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
                decoration: const InputDecoration(labelText: 'Fecha del beso'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce una fecha';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _observationsController,
                decoration: const InputDecoration(labelText: 'Observaciones'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Procesando datos')),
                      );
                      addToList();
                    }
                  },
                  child: const Text('Añadir a la lista'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

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
  final _nombreController = TextEditingController();
  final _fechaController = TextEditingController();
  final _relacionController = TextEditingController();
  final _observacionesController = TextEditingController();

  @override
  void dispose() {
    _nombreController.dispose();
    _fechaController.dispose();
    _relacionController.dispose();
    _observacionesController.dispose();
    super.dispose();
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
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce un nombre';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _fechaController,
                decoration: const InputDecoration(labelText: 'Fecha'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce una fecha';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _relacionController,
                decoration: const InputDecoration(labelText: 'Relación'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce una relación';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _observacionesController,
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
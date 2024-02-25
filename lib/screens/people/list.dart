import 'package:flutter/material.dart';

// Mostrar lista de personas
class ListPeople extends StatefulWidget {
  const ListPeople({Key? key, required this.titulo}) : super(key: key);

  final String titulo;

  @override
  State<ListPeople> createState() => _ListPeopleState();
}

class _ListPeopleState extends State<ListPeople> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.titulo),
      ),
      body: const Center(
        child: Text('Lista de personas'),
      ),
    );
  }
}
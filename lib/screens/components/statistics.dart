// RESUMEN / ESTADÍSTICAS

import 'package:flutter/material.dart';

class Summary extends StatefulWidget {
  const Summary({Key? key, required this.titulo}) : super(key: key);

  final String titulo;

  @override
  State<Summary> createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.titulo),
      ),
      body: const Center(
        child: Text('Resumen / Estadísticas'),
      ),
    );
  }
}
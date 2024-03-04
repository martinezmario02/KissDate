import 'package:flutter/material.dart';
import 'package:kissdate/root.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var person = {};

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  Future<void> getProfile() async {
    var p = await peopleController.person(personId);
    setState(() {
      person = p;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(person);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Perfil de ${person['name'] ?? ''}'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nombre: ${person['name'] ?? ''}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Edad: ${person['age'] ?? ''}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Nacionalidad: ${person['nationality'] ?? ''}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Relación: ${person['relationship'] ?? ''}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Fecha del beso: ${person['kiss_date'] != null ? formatDate(person['kiss_date']) : ''}',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  String formatDate(DateTime? date) {
    if (date != null) {
      return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year.toString()}';
    }
    return '';
  }
}

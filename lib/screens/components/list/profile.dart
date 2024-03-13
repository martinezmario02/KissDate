import 'package:flutter/material.dart';
import 'package:kissdate/root.dart';

/// Widget to show the profile of a person.
class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var person = {};
  bool isLoading = true; // Variable to track loading state

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  Future<void> getProfile() async {
    // Simulate loading delay with Future.delayed
    await Future.delayed(const Duration(milliseconds: 10));

    var p = await peopleController.person(personId);
    setState(() {
      person = p;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Perfil de ${person['list']?['name'] ?? ''}'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(), // Show loading indicator
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nombre: ${person['list']?['name'] ?? ''}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Edad: ${person['list']?['age'] ?? ''}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Género: ${person['list']?['gender'] ?? ''}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Nacionalidad: ${person['list']?['nationality'] ?? ''}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Relación: ${person['list']?['relationship'] ?? ''}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Fecha del beso: ${person['list']?['kiss_date'] != null ? formatDate(person['kiss_date']) : ''}',
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

import 'package:flutter/material.dart';
import '../../controllers/users_controller.dart';

UserController userController = UserController();

// Mostrar lista de personas
class ListPeople extends StatefulWidget {
  const ListPeople({Key? key, required this.titulo}) : super(key: key);

  final String titulo;

  @override
  State<ListPeople> createState() => _ListPeopleState();
}

class _ListPeopleState extends State<ListPeople> {
  var users = [];

  Future<void> getUsers() async{
    var u = await userController.users();
    setState(() {
      users = u;
    });
  }

  @override
  Widget build(BuildContext context) {
    getUsers();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.titulo),
      ),
      body: Center(
        //child: Text('Lista de personas'),
        child: Text(users.toString())
      ),
    );
  }
}
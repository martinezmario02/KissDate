// LISTA DE PERSONAS

import 'package:flutter/material.dart';
import 'package:kissdate/root.dart';

class ListPeople extends StatefulWidget {
  const ListPeople({Key? key, required this.titulo}) : super(key: key);

  final String titulo;

  @override
  State<ListPeople> createState() => _ListPeopleState();
}

class _ListPeopleState extends State<ListPeople> {
  var users = [];
  var list = [];

  Future<void> getUsers() async {
    var u = await userController.users();
    setState(() {
      users = u;
    });
  }

  Future<void> getList() async {
    var p = await peopleController.list(userId);
    setState(() {
      list = p;
    });
  }

  @override
  Widget build(BuildContext context) {
    //getUsers();
    getList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.titulo),
      ),
      body: Center(
          //child: Text('Lista de personas'),
          child: Text(list.toString())),
    );
  }
}

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
    getList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.titulo),
      ),
      body: Center(
        //child: Text('Lista de personas'),
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index){
            DateTime date = list[index]['list']['kiss_date'];
            String dateFormat = '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year.toString()}';
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child:Container(
                height: 70,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 157, 180),
                  borderRadius: BorderRadius.circular(20), // Ajusta el radio según sea necesario
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    Text(list[index]['list']['name'], style: const TextStyle(fontFamily: 'Cuerpo', fontSize: 18)),
                    Text(dateFormat)
                  ]
                ),
              )
            );
          }     
        ),
      )
    );
  }
}

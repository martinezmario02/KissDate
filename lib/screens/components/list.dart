import 'package:flutter/material.dart';
import 'package:kissdate/root.dart';
import 'package:kissdate/screens/profile.dart';

class ListPeople extends StatefulWidget {
  const ListPeople({super.key, required this.titulo});

  final String titulo;

  @override
  State<ListPeople> createState() => _ListPeopleState();
}

class _ListPeopleState extends State<ListPeople> {
  var users = [];
  var list = [];

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  Future<void> getUsers() async {
    var u = await userController.users();
    setState(() {
      users = u;
    });
    getList();
  }

  Future<void> getList() async {
    var p = await peopleController.list(userId);
    setState(() {
      list = p;
    });
  }

  Future<void> deleteFromList(int id) async{
    await peopleController.deleteFromList(id);
    getList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.titulo),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            DateTime date = list[index]['list']['kiss_date'];
            String dateFormat =
                '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year.toString()}';
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    personId = list[index]['list']['person_id'];
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Profile(),
                      ),
                    );
                  },
                  child: Card(
                    color: const Color.fromARGB(255, 255, 157, 180),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                list[index]['list']['name'],
                                style: const TextStyle(fontFamily: 'Cuerpo', fontSize: 18),
                              ),
                              Text(dateFormat),
                            ],
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context){
                                  return AlertDialog(
                                    title: const Text('CONFIRMACIÓN'),
                                    content: const Text('¿Desea eliminar esta persona de la lista?'),
                                    actions: [
                                      TextButton(
                                        onPressed: (){
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Cancelar')
                                      ),
                                      TextButton(
                                        onPressed: (){
                                          deleteFromList(list[index]['list']['person_id']);
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Confirmar')
                                      )
                                    ],
                                  );
                                }
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

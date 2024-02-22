import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //тут

  late String _userToDO;
  List todoList = [];

  @override
  void initState() {
    super.initState();

    todoList.addAll(['Buy Milk', 'Wash dishes', 'Купить картошку']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text("Список важных дел"),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('items').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) return const Text('Нет записей');
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                //чтобы удалять свайпом
                key: Key(snapshot.data.docs[index].id), //те данные которые мы получаем - snapshot
                child: Card(
                  child: ListTile(
                    trailing: IconButton(
                        onPressed: () {
                          FirebaseFirestore.instance.collection('items').doc(snapshot.data.docs[index].id).delete();
                        },
                        icon: const Icon(
                          Icons.delete_sweep,
                          color: Colors.amber,
                        )),
                    title: Text(snapshot.data.docs[index].get('item')),
                  ),
                ),
                onDismissed: (direction) {
                  FirebaseFirestore.instance.collection('items').doc(snapshot.data.docs[index].id).delete();
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Добавить элемент'),
                  content: TextField(
                    onChanged: (String value) {
                      _userToDO = value;
                    },
                  ),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          FirebaseFirestore.instance.collection('items').add({
                            'iten': _userToDO
                          }); //добавление в базу то что ввел юзер

                          Navigator.of(context).pop();
                        },
                        child: const Text('Добавить'))
                  ],
                );
              });
        },
        child: const Icon(
          Icons.add_box,
          color: Colors.white,
        ),
      ),
    );
  }
}

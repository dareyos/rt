import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String _userToDO;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 173, 230, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(251, 44, 206, 0.992),
        title: const Text(
          "СПИСОК ВАЖНЫХ ДЕЛ",
          style: TextStyle(
              color: Color.fromRGBO(92, 2, 78, 1), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('items').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Загрузка...',
                style: TextStyle(
                    color: Color.fromRGBO(92, 2, 78, 1),
                    fontSize: 32,
                    fontWeight: FontWeight.bold));
          }
          if (snapshot.hasError) {
            return const Text('Ошибка получения данных',
                style: TextStyle(
                    color: Color.fromRGBO(92, 2, 78, 1),
                    fontSize: 32,
                    fontWeight: FontWeight.bold));
          }
          if (snapshot.data!.docs.isEmpty) {
            return const Text('Записей нет',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(92, 2, 78, 1),
                    fontSize: 32,
                    fontWeight: FontWeight.bold));
          }
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                //чтобы удалять свайпом
                key: Key(snapshot.data!.docs[index]
                    .id), //те данные которые мы получаем - snapshot
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  elevation: 1,
                  child: ListTile(
                    trailing: IconButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('items')
                              .doc(snapshot.data?.docs[index].id)
                              .delete();
                        },
                        icon: const Icon(
                          Icons.delete_sweep,
                          color: Color.fromRGBO(251, 44, 206, 0.992),
                        )),
                    title: Text(snapshot.data?.docs[index].get('item')),
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Изменить элемент'),
                                    content: TextField(
                                      onChanged: (String value) {
                                        _userToDO = value;
                                      },
                                    ),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () {
                                            FirebaseFirestore.instance
                                                .collection('items')
                                                .doc(snapshot
                                                    .data?.docs[index].id)
                                                .update({
                                              'item': _userToDO,
                                            }); //изменение в базе то что ввел юзер

                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Подтвердить'))
                                    ],
                                  );
                                });
                          },
                          child: const Icon(
                            Icons.edit,
                            color: Colors.purple,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                onDismissed: (direction) {
                  FirebaseFirestore.instance
                      .collection('items')
                      .doc(snapshot.data?.docs[index].id)
                      .delete();
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(251, 44, 206, 0.992),
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
                            'item': _userToDO,
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rt/widgets/update_task_dialog.dart';

import '../utils/colors.dart';
import '../widgets/delete_task_dialog.dart';

class Tasks extends StatefulWidget {
  const Tasks({Key? key}) : super(key: key);
  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  final fireStore = FirebaseFirestore.instance; //записываем в отдельную переменную строчку для взаимодействия с бд

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: StreamBuilder<QuerySnapshot>(
        stream: fireStore.collection('tasks').snapshots(), //получаем данные о заметках в бд
        builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Загрузка...');
        }
        else if (snapshot.hasError) {
          return const Text('Ошибка получения данных');
        }
        else if (snapshot.data!.docs.isEmpty) {
          return const Text('Записей нет');
          } else {
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                Color taskColor = AppColors.blueShadeColor;
                var taskTag = data['taskTag'];
                if (taskTag == 'Дела по учебе/работе') {
                  taskColor = AppColors.salmonColor;
                } else if (taskTag == 'Дела по дому') {
                  taskColor = AppColors.greenShadeColor;
                }
                return Container(
                  height: 100,
                  margin: const EdgeInsets.only(bottom: 20.0), //округляем наши кнопочки
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0), //округляем наши окошечки
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.shadowColor,
                        blurRadius: 5.0,
                        offset: Offset(0, 5), // shadow direction: bottom right
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading: Container(
                      width: 20,
                      height: 20,
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        backgroundColor: taskColor,
                      ),
                    ),
                    title: Text(data['taskName']),
                    subtitle: Text(data['taskDesc']),
                    isThreeLine: true,
                    trailing: PopupMenuButton(
                      color: AppColors.firstPrimeryColor,
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            value: 'edit',
                            child: const Text(
                              'Редактировать',
                              style: TextStyle(fontSize: 14.0, color: AppColors.secondPrimeryColor),
                            ),
                            onTap: () {
                              String taskId = (data['id']);
                              String taskName = (data['taskName']);
                              String taskDesc = (data['taskDesc']);
                              String taskTag = (data['taskTag']);
                              Future.delayed(
                                const Duration(seconds: 0),
                                () => showDialog(
                                  context: context,
                                  builder: (context) => UpdateTaskAlertDialog(taskId: taskId, taskName: taskName, taskDesc: taskDesc, taskTag: taskTag,),
                                ),
                              );
                            },
                          ),
                          PopupMenuItem(
                            value: 'delete',
                            child: const Text(
                              'Удалить',
                              style: TextStyle(fontSize: 14.0, color: AppColors.secondPrimeryColor),
                            ),
                            onTap: (){
                              String taskId = (data['id']);
                              String taskName = (data['taskName']);
                              Future.delayed(
                                const Duration(seconds: 0),
                                    () => showDialog(
                                  context: context,
                                  builder: (context) => DeleteTaskDialog(taskId: taskId, taskName:taskName),
                                ),
                              );
                            },
                          ),
                        ];
                      },
                    ),
                    dense: true,
                  ),
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rt/utils/colors.dart';
//import 'package:fluttertoast/fluttertoast.dart';

class DeleteTaskDialog extends StatefulWidget {
  final String taskId, taskName;

  const DeleteTaskDialog(
      {Key? key, required this.taskId, required this.taskName})
      : super(key: key);

  @override
  State<DeleteTaskDialog> createState() => _DeleteTaskDialogState();
}

class _DeleteTaskDialogState extends State<DeleteTaskDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.firstPrimeryColor,
      scrollable: true,
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Удаление',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16,
                color: AppColors.secondPrimeryColor,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 2,),
          Icon(Icons.delete, color: AppColors.secondPrimeryColor,),
        ],
      ),
      content: SizedBox(
        child: Form(
          child: Column(
            children: <Widget>[
              const Text(
                'Удаленные данные не подлежат восстановлению!',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 16),
              Text(
                widget.taskName.toString(),
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              child: const Text('Отменить', style: TextStyle(color: AppColors.secondPrimeryColor),),
            ),
            const SizedBox(
              width: 16,
            ),
            ElevatedButton(
              onPressed: () {
                _deleteTasks();
                Navigator.of(context, rootNavigator: true).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              child: const Text('Удалить', style: TextStyle(color: AppColors.secondPrimeryColor),),
            ),
          ],
        ),
      ],
    );
  }

  Future _deleteTasks() async {
    var collection = FirebaseFirestore.instance.collection('tasks');
    collection.doc(widget.taskId).delete();
  }
}

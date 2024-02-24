import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rt/utils/colors.dart';

class AddTaskAlertDialog extends StatefulWidget {
  const AddTaskAlertDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<AddTaskAlertDialog> createState() => _AddTaskAlertDialogState();
}

class _AddTaskAlertDialogState extends State<AddTaskAlertDialog> {
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescController = TextEditingController();
  final List<String> taskTags = ['Дела по учебе/работе', 'Дела по дому', 'Другие дела'];
  late String selectedValue = '';

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return AlertDialog(
      backgroundColor: AppColors.firstPrimeryColor,
      scrollable: true,
      title: const Text(
        'Создать заметку',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, color:AppColors.secondPrimeryColor, fontWeight: FontWeight.bold),
      ),
      content: SizedBox(
        height: height * 0.35,
        width: width,
        child: Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: taskNameController,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  hintText: 'Заметка',
                  hintStyle: const TextStyle(fontSize: 14),
                  icon: const Icon(Icons.assignment_add, color: AppColors.secondPrimeryColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15), 
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: taskDescController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  hintText: 'Описание',
                  hintStyle: const TextStyle(fontSize: 14),
                  icon: const Icon(Icons.bookmark_add_outlined, color: AppColors.secondPrimeryColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: <Widget>[
                  const Icon(Icons.tag, color: AppColors.secondPrimeryColor),
                  const SizedBox(width: 15.0),
                  Expanded(
                    child: DropdownButtonFormField2(
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      isExpanded: true,
                      hint: const Text(
                        'Тег',
                        style: TextStyle(fontSize: 14),
                      ),
                      buttonHeight: 60,
                      buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      items: taskTags
                          .map(
                            (item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (String? value) => setState(() {
                          if (value != null) selectedValue = value;
                        },
                      ),
                    ),
                  ),
                ],
              ),
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
         const SizedBox(width: 16,),
        ElevatedButton(
          onPressed: () {
            final taskName = taskNameController.text;
            final taskDesc = taskDescController.text;
            final taskTag = selectedValue;
            _addTasks(taskName: taskName, taskDesc: taskDesc, taskTag: taskTag);
            Navigator.of(context, rootNavigator: true).pop();
          },
          child: const Text('Добавить', style: TextStyle(color: AppColors.secondPrimeryColor)),
        ),
         ],
        ),
      ],
    );
  }

  Future _addTasks({required String taskName, required String taskDesc, required String taskTag}) async {
    DocumentReference docRef = await FirebaseFirestore.instance.collection('tasks').add(
      {
        'taskName': taskName,
        'taskDesc': taskDesc,
        'taskTag': taskTag,
      },
    );
    String taskId = docRef.id;
    await FirebaseFirestore.instance.collection('tasks').doc(taskId).update(
      {'id': taskId},
    );
    _clearAll();
  }

  void _clearAll() {
    taskNameController.text = '';
    taskDescController.text = '';
  }
}

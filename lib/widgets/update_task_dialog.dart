import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:rt/utils/colors.dart';

class UpdateTaskAlertDialog extends StatefulWidget {
  final String taskId, taskName, taskDesc, taskTag;

  const UpdateTaskAlertDialog(
      {Key? Key,
      required this.taskId,
      required this.taskName,
      required this.taskDesc,
      required this.taskTag})
      : super(key: Key);

  @override
  State<UpdateTaskAlertDialog> createState() => _UpdateTaskAlertDialogState();
}

class _UpdateTaskAlertDialogState extends State<UpdateTaskAlertDialog> {
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescController = TextEditingController();
  final List<String> taskTags = [
    'Дела по учебе/работе',
    'Дела по дому',
    'Другие дела'
  ];
  String selectedValue = '';

  @override
  Widget build(BuildContext context) {
    taskNameController.text = widget.taskName;
    taskDescController.text = widget.taskDesc;

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return AlertDialog(
      backgroundColor: AppColors.firstPrimeryColor,
      scrollable: true,
      title: const Text(
        'Редактирование заметки',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 16,
            color: AppColors.secondPrimeryColor,
            fontWeight: FontWeight.bold),
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
                  icon: const Icon(Icons.assignment_add,
                      color: AppColors.secondPrimeryColor),
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
                  icon: const Icon(Icons.bookmark_add_outlined,
                      color: AppColors.secondPrimeryColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: <Widget>[
                  const Icon(Icons.tag,
                      color: AppColors.secondPrimeryColor),
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
                      value: widget.taskTag,
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
                      onChanged: (String? value) => setState(
                        () {
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
              child: const Text(
                'Отменить',
                style: TextStyle(color: AppColors.secondPrimeryColor),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            ElevatedButton(
              onPressed: () {
                final taskName = taskNameController.text;
                final taskDesc = taskDescController.text;
                var taskTag = '';
                selectedValue == ''
                    ? taskTag = widget.taskTag
                    : taskTag = selectedValue;
                _updateTasks(taskName, taskDesc, taskTag);
                Navigator.of(context, rootNavigator: true).pop();
              },
              child: const Text(
                'Редактировать',
                style: TextStyle(color: AppColors.secondPrimeryColor),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future _updateTasks(String taskName, String taskDesc, String taskTag) async {
    var collection = FirebaseFirestore.instance.collection('tasks');
    collection.doc(widget.taskId).update(
        {'taskName': taskName, 'taskDesc': taskDesc, 'taskTag': taskTag});
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rt/utils/colors.dart';
import '../widgets/add_task_dialog.dart';
import 'tasks.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController pageController = PageController(initialPage: 1); //вылет списка дел

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.firstPrimeryColor,
      appBar: AppBar(
        backgroundColor: AppColors.secondPrimeryColor,
        centerTitle: true,
        title: const Text("мой список дел", style: TextStyle(color: Colors.white),),
      ),
      extendBody: true, //виджет, нижний отступ которого соответствует высоте bottomNavigationBar.
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked, //расположение кнопки плюс
      floatingActionButton: FloatingActionButton( //кнопочка добавить
        backgroundColor: AppColors.secondPrimeryColor,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const AddTaskAlertDialog(); //возвращаем окно прописанное в файле виджетс
            },
          );
        },
        child: const Icon(Icons.add, color: Colors.white, size: 30,),
      ),
      
      body: PageView( //наши заметочки
        controller: pageController,
        children: const <Widget>[
          Center(
            child: Tasks(),
          ),
        ],
      ),
    );
  }
}

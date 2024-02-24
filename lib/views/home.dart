import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/add_task_dialog.dart';
import 'tasks.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 235, 220, 178),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 102, 46, 28),
        centerTitle: true,
        title: const Text("мой список дел", style: TextStyle(color: Colors.white),),
      ),
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const AddTaskAlertDialog();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const BottomAppBar(
        child: SizedBox(
          height: kBottomNavigationBarHeight,
        ),
      ),
      body: PageView(
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

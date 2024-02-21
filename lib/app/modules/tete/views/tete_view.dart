import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/tete_controller.dart';

class TeteView extends GetView<TeteController> {
  const TeteView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TeteView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TeteView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

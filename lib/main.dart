import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:rt/pages/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // строка позволяет запустить firebase до запуска приложения
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MaterialApp(
    home: Home(),
  ));
}
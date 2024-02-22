import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:rt/pages/home.dart';

// void main() => runApp(MaterialApp(
//   theme: ThemeData(
//     primaryColor: Colors.orange,
//   ),
//   home: Home(),
//   ));

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // строка позволяет запустить firebase до запуска приложения
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MaterialApp(
    home: Home(),
  ));
}

// class MainApp extends StatelessWidget {
//   const MainApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: Scaffold(
//         body: Center(
//           child: Text('Hello World!'),
//         ),
//       ),
//     );
//   }
// }
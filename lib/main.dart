import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bindings/todo_binding.dart';
import 'screens/todos_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: TodoBinding(),
      title: 'TODOS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TodosScreen(),
    );
  }
}

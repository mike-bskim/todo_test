import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/providers.dart';
import 'screens/todos_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //MultiProvider 추가
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TodoList>(create: (context) => TodoList()),
        ChangeNotifierProvider<TodoFilter>(create: (context) => TodoFilter()),
        ChangeNotifierProvider<TodoSearch>(create: (context) => TodoSearch()),
        ChangeNotifierProxyProvider3<TodoFilter, TodoSearch, TodoList,
            FilteredTodos>(
          create: (context) => FilteredTodos(),
          update: (
            BuildContext context,
            TodoFilter todoFilter,
            TodoSearch todoSearch,
            TodoList todoList,
            FilteredTodos? filteredTodos,
          ) =>
              filteredTodos!..update(todoFilter, todoSearch, todoList),
        ),
        ChangeNotifierProxyProvider<TodoList, TodoActiveCount>(
          create: (context) => TodoActiveCount(),
          update: (
            BuildContext context,
            TodoList todoList,
            TodoActiveCount? todoActiveCount,
          ) =>
              todoActiveCount!..update(todoList),
        )
      ],
      child: MaterialApp(
        title: 'TODOS',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const TodosScreen(),
      ),
    );
  }
}

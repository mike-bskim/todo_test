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
        ProxyProvider3<TodoFilter, TodoSearch, TodoList, FilteredTodos>(
          // create: (context) => FilteredTodos(
          //   initFilteredTodos: context.read<TodoList>().state.todos,
          // ),
          update: (
            BuildContext context,
            TodoFilter todoFilter,
            TodoSearch todoSearch,
            TodoList todoList,
            FilteredTodos? _,
          ) =>
              FilteredTodos(
            todoList: todoList,
            todoFilter: todoFilter,
            todoSearch: todoSearch
          ),
        ),
        ProxyProvider<TodoList, TodoActiveCount>(
          // create: (context) => TodoActiveCount(
          //   initTodoActiveCount: context.read<TodoList>().state.todos.length,
          // ),
          // 생성시 TodoList 를 확인해서 초기화하지 않아도 update 시 처리됨.
          update: (
            BuildContext context,
            TodoList todoList,
            TodoActiveCount? _,
          ) =>
              TodoActiveCount(todoList: todoList),
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

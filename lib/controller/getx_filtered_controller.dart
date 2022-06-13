// import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/todo_model.dart';
// import '../provider/providers.dart';

class GetXFilteredController extends GetxController {
  static GetXFilteredController get to => Get.find();
  RxList<Todo> filteredTodos = <Todo>[].obs;



  void filteredTodosUpdate(
    Filter filter,
    String searchWord,
    List<Todo> todos,
  ) {
    List<Todo> _filteredTodos;

    // 핵심 부분. 필터의 조건에 맞는 리스트를 만드는 기능
    switch (filter) {
      case Filter.active:
        _filteredTodos = todos.where((Todo todo) => !todo.completed).toList();
        break;
      case Filter.completed:
        _filteredTodos = todos.where((Todo todo) => todo.completed).toList();
        break;
      case Filter.all:
      default:
        _filteredTodos = todos;
        break;
    }
    // 로직 추가
    if (searchWord.isNotEmpty) {
      _filteredTodos = _filteredTodos
          .where((Todo todo) => todo.desc.toLowerCase().contains(searchWord))
          .toList();
    }
    filteredTodos.clear();
    filteredTodos.addAll(_filteredTodos);
  }
}

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../models/todo_model.dart';

class TodoListState extends Equatable {
  final List<Todo> todos;
  const TodoListState({
    required this.todos,
  });

  factory TodoListState.init() {
    return TodoListState(todos: [
      Todo(id: '1', desc: 'Clean the room'),
      Todo(id: '2', desc: 'Wash the dish'),
      Todo(id: '3', desc: 'Do homework'),
    ]);
  }

  @override
  List<Object> get props => [todos];

  // @override
  // bool get stringify => true;

  @override
  String toString() {
    return 'TodoListState{todos: $todos}';
  }

  TodoListState copyWith({
    List<Todo>? todos,
  }) {
    return TodoListState(
      todos: todos ?? this.todos,
    );
  }
}

class TodoList with ChangeNotifier {
  TodoListState _state = TodoListState.init();
  TodoListState get state => _state;

  // 리스트 추가
  void addTodo(String todoDesc) {
    int? newNum;
    if(_state.todos.isEmpty){
      newNum = 1;
    } else {
      // 마지막 id 에서 1 증가
      newNum = int.parse(_state.todos.last.id)+1;
    }
    final newTodo = Todo(id: newNum.toString(),desc: todoDesc);
    final newTodos = [..._state.todos, newTodo];

    // 리스트 새로 복사&생성
    _state = _state.copyWith(todos: newTodos);
    notifyListeners();
  }

  void toggleTodo(String id) {
    final newTodos = _state.todos.map((Todo todo) {
      // 해당 리스트만 토글
      if (todo.id == id) {
        return Todo(
          id: id,
          desc: todo.desc,
          completed: !todo.completed,
        );
      }
      // 다른 리스트는 그대로 리턴
      return todo;
    }).toList();

    // 토글된 리스트 새로 복사&생성
    _state = _state.copyWith(todos: newTodos);
    notifyListeners();
  }

}

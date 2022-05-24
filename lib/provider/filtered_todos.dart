import 'package:equatable/equatable.dart';
import 'package:state_notifier/state_notifier.dart';

import '../models/todo_model.dart';
import 'providers.dart';

class FilteredTodosState extends Equatable {
  final List<Todo> filteredTodos;

  const FilteredTodosState({
    required this.filteredTodos,
  });

  factory FilteredTodosState.initial() {
    return const FilteredTodosState(filteredTodos: []);
  }

  @override
  List<Object> get props => [filteredTodos];

  @override
  bool get stringify => true;

  FilteredTodosState copyWith({
    List<Todo>? filteredTodos,
  }) {
    return FilteredTodosState(
      filteredTodos: filteredTodos ?? this.filteredTodos,
    );
  }
}

class FilteredTodos extends StateNotifier<FilteredTodosState>
    with LocatorMixin {
  FilteredTodos() : super(FilteredTodosState.initial());

  @override
  void update(Locator watch) {
    final Filter filter = watch<TodoFilterState>().filter;
    final String searchTerm = watch<TodoSearchState>().searchTerm;
    final List<Todo> todos = watch<TodoListState>().todos;

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
    if (searchTerm.isNotEmpty) {
      _filteredTodos = _filteredTodos
          .where((Todo todo) => todo.desc.toLowerCase().contains(searchTerm))
          .toList();
    }
    state = state.copyWith(filteredTodos: _filteredTodos);

    super.update(watch);
  }

// final TodoList todoList;
// final TodoFilter todoFilter;
// final TodoSearch todoSearch;
// FilteredTodos({
//   required this.todoList,
//   required this.todoFilter,
//   required this.todoSearch,
// });

// FilteredTodosState get state {
//   List<Todo> _filteredTodos;
//
//   // 핵심 부분. 필터의 조건에 맞는 리스트를 만드는 기능
//   switch (todoFilter.state.filter) {
//     case Filter.active:
//       _filteredTodos =
//           todoList.state.todos.where((Todo todo) => !todo.completed).toList();
//       break;
//     case Filter.completed:
//       _filteredTodos =
//           todoList.state.todos.where((Todo todo) => todo.completed).toList();
//       break;
//     case Filter.all:
//     default:
//       _filteredTodos = todoList.state.todos;
//       break;
//   }
//   // 로직 추가
//   if (todoSearch.state.searchTerm.isNotEmpty) {
//     _filteredTodos = _filteredTodos
//         .where((Todo todo) =>
//             todo.desc.toLowerCase().contains(todoSearch.state.searchTerm))
//         .toList();
//   }
//
//   return FilteredTodosState(filteredTodos: _filteredTodos);
// }
}

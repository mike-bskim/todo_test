import 'package:equatable/equatable.dart';
// import 'package:flutter/foundation.dart';
import 'package:state_notifier/state_notifier.dart';

import '../models/todo_model.dart';

class TodoFilterState extends Equatable {
  final Filter filter;
  const TodoFilterState({
    required this.filter,
  });

  factory TodoFilterState.init() {
    return const TodoFilterState(filter: Filter.all);
  }

  @override
  List<Object> get props => [filter];

  @override
  bool get stringify => true;

  TodoFilterState copyWith({
    Filter? filter,
  }) {
    return TodoFilterState(
      filter: filter ?? this.filter,
    );
  }
}

class TodoFilter extends StateNotifier<TodoFilterState> {
  // TodoFilterState _state = ;
  // TodoFilterState get state => _state;
  // TodoFilter(super.state);
  TodoFilter() : super(TodoFilterState.init());

  void changeFilter(Filter newFilter) {
    state = state.copyWith(filter: newFilter);
    // notifyListeners();
  }
}
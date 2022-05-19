import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

// unique 번호 생성
Uuid uuid = const Uuid();

class Todo extends Equatable{
  final String id;
  final String desc;
  final bool completed;

  // id 값을 넣지않으면 id값을 자동 초기화 함.
  Todo({
    String? id,
    required this.desc,
    this.completed = false,
  }) : id = id ?? uuid.v4();

  @override
  // TODO: implement props
  List<Object?> get props => [id, desc, completed];

  @override
  String toString() {
    return 'Todo{id: $id, completed: $completed, desc: $desc}';
  }
}

enum Filter {
  all,
  active,
  completed,
}
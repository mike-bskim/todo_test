import 'package:flutter/material.dart';

class TodosScreen extends StatefulWidget {
  const TodosScreen({Key? key}) : super(key: key);

  @override
  State<TodosScreen> createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
            child: Column(
              children: const [
                TodoHeader(),
                CreateTodo(),
                SizedBox(height: 20.0),
                SearchAndFilterTodo(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TodoHeader extends StatelessWidget {
  const TodoHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text(
          'TODO',
          style: TextStyle(fontSize: 40.0),
        ),
        Text(
          '0 items left',
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.redAccent,
          ),
        ),
      ],
    );
  }
}

class CreateTodo extends StatefulWidget {
  const CreateTodo({Key? key}) : super(key: key);

  @override
  _CreateTodoState createState() => _CreateTodoState();
}

class _CreateTodoState extends State<CreateTodo> {
  final newTodoController = TextEditingController();

  @override
  void dispose() {
    newTodoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: newTodoController,
      decoration: const InputDecoration(labelText: 'What to do?'),
      onFieldSubmitted: (String? todoDesc) {
        debugPrint('CreateTodo Clicked: ${newTodoController.text}');
        // if (todoDesc != null && todoDesc.trim().isNotEmpty) {
        //   context.read<TodoList>().addTodo(todoDesc);
        //   newTodoController.clear();
        // }
      },
    );
  }
}


class SearchAndFilterTodo extends StatelessWidget {
  const SearchAndFilterTodo({Key? key}) : super(key: key);
  // final debounce = Debounce(milliseconds: 1000);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Search todos',
            border: InputBorder.none,
            filled: true,
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: (String? newSearchTerm) {
            debugPrint('Search todos: $newSearchTerm');
            // if (newSearchTerm != null) {
            //   debounce.run(() {
            //     context.read<TodoSearch>().setSearchTerm(newSearchTerm);
            //   });
            // }
          },
        ),
        const SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            filterButton(context, 'all'),
            filterButton(context, 'active'),
            filterButton(context, 'completed'),
          ],
        ),
      ],
    );
  }

  Widget filterButton(BuildContext context, String filter) { //, Filter filter
    return TextButton(
      onPressed: () {
        // context.read<TodoFilter>().changeFilter(filter);
      },
      child: Text(
        filter == 'all'
            ? 'All'
            : filter == 'active'
            ? 'Active'
            : 'Completed',
        style: TextStyle(
          fontSize: 18.0,
          color: textColor(context, filter),
        ),
      ),
    );
  }

  Color textColor(BuildContext context, String filter) {//Filter filter
    const currentFilter = 'all';//context.watch<TodoFilter>().state.filter
    return currentFilter == filter ? Colors.blue : Colors.grey;
  }
}


import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/feature/data/dto/todos/todo_item.dart';
import 'package:test_app/feature/presentation/todos/bloc/todo_bloc.dart';
import 'package:test_app/feature/presentation/todos/bloc/todo_event.dart';
import 'package:test_app/feature/presentation/todos/bloc/todo_state.dart';
import 'package:test_app/feature/presentation/todos/widgets/card/todo_card.dart';
import 'package:test_app/feature/presentation/todos/widgets/dialogs/create_todo_dioalog.dart';

// class TodoPage extends StatefulWidget {
//   const TodoPage({super.key});

//   @override
//   State<TodoPage> createState() => _TodoPageState();
// }

// class _TodoPageState extends State<TodoPage> {
//   List<TodoItem> _todos = [];
//   final TextEditingController _controller = TextEditingController();
//   String text = '123';

//   void _addTodo() {
//     final text = _controller.text.trim();
//     if (text.isEmpty) {
//       log('Введите значения тудушки!');
//       return;
//     }
//     setState(() {
//       _todos.add(TodoItem(title: text));
//     });
//     Navigator.of(context).pop();
//     _controller.clear();
//   }

//   void _toggleDone(int index) {
//     var todo = _todos[index];
//     setState(() {
//       todo.done = !todo.done;
//     });
//   }

//   void _removeTodo(int index) {
//     setState(() {
//       _todos.removeAt(index);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Mini Todo'),
//           backgroundColor: Colors.blue,
//           actions: [
//             IconButton(
//               onPressed: () {
//                 showDialog(
//                   context: context,
//                   builder: (context) {
//                     return CreateTodoDioalog(
//                       controller: _controller,
//                       onAddTodo: _addTodo,
//                     );
//                   },
//                 );
//               },
//               icon: Icon(Icons.add, color: Colors.white),
//             ),
//           ],
//         ),
//         body: Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               Expanded(
//                 child:
//                     _todos.isEmpty
//                         ? const Center(
//                           child: Text('Пока нет никаких ToDo-tasks'),
//                         )
//                         : ListView.builder(
//                           itemCount: _todos.length,
//                           itemBuilder: (context, index) {
//                             final _item = _todos[index];
//                             return GestureDetector(
//                               onTap: () {
//                                 _toggleDone(index);
//                               },
//                               child: TodoCard(
//                                 status: _item.done,
//                                 title: _item.title,
//                                 onChageStatus: (value) => _toggleDone(index),
//                                 onDeleteTodo: () => _removeTodo(index),
//                               ),
//                             );
//                           },
//                         ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class TodoPage extends StatelessWidget {
  TodoPage({super.key});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return _TodoPageContent(controller: _controller);
  }
}

class _TodoPageContent extends StatelessWidget {
  final TextEditingController controller;

  const _TodoPageContent({Key? key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Mini Todo'),
          backgroundColor: Colors.blue,
          actions: [
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return CreateTodoDioalog(
                      controller: controller,
                      onAddTodo: () {
                        final text = controller.text.trim();
                        context.read<TodoBloc>().add(AddTodo(text));
                        Navigator.of(context).pop();
                        controller.clear();
                      },
                    );
                  },
                );
              },
              icon: Icon(Icons.add, color: Colors.white),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: BlocConsumer<TodoBloc, TodoState>(
                  listener: (context, state) {
                    if (state is TodoLoaded) {
                      log('Тудушки загружены, количество: ${state.todos.length}');
                    }
                  },
                  builder: (context, state) {
                    if (state is TodoLoaded) {
                      final todo = state.todos;

                      if (todo.isEmpty) {
                        return const Center(
                          child: Text('Пока нет никаких ToDo-tasks'),
                        );
                      }

                      return ListView.builder(
                        itemCount: todo.length,
                        itemBuilder: (context, index) {
                          final _item = todo[index];
                          return GestureDetector(
                            key: ValueKey('todo_${index}_${_item.title}_${_item.done}'),
                            onTap: () {
                              context.read<TodoBloc>().add(ToggleDone(index));
                            },
                            child: TodoCard(
                              status: _item.done,
                              title: _item.title,
                              onChageStatus:
                                  (value) {
                                    log('Toggling todo at index $index, current status: ${_item.done}');
                                    context.read<TodoBloc>().add(
                                      ToggleDone(index),
                                    );
                                  },
                              onDeleteTodo:
                                  () {
                                    log('Removing todo at index $index');
                                    context.read<TodoBloc>().add(
                                      RemoveTodo(index),
                                    );
                                  },
                            ),
                          );
                        },
                      );
                    }

                    return Center(child: CircularProgressIndicator());
                  },
                ),
                // _todos.isEmpty
                //     ? const Center(
                //       child: Text('Пока нет никаких ToDo-tasks'),
                //     )
                //     : ListView.builder(
                //       itemCount: _todos.length,
                //       itemBuilder: (context, index) {
                //         final _item = _todos[index];
                //         return GestureDetector(
                //           onTap: () {
                //             _toggleDone(index);
                //           },
                //           child: TodoCard(
                //             status: _item.done,
                //             title: _item.title,
                //             onChageStatus: (value) => _toggleDone(index),
                //             onDeleteTodo: () => _removeTodo(index),
                //           ),
                //         );
                //       },
                //     ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
